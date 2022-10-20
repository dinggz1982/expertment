package gzhu.edu.cn.exam.modules.course.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;
import lombok.Data;


/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-20 21:23
 */
@Data
@TableName(value = "course_textbook",resultMap = "baseResultMap")
public class Textbook extends BaseEntity {

    //主键
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    //教材名称
    private String name;

    //isbn
    private String isbn;

    //出版社
    private String press;

    private String grade;

    private String studyTeam;

    @TableField(exist = false)
    private Subject subject;

    private Integer subjectId;


}