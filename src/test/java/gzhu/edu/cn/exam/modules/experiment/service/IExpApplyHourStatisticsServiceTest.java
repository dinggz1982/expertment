package gzhu.edu.cn.exam.modules.experiment.service;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@Slf4j
@SpringBootTest
public class IExpApplyHourStatisticsServiceTest {


    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    @Test
    public void test1() {
        expApplyHourStatisticsService.initUserData(1, "0");
    }
}
