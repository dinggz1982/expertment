package gzhu.edu.cn.exam.modules.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @program: exam
 * @description: 登录入口
 * @author: 丁国柱
 * @create: 2021-04-30 21:01
 */
@Controller
public class LoginController {

    @GetMapping("login")
    public String login(){
        return "login";
    }


}