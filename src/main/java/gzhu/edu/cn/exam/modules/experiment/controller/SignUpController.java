package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * @author Yinglei Jie on 2021/12/21
 */
@Slf4j
@Controller
@RequestMapping("/signup/")
public class SignUpController {

    @Resource
    private IUserService userService;

    @Resource
    private ISignupService signupService;

    @Resource
    private IApplyService applyService;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @Resource
    private ILabService labService;


    @GetMapping("/getStatusList")
    @ResponseBody
    public R getStatusList() {
        return R.ok().put("data", SignUpType.show());
    }

    @GetMapping("/getSignUpListByStatus")
    @ResponseBody
    public R getSignUpListByStatus(int page, int limit,
                                   String status, String name,
                                   String startTime, String endTime,
                                   String type, Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        if ("未报名".equals(status)) {
            //未报名单独处理
            IPage<Signup> pageInfo = new Page<>(page, limit);
            signupService.selectUserCanSignUp(pageInfo, currentUser.getId(), name, startTime, endTime, type);
            List<Signup> records = pageInfo.getRecords();
            if (Objects.nonNull(records) && !records.isEmpty()) {
                records.forEach(item -> {
                    if (Objects.nonNull(item.getApplyId())) {
                        Apply apply = applyService.getById(item.getApplyId());
                        item.setApply(apply);
                        if (Objects.nonNull(apply)) {
                            item.setLab(labService.getById(item.getApply().getLabId()));
                        }
                    }
                });
            }
            return R.ok().put("data", pageInfo);
        } else {
            LambdaQueryWrapper<Signup> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(Signup::getSignupUserId, currentUser.getId());
            if (Objects.nonNull(status) && !status.isEmpty()) {
                queryWrapper.eq(Signup::getStatus, status);
            }
            IPage<Signup> pageInfo = new Page<>(page, limit);
            signupService.getBaseMapper().selectPage(pageInfo, queryWrapper);
            List<Signup> records = pageInfo.getRecords();
            if (Objects.nonNull(records) && !records.isEmpty()) {
                records.forEach(item -> {
                    item.setApply(applyService.getById(item.getApplyId()));
                    if (Objects.nonNull(item.getLabRecordId())) {
                        item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
                    }
                    if (Objects.nonNull(item.getApply())) {
                        item.setLab(labService.getById(item.getApply().getLabId()));
                    }
                });
            }
            return R.ok().put("data", pageInfo);
        }
    }

    @Resource
    private IExpTypeService expTypeService;

    @GetMapping("/getApplyTypeList")
    @ResponseBody
    public R getApplyTypeList() {
        List<ExpType> expTypes = expTypeService.getBaseMapper().selectList(null);
        return R.ok().put("data", expTypes);
    }
}
