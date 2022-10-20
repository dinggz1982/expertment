package gzhu.edu.cn.exam.modules.knowledge.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;

import java.util.List;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-02 08:14
 */
public interface IKnowledgeService extends IService<Knowledge> {
    /**
     * 通过学科获取知识点
     * @param subjectId
     * @return
     */
    List<Knowledge> getKnowledgeBySubjectId(Integer subjectId);

}