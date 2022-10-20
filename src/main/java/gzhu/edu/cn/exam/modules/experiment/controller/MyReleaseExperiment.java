package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Objects;

/**
 * 我发布的实验 前端控制器
 *
 * @author Yinglei Jie on 2021/11/26
 */
@Slf4j
@Controller
@RequestMapping("/experiment/release")
public class MyReleaseExperiment {

    @Resource
    private IUserService userService;

    @Resource
    private IApplyService applyService;

    @GetMapping("/index")
    public String index() {
        return "modules/experiment/my-release-experiment";
    }


    @GetMapping("/list")
    @ResponseBody
    public R list(int page, int limit, String name, Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        IPage<Apply> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Apply> w = new LambdaQueryWrapper<>();
        w.eq(Apply::getApplyUserId, currentUser.getId()).orderByDesc(Apply::getApplyTime);
        if (Objects.nonNull(name) && !name.isEmpty()) {
            w.like(Apply::getName, name);
        }
        applyService.getBaseMapper().selectPage(pageInfo, w);
        return R.ok().put("data", pageInfo);
    }

}
