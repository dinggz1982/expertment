package gzhu.edu.cn.exam.modules.system.controller;

import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.system.entity.RegistryGroup;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2021/11/22
 */
@Slf4j
@Controller
@RequestMapping("/system/registry/")
public class RegistryController {

    @Resource
    private IUserService userService;


    @GetMapping("/toRegistry")
    public String toRegistry() {
        return "registry";
    }

    @PostMapping("/registry")
    @ResponseBody
    public R registry(@RequestBody @Validated(RegistryGroup.class) User user) {
        return userService.registry(user);
    }
}
