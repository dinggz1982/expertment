package gzhu.edu.cn.exam.modules.experiment.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyConfirmType;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;


/**
 * 被试审批前端控制器
 *
 * @author 84271
 */
@Slf4j
@Controller
@Transactional(rollbackFor = Exception.class)
@RequestMapping("/experiment/studentApprove")
public class StudentApproveController {

    @Resource
    private IUserService userService;

    @Resource
    private IApplyService applyService;

    @Resource
    private ISignupService signupService;

    @Resource
    private ILabService labService;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @Resource
    private IExpSignupStatisticsService expSignupStatisticsService;

    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        LambdaQueryWrapper<Apply> qw = new LambdaQueryWrapper<>();
        qw.eq(Apply::getApplyUserId, currentUser.getId())
                .eq(Apply::getStatus, ApplyType.ADMIN_ACCEPT.getCode())
                .select(Apply::getId, Apply::getName);
        List<Apply> applies = applyService.getBaseMapper().selectList(qw);
        model.addAttribute("apply", JSONUtil.parse(applies));
        return "modules/experiment/studentApprove-vue";
    }


    @GetMapping("/list")
    @ResponseBody
    public R list(int page, int limit, Authentication authentication, Integer applyId, String sortProp, String sortOrder, String filterStatus) {
        User currentUser = this.userService.findByName(authentication.getName());
////        JSONArray filterStatusArray = JSONUtil.parseArray(filterStatus);
//        List<String> list = JSONUtil.parseArray(filterStatus).toList(String.class);
        filterStatus = filterStatus.substring(1, filterStatus.length() - 1);

        IPage<Signup> data = signupService.getPage(page, limit, applyId, currentUser, sortProp, sortOrder, filterStatus);
        List<Signup> list = data.getRecords();
        if (!list.isEmpty()) {
            list.forEach(item -> {
                if (Objects.nonNull(item.getApply())) {
                    item.setLab(labService.getById(item.getApply().getLabId()));
                    User user = userService.getById(item.getApply().getApplyUserId());
                    user.setPassword(null);
                    item.getApply().setApplyUser(user);
                    item.setStatistics(expSignupStatisticsService.getByUserId(item.getSignupUserId()));
                }
                if (Objects.nonNull(item.getLabRecordId())) {
                    item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
                }
                if (Objects.nonNull(item.getSignupUser())) {
                    User signupUser = item.getSignupUser();
                    if (Objects.isNull(signupUser.getIdentity())) {
                        //身份信息为空
                        signupUser.setIdentity("普通用户");
                    }
                }
            });
        }
        return R.ok().put("data", data);
    }


    @Deprecated
    public PageData<Signup> list2(int page, int limit, Authentication authentication, @PathVariable Integer applyId) {
        PageData<Signup> data = signupService.getPage(page, limit, applyId, null);
        List<Signup> list = data.getData();
        if (!list.isEmpty()) {
            list.forEach(item -> {
                if (Objects.nonNull(item.getApply())) {
                    item.setLab(labService.getById(item.getApply().getLabId()));
                    User user = userService.getById(item.getApply().getApplyUserId());
                    user.setPassword(null);
                    item.getApply().setApplyUser(user);
                    item.setStatistics(expSignupStatisticsService.getByUserId(item.getSignupUserId()));
                }
                if (Objects.nonNull(item.getLabRecordId())) {
                    item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
                }
                if (Objects.nonNull(item.getSignupUser())) {
                    User signupUser = item.getSignupUser();
                    if (Objects.isNull(signupUser.getIdentity())) {
                        //身份信息为空
                        signupUser.setIdentity("普通用户");
                    }
                }
            });
        }
        return data;
    }


    @GetMapping("/approve/{applyId}/{signUserId}/{signUpId}/{approve}")
    @ResponseBody
    public R approve(@PathVariable String applyId, @PathVariable String signUserId, @PathVariable int approve, String reason, Authentication authentication, @PathVariable String signUpId) {
        if (approve == 1) {
            //1代表合格
            LambdaUpdateWrapper<Signup> wp = new LambdaUpdateWrapper<>();
            wp.eq(Signup::getApplyId, applyId).eq(Signup::getSignupUserId, signUserId)
                    .set(Signup::getStatus, SignUpType.APPLY_PAST.getCode()).set(Signup::getReason, "");
            this.signupService.update(wp);
        } else {
            LambdaUpdateWrapper<Signup> w = new LambdaUpdateWrapper<>();
            w.eq(Signup::getApplyId, applyId).eq(Signup::getSignupUserId, signUserId)
                    .set(Signup::getStatus, SignUpType.REJECT.getCode()).set(Signup::getReason, reason);
            this.signupService.update(w);
        }
        signupService.initRealHourAndConfirmTypeById(signUpId);
        User currentUser = this.userService.findByName(authentication.getName());
        expSignupStatisticsService.updateByUserId(currentUser.getId());
        applyService.updateStatisticsById(applyId);
        expLabRecordService.updateByApplyId(applyId);
        return R.ok("审核成功");
    }

    @GetMapping("/getApplyConfirmType")
    @ResponseBody
    public R getApplyConfirmType() {
        return R.ok().put("data", ApplyConfirmType.show());
    }

    @ResponseBody
    @GetMapping("/confirmApply/{signUpId}")
    public R confirmApply(@PathVariable String signUpId, String confirm, String hour) {
        signupService.confirmSignUp(signUpId, confirm, hour);
        return R.ok("成功确认");
    }

}
