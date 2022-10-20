package gzhu.edu.cn.exam.modules.knowledge.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:知识关系
 * @author: 丁国柱
 * @create: 2021-05-02 16:35
 */
@Data
@TableName(value = "knowledge_relation",resultMap = "baseResultMap")
public class KnowledgeRelation extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    public Integer id;

    @TableField(exist = false)
    private Knowledge koA;

    private int koAId;

    @TableField(exist = false)
    private Knowledge koB;

    private int koBId;

    private String relation;

}