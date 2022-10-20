package gzhu.edu.cn.exam.modules.experiment.service;

import gzhu.edu.cn.exam.ExamApplicationTests;
import gzhu.edu.cn.exam.modules.experiment.entity.ExperimentDynamic;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.SimpleDateFormat;
import java.util.Date;

@Slf4j
@SpringBootTest
public class ExperimentDynamicServiceTest extends ExamApplicationTests {

    @Autowired
    private IExperimentDynamicService experimentDynamicService;

    @Test
    public void test2() {
        for (int i = 0; i < 22; i++) {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            ExperimentDynamic dynamic = new ExperimentDynamic();
            dynamic.setContent("jfioejwqiojfiwq");
            dynamic.setCreateTime(df.format(new Date()));
            dynamic.setIsPublish(1);
            experimentDynamicService.save(dynamic);
        }
    }

}


