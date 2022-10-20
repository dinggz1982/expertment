package gzhu.edu.cn.exam.modules.knowledge.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import gzhu.edu.cn.exam.modules.knowledge.mapper.KnowledgeMapper;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: mix-tech
 * @description:知识服务
 * @author: 丁国柱
 * @create: 2021-05-02 08:16
 */
@Service
public class KnowledgeService extends ServiceImpl<KnowledgeMapper, Knowledge> implements IKnowledgeService {
    @Override
    public List<Knowledge> getKnowledgeBySubjectId(Integer subjectId) {
        QueryWrapper<Knowledge> queryWrapper = new QueryWrapper<>();
        if (subjectId != null && subjectId > 0) {
            queryWrapper.eq("subject_id", subjectId);
        }
        return this.list(queryWrapper);
    }
}