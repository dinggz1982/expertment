package gzhu.edu.cn.exam.modules.knowledge.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;

public interface IKnowledgeRelationService extends IService<KnowledgeRelation> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param knowledgeRelation:检索的关联知识
     * @return
     */
    public PageData<KnowledgeRelation> getPage(int page, int limit, KnowledgeRelation knowledgeRelation);
}
