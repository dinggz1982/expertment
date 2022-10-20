package gzhu.edu.cn.exam.modules.experiment.mapper;

import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class ExpApplyHourStatisticsMapperTest {
    @Resource
    private ExpApplyHourStatisticsMapper expApplyHourStatisticsMapper;

    @Test
    public void test1() {
        List<ExpApplyHourStatistics> list =
                expApplyHourStatisticsMapper.getUserBaseApplyHourStatistics(5293);
        System.out.println("");
    }
}
