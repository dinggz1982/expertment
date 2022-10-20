package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.Approve;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IApproveService;
import gzhu.edu.cn.exam.modules.experiment.vo.LockExperimentVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.Objects;

/**
 * @program: mix-tech
 * @description:管理员审批
 * @author: 丁国柱
 * @create: 2021-05-26 23:19
 */
@Slf4j
@Controller
@RequestMapping("/experiment/adminApprove")
public class AdminApproveController {

    @Resource
    private IUserService userService;

    @Resource
    private IApplyService applyService;

    @Resource
    private IApproveService approveService;


    @GetMapping("/unlockExperiment/{id}")
    @ResponseBody
    public R unlockExperiment(@PathVariable String id) {
        applyService.unlockExperiment(id);
        return R.ok("解锁成功");
    }

    @PostMapping("/lockExperiment")
    @ResponseBody
    public R lockExperiment(@RequestBody LockExperimentVo vo) {
        //锁定实验
        log.debug("前端传值：{}", vo);
        applyService.lockExperiment(vo);
        return R.ok("锁定成功");
    }

    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        return "modules/experiment/adminApprove-vue";
    }

    /**
     * 实验审批分页
     *
     * @param page  分页
     * @param limit 条数
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    @Deprecated
    public PageData<Apply> list(Apply apply, int page, int limit) {
        //获取当前当前用户
        //User currentUser = this.userService.findByName(authentication.getName());
        //apply.setTeacherConfirmUserId(currentUser.getId());
        //apply.setStatus(1);
        return this.applyService.getPage(page, limit, apply);
    }

    @GetMapping("/list")
    @ResponseBody
    public R listData(int page, int limit, Integer type, String search) {
        IPage<Apply> pageInfo = new Page<>(page, limit);
        if (Objects.isNull(search) || search.isEmpty()) {
            LambdaQueryWrapper<Apply> w = new LambdaQueryWrapper<>();
            w.orderByDesc(Apply::getApplyTime);
            if (Objects.nonNull(type)) {
                w.eq(Apply::getStatus, type);
            }
            applyService.getBaseMapper().selectPage(pageInfo, w);
        } else {
            log.debug("search内容：{}", search);
            applyService.listAdminApproveListBySearchContent(pageInfo, type, search);
        }
        return R.ok().put("data", pageInfo);
    }

    /**
     * 实验审批(弃用)
     *
     * @param approve 审批
     * @return
     */
    @PostMapping("save/{applyId}")
    @ResponseBody
    @Deprecated
    public ResonseData saveOrUpdate(@PathVariable Integer applyId, Approve approve, Authentication authentication) throws ParseException {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        ResonseData data = new ResonseData();
        try {
            approve.setApplyId(applyId);
            approve.setApproveUserId(currentUser.getId());
            approve.setType(true);
            this.approveService.saveApprove(approve);
            data.setMsg("成功保存实验审批！");
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存实验申请审批");
        }
        return data;
    }

    /**
     * 新审核逻辑
     * 管理员审核
     *
     * @return r
     */
    @ResponseBody
    @GetMapping("/approve/{applyId}")
    public R approve(@PathVariable String applyId, Integer approve, String reason) {
        //管理员审核
        applyService.adminApprove(applyId, approve, reason);
        return R.ok("成功审核");
    }
}
