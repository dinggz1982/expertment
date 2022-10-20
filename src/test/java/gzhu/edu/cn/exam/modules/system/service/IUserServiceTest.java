package gzhu.edu.cn.exam.modules.system.service;

import gzhu.edu.cn.exam.modules.system.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class IUserServiceTest {

    @Resource
    IUserService userService;

    @Test
    public void test1() {
        List<User> admin = userService.getStudentList("admin");
        System.out.println("");
    }
}
