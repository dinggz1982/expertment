package gzhu.edu.cn.exam.modules.knowledge.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;

public interface ISubjectService extends IService<Subject> {
    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param subject:检索的学科信息
     * @return
     */
    public PageData<Subject> getPage(int page, int limit, Subject subject);

}
