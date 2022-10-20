package gzhu.edu.cn.exam.modules.knowledge.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;
import gzhu.edu.cn.exam.modules.knowledge.mapper.SubjectMapper;
import gzhu.edu.cn.exam.modules.knowledge.service.ISubjectService;
import org.springframework.stereotype.Service;

/**
 * @program: mix-tech
 * @description:学科服务
 * @author: 丁国柱
 * @create: 2021-05-02 08:15
 */
@Service
public class SubjectService extends ServiceImpl<SubjectMapper, Subject> implements ISubjectService {
    @Override
    public PageData<Subject> getPage(int page, int limit, Subject subject) {
        PageData<Subject> subjectPageData = new PageData<Subject>();
        Page pageInfo = new Page(page, limit);
        QueryWrapper<Subject> queryWrapper = new QueryWrapper<>();
        if (subject.getName() != null && subject.getName().length() > 0) {
            queryWrapper.like("name", subject.getName());
        }
        IPage ipage = this.page(pageInfo, queryWrapper);
        subjectPageData.setCount(ipage.getTotal());//总记录数
        subjectPageData.setData(ipage.getRecords());//当前分页的记录
        subjectPageData.setCode(0);//正确的分页响应code为0
        subjectPageData.setMsg("学科分页");
        return subjectPageData;
    }
}