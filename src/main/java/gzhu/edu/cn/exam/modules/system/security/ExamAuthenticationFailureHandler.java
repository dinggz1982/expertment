package gzhu.edu.cn.exam.modules.system.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import gzhu.edu.cn.exam.modules.log.annotation.Log;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 认证异常处理器
 * <p>Title : AuthenticationFailureHandler</p>
 * <p>Description : </p>
 * <p>Company : </p>
 *
 * @author 丁国柱
 * @date 2017年12月28日 上午1:25:32
 */
@Service
public class ExamAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    @Log("登录失败")
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        // TODO Auto-generated method stub
        //假设login.jsp在webapp路径下
        //注意：不能访问WEB-INF下的jsp。
//        String strUrl = request.getContextPath() + "/system/user/loginError";
//        request.getSession().setAttribute("ok", 0);
//        request.getSession().setAttribute("message", exception.getLocalizedMessage());
//        request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
//        response.sendRedirect(strUrl);


        //设置返回JSON数据
        response.setContentType("application/json;charset=UTF-8");
        //响应JSON数据
        response.setStatus(401);
        response.getWriter().write(new ObjectMapper().writeValueAsString("用户名或密码错误!"));
    }
}
