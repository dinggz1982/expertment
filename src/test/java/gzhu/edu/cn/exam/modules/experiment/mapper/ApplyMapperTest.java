package gzhu.edu.cn.exam.modules.experiment.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.vo.ApplySignUpCollectDto;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest
public class ApplyMapperTest {
    @Resource
    private ApplyMapper applyMapper;

    @Test
    public void test1() {
        IPage<ApplySignUpCollectDto> page = new Page<>(1, 10);
        applyMapper.getUserApplyCollectPageData(page, "1");
        System.out.println();
    }

    @Test
    public void test2() {
        IPage<Apply> pageData = new Page<>();
        applyMapper.getNewExperimentApply(pageData, ApplyType.ADMIN_ACCEPT.getCode());
        System.out.println("");
    }
}
