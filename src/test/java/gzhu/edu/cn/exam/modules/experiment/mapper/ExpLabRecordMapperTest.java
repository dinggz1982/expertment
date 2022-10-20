package gzhu.edu.cn.exam.modules.experiment.mapper;

import gzhu.edu.cn.exam.modules.experiment.entity.ExpLabRecord;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class ExpLabRecordMapperTest {
    @Resource
    private ExpLabRecordMapper expLabRecordMapper;

    @Test
    public void test2() {
        List<ExpLabRecord> expLabRecords = expLabRecordMapper.selectList(null);
        expLabRecords.forEach(item -> {
            expLabRecordMapper.updateRecordAlreadyNum(item.getId());
        });
    }

    @Test
    public void test1() {
        System.out.println(expLabRecordMapper.checkLab(1, "2021-11-03 1:00", "2021-11-04 0:00"));
    }
}
