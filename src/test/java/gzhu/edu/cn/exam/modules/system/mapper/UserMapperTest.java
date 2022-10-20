package gzhu.edu.cn.exam.modules.system.mapper;

import gzhu.edu.cn.exam.modules.datamanage.dto.CollectDto;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

@SpringBootTest
public class UserMapperTest {
    @Resource
    private UserMapper userMapper;

    @Test
    public void test1() {
        List<CollectDto> collectDtos = userMapper.selectBeiShiStudentExportList();
        System.out.println();
    }

    @Test
    public void test2() {
        List<Integer> list = Arrays.asList(1, 2, 3);
        userMapper.getUpdateUserRoleList(1, list);
        System.out.println();
    }
}
