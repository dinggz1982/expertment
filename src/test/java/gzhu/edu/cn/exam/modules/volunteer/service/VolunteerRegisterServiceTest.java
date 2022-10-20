package gzhu.edu.cn.exam.modules.volunteer.service;

import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;

@SpringBootTest
@RunWith(SpringRunner.class)
public class VolunteerRegisterServiceTest {
    @Resource
    private VolunteerRegisterService volunteerRegisterService;

    @Test
    public void test1() {
        List<VolunteerRegister> exportData = volunteerRegisterService.getExportData();
        System.out.println();
    }
}
