package gzhu.edu.cn.exam;

import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @program: exam
 * @description: 用户单元测试
 * @author: 丁国柱
 * @create: 2021-04-30 21:31
 */
@SpringBootTest
class UserTest {

    @Autowired
    private IUserService userService;

    @Test
    public void resetUserPassword() {
        User user = this.userService.findByName("admin");
        userService.resetPassword(user, "123456");
    }

    @Test
    public void test2() {
        String a = "below grade";
        System.out.println(a.toUpperCase());
    }

    public static void main(String[] args) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
        System.out.println(passwordEncoder.encode("123456"));

    }

}
