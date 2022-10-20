package gzhu.edu.cn.exam.modules.knowledge.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.knowledge.controller.KnoledgeController;
import lombok.Data;

import java.util.Set;

/**
 * @program: mix-tech
 * @description:知识点
 * @author: 丁国柱
 * @create: 2021-05-02 08:11
 */
@Data
@TableName(value = "knowledge_knowledge",resultMap = "baseResultMap")
public class Knowledge extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    //父节点id
    private Integer parentId;

    @TableField(exist = false)
    private Knowledge parent;

    @TableField(exist = false)
    private Set<Knowledge> childrenKnowledge;

    //学科id
    private int subjectId;

    @TableField(exist = false)
    private Subject subject;

}