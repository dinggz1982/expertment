package gzhu.edu.cn.exam.modules.experiment.service.impl;

import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

@SpringBootTest
public class ExpApplyHourStatisticsServiceImplTest {
    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;
    @Resource
    private IUserService userService;

    @Test
    public void test1() {
        List<User> users = userService.getBaseMapper().selectList(null);
        if (Objects.nonNull(users) && !users.isEmpty()) {
            users.forEach(item -> {
                expApplyHourStatisticsService.updateUserHourByUserId(item.getId());
            });
        }
    }
}
