package gzhu.edu.cn.exam.modules.course.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

@Data
@TableName(value = "course_single_choice")
public class SingleChoice extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer baseQuestionId;
    private String description;

    private String itemA;
    private String itemB;
    private String itemC;
    private String itemD;
    private String itemE;
    private String itemF;
    private String rightAnswer;
    private String analysis;
}
