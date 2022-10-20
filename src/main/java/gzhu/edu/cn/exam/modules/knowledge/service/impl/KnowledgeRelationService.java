package gzhu.edu.cn.exam.modules.knowledge.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation;
import gzhu.edu.cn.exam.modules.knowledge.mapper.KnowledgeRelationMapper;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeRelationService;
import org.springframework.stereotype.Service;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-02 16:43
 */
@Service
public class KnowledgeRelationService extends ServiceImpl<KnowledgeRelationMapper, KnowledgeRelation> implements IKnowledgeRelationService {
    @Override
    public PageData<KnowledgeRelation> getPage(int page, int limit, KnowledgeRelation knowledgeRelation) {
        QueryWrapper<KnowledgeRelation> queryWrapper =new QueryWrapper<>();
        PageData<KnowledgeRelation> knowledgeRelationPageData = new PageData<KnowledgeRelation>();
        Page pageInfo = new Page(page, limit);
        if(knowledgeRelation!=null){
            String relation = knowledgeRelation.getRelation();
            if(relation!=null&&relation.length()>0){
                queryWrapper.like("relation",relation);
            }
            /*String koA = knowledgeRelation.getKoA();
            if(koA!=null&&koA.length()>0){
                queryWrapper.like("ko_a",koA);
            }
            String koB = knowledgeRelation.getKoB();
            if(koB!=null&&koB.length()>0){
                queryWrapper.like("ko_b",koB);
            }*/
        }
        IPage ipage = this.page(pageInfo, queryWrapper);
        knowledgeRelationPageData.setCount(ipage.getTotal());//总记录数
        knowledgeRelationPageData.setData(ipage.getRecords());//当前分页的记录
        knowledgeRelationPageData.setCode(0);//正确的分页响应code为0
        knowledgeRelationPageData.setMsg("知识关系分页");
        return knowledgeRelationPageData;
    }
}