package gzhu.edu.cn.exam.modules.system.controller;

import gzhu.edu.cn.exam.modules.system.entity.Menu;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IMenuService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Set;

/**
 * @program: exam
 * @description: 后台管理
 * @author: 丁国柱
 * @create: 2021-04-04 22:06
 */
@Controller
public class SystemController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IMenuService menuService;

    /**
     * 后台管理index
     *
     * @return
     */
    @GetMapping("/system/index")
    public String index(Model model, Authentication authentication,String symbol) {
        User currentUser = this.userService.findByName(authentication.getName());
        currentUser.setPassword(null);
        Set<Menu> menus = menuService.getMenusByUser(currentUser);
        model.addAttribute("menus", menus);
        model.addAttribute("currentUser", currentUser);
//        model.addAttribute("jsonCurrentUser", JSONObject.toJSONString(currentUser));
        return "system/index";
    }


    @GetMapping("/system/page/tpl/tpl-password.html")
    public String tplPasswordHtml() {
        return "system/user/tpl-password";
    }

    /**
     * 后台管理的console
     *
     * @return
     */
    @GetMapping("/system/console")
    public String console(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        //直接定位到实验申请
        return "redirect:/experiment/apply";
    }

    /**
     * 判断手机端还是移动端的登录
     *
     * @return
     */
    @GetMapping("/system/go")
    public String go() {
        return "system/go";
    }

}
