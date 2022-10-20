package gzhu.edu.cn.exam.modules.system.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.annotation.Resource;

/**
 * Spring security管理配置，主入口
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true) // 开启security注解
public class WebSecurityDevConfig extends WebSecurityConfigurerAdapter {

    @Resource
    private ExamUserDetailsService userDetailsService;

    @Resource
    private ExamSecurityMetadataSource examSecurityMetadataSource;

    @Resource
    private ExamAccessDecisionManager examAccessDecisionManager;

    @Resource
    private ExamAccessDeniedHandler accessDeniedHandler;

    @Resource
    private ExamLogoutHandler logoutHandler;

    @Resource
    private ExamAuthenticationFailureHandler authenticationFailureHandler;

    // http://localhost:8080/login 输入正确的用户名密码 并且选中remember-me 则登陆成功，转到 index页面
    // 再次访问index页面无需登录直接访问
    // 访问http://localhost:8080/home 不拦截，直接访问，
    // 访问http://localhost:8080/hello 需要登录验证后，且具备
    // “ADMIN”权限hasAuthority("ADMIN")才可以访问
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.headers().frameOptions().disable();
        http.authorizeRequests()
                //主路径直接请求
                .antMatchers("/system/user/loginError",
                        "/login", "/", "/index", "/vue/**", "/system/registry/registry",
                        "/element-ui/**", "/system/registry/toRegistry", "/api/**",
                        //首页获取教师列表接口
                        "/system/front/teacherList/getFrontTeacherList",
                        //获取教师头像接口
                        "/system/front/teacherList/getTeacherAvatar/**",
                        "/home_login",
                        "/index_innovation",
                        "/index_teaching",
                        "/volunteer/register/**",
                        "/index_experimentIntro_more",
                        "/dynamic_more",
                        "/experiment/setDescription/get-description",
                        "/experiment/dynamic/getDynamicList",
                        "system/front/teacherList/getFrontTeacherList",
                         "/api/front/lab/list",
                         "/experiment_more",
                         //请求实验室数据
                        "/experiment/lab/getLabPicture/**").permitAll()
                .anyRequest().authenticated()    //请他请求都要验证
                .and()
                .logout().permitAll()   //允许注销
                .and().formLogin();  //允许表单登录

        // 指定登录页是”/login”
        http.formLogin().loginPage("/login").failureHandler(authenticationFailureHandler)
                // 登录成功后可使用loginSuccessHandler()存储用户信息，可选。
                .permitAll().successHandler(loginSuccessHandler())
                .and().sessionManagement().maximumSessions(1).sessionRegistry(sessionRegistry()).expiredUrl("/login")
                // 退出登录后的默认网址是”/login”
                .and().and().logout().logoutSuccessUrl("/login")
                // 登录后记住用户，下次自动登录,数据库中必须存在名为persistent_logins的表
                .permitAll().invalidateHttpSession(true).and().rememberMe()
                .tokenValiditySeconds(20);
        //关闭csrf的认证
        http.csrf().disable();
//        http
//                .authorizeRequests()
//                .antMatchers(
//                        "/hello")
//                .permitAll()
//                .anyRequest()
//                .authenticated();
        //访问没有权处理器
        http.exceptionHandling().accessDeniedHandler(accessDeniedHandler);

        //用户退出处理器
        http.logout().addLogoutHandler(logoutHandler);

    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        //解决静态资源被SpringSecurity拦截的问题
        web.ignoring().antMatchers("/static/**", "/layui/**", "/assets/**");//这样我的webapp下static里的静态资源就不会被拦截了，也就不会导致我的网页的css全部失效了……
    }

    /**
     * 认证管理
     * <p>
     * 方法名:configureGlobal
     * </p>
     * <p>
     * Description :
     * </p>
     * <p>
     * Company :
     * </p>
     *
     * @param auth
     * @throws Exception
     * @author 丁国柱
     * @date 2017年12月11日 下午12:30:01
     */

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        // 指定密码加密所使用的加密器为passwordEncoder()
        // 需要将密码加密后写入数据库
        // PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
        auth.eraseCredentials(false).userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(4);
    }

    /**
     * 登录成功后的处理信息
     *
     * @return
     */
    @Bean
    public AuthenticationSuccessHandler loginSuccessHandler() {
        return new LoginSuccessHandler();
    }

    @Bean
    public ExamAuthenticationFailureHandler authenticationFailureHandler() {
        return new ExamAuthenticationFailureHandler();
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

}
