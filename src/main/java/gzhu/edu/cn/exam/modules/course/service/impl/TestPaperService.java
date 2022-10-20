package gzhu.edu.cn.exam.modules.course.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.course.entity.TestPaper;
import gzhu.edu.cn.exam.modules.course.mapper.TestPaperMapper;
import gzhu.edu.cn.exam.modules.course.service.ITestPaperService;
import org.springframework.stereotype.Service;

/*
 * @Author 老丁
 * @Description
 **/
@Service
public class TestPaperService extends ServiceImpl<TestPaperMapper, TestPaper> implements ITestPaperService {
}
