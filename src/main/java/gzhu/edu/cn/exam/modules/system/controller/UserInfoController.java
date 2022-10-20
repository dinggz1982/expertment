package gzhu.edu.cn.exam.modules.system.controller;

import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * @program: experiment
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-30 23:55
 */
@Controller
@RequestMapping("userInfo")
public class UserInfoController {

    @Autowired
    private IUserService userService;

    @GetMapping({"","/","index"})
    public String index(Model model, Authentication authentication){
        //获取当前当前用户
        User currentUser=  this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        return "modules/user/info";
    }

    /**
     * 更新个人头像
     * @return
     */
    @PostMapping("updateAvatar")
    @ResponseBody
    public Map<String,Object> updateAvatar(@RequestParam("avatar")  String avatar,Authentication authentication){
        Map<String,Object> map = new HashMap<>();
        try{
        //获取当前当前用户
        User currentUser=  this.userService.findByName(authentication.getName());
        currentUser.setAvatar(avatar);
        this.userService.updateById(currentUser);
            map.put("code",200);
            map.put("mgs","更新头像成功！");
        }catch (Exception e){
            map.put("code",200);
            map.put("mgs","更新头像异常！");
        }
        return map;
    }

}