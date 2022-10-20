package gzhu.edu.cn.exam.modules.system.security;

import gzhu.edu.cn.exam.modules.log.annotation.Log;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Resource
    private HttpSession session;

    @Resource
    private IUserService userService;

    @Override
    @Log("登录成功")
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        // 获得授权后可得到用户信息 可使用SUserService进行数据库操作
        UserDetails user = (UserDetails) authentication.getPrincipal();
        User currentUser = this.userService.findByName(user.getUsername());
        session.setAttribute("currentUser", currentUser);
        /* Set<SysRole> roles = userDetails.getSysRoles(); */
        // forward ： 可以隐藏url
        // request.getRequestDispatcher("/admin").forward(request, response);
        // 可以针对不同的用户跳转到不同的页面
        response.sendRedirect("/system/go");
        // super.onAuthenticationSuccess(request, response, authentication);
    }


}
