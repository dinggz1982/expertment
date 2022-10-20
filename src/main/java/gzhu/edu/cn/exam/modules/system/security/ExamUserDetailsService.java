package gzhu.edu.cn.exam.modules.system.security;

import gzhu.edu.cn.exam.modules.system.entity.Menu;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IMenuService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Service
public class ExamUserDetailsService implements UserDetailsService {

    @Autowired
    private IUserService userService;
    @Autowired
    private IMenuService menuService;

    /**
     * 校验用户
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 本例使用User中的name作为用户名:

        User user = userService.findByName(username);
        if (user == null) {
            throw new UsernameNotFoundException("UserName " + username + " not found");
        }
        Collection<GrantedAuthority> grantedAuths = obtionGrantedAuthorities(user);
        /*
         * //Collection<GrantedAuthority> grantedAuths = new
         * HashSet<GrantedAuthority>(); Set<Role> roles = user.getRoles(); for
         * (Role role : roles) { grantedAuths.add(new
         * SimpleGrantedAuthority(role.getName())); }
         */
        return new org.springframework.security.core.userdetails.User(username, user.getPassword(), grantedAuths);

    }

    public UserDetails loadUserById(Long userId) throws UsernameNotFoundException {
        // 本例使用User中的name作为用户名:
        User user = userService.getById(userId);
        if (user == null) {
            throw new UsernameNotFoundException("userId " + userId + " not found");
        }
        Collection<GrantedAuthority> grantedAuths = obtionGrantedAuthorities(user);
        /*
         * //Collection<GrantedAuthority> grantedAuths = new
         * HashSet<GrantedAuthority>(); Set<Role> roles = user.getRoles(); for
         * (Role role : roles) { grantedAuths.add(new
         * SimpleGrantedAuthority(role.getName())); }
         */
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), grantedAuths);

    }


    // 取得用户的权限
    private Set<GrantedAuthority> obtionGrantedAuthorities(User user) {
        Set<Menu> resources = this.menuService.getResourceByUser(user);
        Set<GrantedAuthority> authSet = new HashSet<GrantedAuthority>();
        if (resources != null) {
            for (Menu res : resources) {
                if (res.getUrl() != null && res.getUrl().length() > 0) {
                    authSet.add(new SimpleGrantedAuthority(res.getUrl()));
                }
            }
        }
        return authSet;
    }

}
