package gzhu.edu.cn.exam.modules.organization.mapper;

import gzhu.edu.cn.exam.modules.organization.dto.ClassAllInfoDto;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class SchoolMapperTest {
    @Resource
    private SchoolMapper schoolMapper;

    @Test
    public void test1() {
        ClassAllInfoDto dto = schoolMapper.getClassAllInfoByName("广州大学", "教育学院", "教育技术", "教育技术201");
        System.out.println("");
    }
}
