package gzhu.edu.cn.exam.modules.experiment.service;

import gzhu.edu.cn.exam.modules.datamanage.dto.ItemDataExportDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class IApplyServiceTest {


    @Resource
    private IApplyService applyService;

    @Test
    public void test2() {
        List<Apply> applies = applyService.getBaseMapper().selectList(null);
        applies.forEach(item -> {
            applyService.updateStatisticsById(String.valueOf(item.getId()));
        });

    }

    @Test
    public void test1() {
        List<ItemDataExportDto> exportToExcelData = applyService.getExportToExcelData(null, null);
        System.out.println();
    }
}
