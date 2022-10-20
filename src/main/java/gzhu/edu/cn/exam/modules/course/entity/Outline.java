package gzhu.edu.cn.exam.modules.course.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;
import lombok.Data;

import java.util.Set;

/**
 * @program: exam
 * @description:教材大纲
 * @author: 丁国柱
 * @create: 2021-05-02 08:11
 */
@Data
@TableName(value = "course_outline",resultMap = "baseResultMap")
public class Outline extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    //父节点id
    private Integer parentId;

    @TableField(exist = false)
    private Outline parent;

    @TableField(exist = false)
    private Set<Outline> outlines;

    //教材id
    private Integer textbookId;

    @TableField(exist = false)
    private Textbook textbook;

}