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
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.Objects;

/**
 * @program: mix-tech
 * @description: 教师审批
 * @author: 丁国柱
 * @create: 2021-05-26 21:54
 */
@Controller
@RequestMapping("/experiment/teacherApprove")
public class TeacherApproveController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IApplyService applyService;

    @Autowired
    private IApproveService approveService;

    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
//        return "modules/experiment/teacherApprove";
        return "modules/experiment/teacherApprove-vue";
    }

    /**
     * 实验申请分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    @Deprecated
    public PageData<Apply> list(Apply apply, int page, int limit, Authentication authentication) {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        apply.setTeacherConfirmUserId(currentUser.getId());
        //apply.setStatus(1);
        return this.applyService.getPage(page, limit, apply);
    }

    @GetMapping("/getApproveList")
    @ResponseBody
    public R getApproveList(int page, int limit, Integer applyType, Authentication authentication) {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        IPage<Apply> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Apply> w = new LambdaQueryWrapper<>();
        w.eq(Apply::getTeacherConfirmUserId, currentUser.getId())
//                .orderByDesc(Apply)
                .orderByDesc(Apply::getApplyTime);

        if (Objects.nonNull(applyType)) {
            w.eq(Apply::getStatus, applyType);
        }
//                .eq(Apply::getStatus, ApplyType.WAIT_TEACHER.getCode());
        applyService.getBaseMapper().selectPage(pageInfo, w);
        return R.ok().put("data", pageInfo);
    }

    /**
     * 实验审批(弃用)
     *
     * @param approve 审核
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
            approve.setType(false);
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
     *
     * @return r
     */
    @ResponseBody
    @GetMapping("/approve/{applyId}")
    public R approve(@PathVariable String applyId, Integer approve, String reason) {
        applyService.teacherApprove(applyId, approve, reason);
        return R.ok("成功审核");
    }


}
