package gzhu.edu.cn.exam.base.config;

import gzhu.edu.cn.exam.base.exception.LabException;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.utils.AddressUtils;
import gzhu.edu.cn.exam.modules.log.entity.LogInfo;
import gzhu.edu.cn.exam.modules.log.service.ILogInfoService;
import gzhu.edu.cn.exam.modules.system.exception.UserExistException;
import gzhu.edu.cn.exam.modules.system.security.UserUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @author 84271
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
    // 定义错误显示页，error.html
    public static final String DEFAULT_ERROR_VIEW = "error";

    @Resource
    public ILogInfoService logInfoService;

    /**
     * 参数教验错误
     *
     * @param e 错误
     * @return 返回
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public R handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        log.error(e.getMessage(), e);
        return R.error(e.getBindingResult().getFieldError().getDefaultMessage());
    }

    @ExceptionHandler(LabException.class)
    @ResponseBody
    public R handleLabException(LabException e) {
        return R.error(e.getMessage()).put("data", e.getData());
    }

    @ExceptionHandler(UserExistException.class)
    @ResponseBody
    public R handleUserExistException(UserExistException e) {
        R error = R.error(e.getMessage());
        error.put("data", e.getExistList());
        return error;
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public ResonseData handleRuntimeException(RuntimeException e) {
        log.error("发生异常，异常信息为：{}", e.getMessage(), e);
        ResonseData res = new ResonseData();
        res.setCode(-1);
        res.setMsg(e.getMessage());
        return res;
    }

    /**
     * 处理服务器内部异常
     *
     * @param request
     * @param e
     * @param model
     * @return
     */
    @ExceptionHandler(Exception.class) // 所有的异常都是Exception子类
    public String defaultErrorHandler(HttpServletRequest request, Exception e, Model model) { // 出现异常之后会跳转到此方法
        log.error("发生异常，异常信息为：{}", e.getMessage(), e);
        model.addAttribute("exception", e.getLocalizedMessage()); // 将异常对象传递过去
        model.addAttribute("url", request.getRequestURL()); // 获得请求的路径

        LogInfo logInfo = new LogInfo();
        logInfo.setOperation("异常页面");
        logInfo.setMessage(e.getMessage());

        // 设置IP地址
        logInfo.setIp(AddressUtils.getIpAddr(request));

        //获取请求地址
        logInfo.setUrl(AddressUtils.getRequestURL(request));

        // 获取用户信息
        String username = UserUtils.getCurrentUserName();
        if (username != null) {
            logInfo.setUsername(username);
        }

        logInfo.setCreateTime(new Date());
        // 保存系统日志
        logInfoService.save(logInfo);

        return "error/error";
    }

}
