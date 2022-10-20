package gzhu.edu.cn.exam.modules.organization.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.system.entity.User;
import lombok.Data;

/**
 * @program: experiment
 * @description:班级-学生对应信息
 * @author: 丁国柱
 * @create: 2021-05-27 21:58
 */
@Data
@TableName(value = "org_class_student",resultMap = "baseResultMap")
public class ClassStudent extends BaseEntity {

    private Integer id;

    @TableField(exist = false)
    private ClassInfo classInfo;

    private Integer classId;

    @TableField(exist = false)
    private User student;

    private Integer studentId;



}