package gzhu.edu.cn.exam.modules.experiment.service;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest
public class ISignupServiceTest {
    @Resource
    private ISignupService signupService;


    @Test
    public void test1() {
//        PageData<Signup> page = signupService.getPage(1, 10, 1, currentUser, sortProp, sortOrder);
        System.out.println("");
    }
}
