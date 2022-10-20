package gzhu.edu.cn.exam.modules.course.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.course.entity.Outline;
import gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper;
import gzhu.edu.cn.exam.modules.course.service.IOutlineService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: exam
 * @description:教材大纲
 * @author: 丁国柱
 * @create: 2021-05-20 22:04
 */
@Service
public class OutlineService extends ServiceImpl<OutlineMapper, Outline> implements IOutlineService {
    @Override
    public List<Outline> getOutlineByTextbookId(Integer textbookId) {
        QueryWrapper<Outline> queryWrapper = new QueryWrapper<>();
        if (textbookId != null && textbookId > 0) {
            queryWrapper.eq("textbook_id", textbookId);
        }
        return this.list(queryWrapper);
    }
}