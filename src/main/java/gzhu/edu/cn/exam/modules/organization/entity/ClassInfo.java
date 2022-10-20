package gzhu.edu.cn.exam.modules.organization.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:班级
 * @author: 丁国柱
 * @create: 2021-05-02 23:40
 */
@Data
@TableName(value = "org_class",resultMap = "baseResultMap")
public class ClassInfo extends BaseEntity {
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    //班级名称
    private String name;

    //专业
    @TableField(exist = false)
    private Major major;

    //专业的id
    private Integer majorId;

    //学院
    @TableField(exist = false)
    private College college;

    //学院的id
    private Integer collegeId;

    //学校的id
    private Integer schoolId;

    //学校
    @TableField(exist = false)
    private School school;
}