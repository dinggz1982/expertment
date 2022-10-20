package gzhu.edu.cn.exam.modules.experiment.controller;


import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.service.IExpSignupStatisticsService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Objects;

/**
 * <p>
 * 被试实验统计 前端控制器
 * </p>
 *
 * @author loading
 * @since 2021-11-23
 */
@Slf4j
@RestController
@RequestMapping("/exp-signup-statistics")
public class ExpSignupStatisticsController {

    @Resource
    private IUserService userService;

    @Resource
    private IExpSignupStatisticsService expSignupStatisticsService;

    @GetMapping("/getByUserId")
    public R getByUserId(String userId, Authentication authentication) {
        if (Objects.isNull(userId) || userId.isEmpty()) {
            User currentUser = userService.findByName(authentication.getName());
            expSignupStatisticsService.updateByUserId(currentUser.getId());
            return R.ok().put("data", expSignupStatisticsService.getByUserId(currentUser.getId()));
        } else {
            expSignupStatisticsService.updateByUserId(Integer.valueOf(userId));
            return R.ok().put("data", expSignupStatisticsService.getByUserId(Integer.valueOf(userId)));
        }
    }

}
