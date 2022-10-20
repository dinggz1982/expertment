package gzhu.edu.cn.exam.modules.organization.dto;

import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;

@SpringBootTest
@RunWith(SpringRunner.class)
public class OrganizationDtoTest {

    @Resource
    private ISchoolService schoolService;

    @Test
    public void test2() {
        List<OrganizationDto> schoolTree = schoolService.getSchoolTree();
        System.out.println();
    }
}
