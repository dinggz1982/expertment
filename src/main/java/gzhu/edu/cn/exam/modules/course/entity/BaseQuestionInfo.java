package gzhu.edu.cn.exam.modules.course.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import lombok.Data;

/**
 * 试题基本信息
 */
@Data
@TableName(value = "course_base_question_info",resultMap = "baseResultMap")
public class BaseQuestionInfo extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String title;

    //1.单选，2.多选，3.判断 4.简答 5.论述 6.....
    private int type;

    //分数
    private float score;

    @TableField(exist = false)
    private Outline outline;

    private Integer outlineId;

    @TableField(exist = false)
    private Knowledge knowledge;

    private Integer knowledgeId;

    private int difficult;

}
