package gzhu.edu.cn.exam.modules.experiment.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * 被试 我的实验页面控制器 、首页前端控制器
 *
 * @author Yinglei Jie on 2021/10/9
 */
@Slf4j
@Controller
@RequestMapping("/experiment/my")
public class MyExperimentController {

    @Resource
    private IExpSignupStatisticsService expSignupStatisticsService;
    @Resource
    private IUserService userService;
    @Resource
    private IApplyService applyService;
    @Resource
    private ISignupService signupService;
    @Resource
    private IExpTypeService expTypeService;
    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("status", SignUpType.show());
        return "modules/experiment/myExperiment-vue";
    }

    @GetMapping("/index")
    public String index(Model model) {
        model.addAttribute("status", SignUpType.show());
        List<ExpType> list = expTypeService.getBaseMapper().selectList(null);
        model.addAttribute("type", JSONUtil.parse(list));
        return "modules/experiment/my/studnet-index-vue";
    }

    @GetMapping("/list")
    @ResponseBody
    public PageData<Signup> listMyExperiment(int page, int limit, String status, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        return signupService.getMyExperimentPage(page, limit, currentUser.getId(), status);
    }

    @GetMapping("/cancel/{id}")
    @ResponseBody
    public ResonseData cancel(@PathVariable String id) {
        ResonseData data = new ResonseData();
        LambdaQueryWrapper<Signup> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Signup::getId, id);
        Signup signup = signupService.getBaseMapper().selectOne(wrapper);
        if (Objects.nonNull(signup)) {
            signup.setStatus(SignUpType.CANCEL.getCode());
            signupService.updateById(signup);
        }
        data.setCode(200);
        data.setMsg("取消成功");
        return data;
    }


    @GetMapping("/getMyStatistics")
    @ResponseBody
    public R getMyStatistics(Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        return R.ok().put("data", expSignupStatisticsService.getByUserId(currentUser.getId()));
    }


    @GetMapping("/getHourGroupByType")
    @ResponseBody
    public R getHourGroupByType(Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        if (Objects.nonNull(currentUser)) {
            //查询
            return R.ok().put("data", expApplyHourStatisticsService.getHourGroupByType(currentUser.getId()));
        }
        return R.ok();
    }
}
