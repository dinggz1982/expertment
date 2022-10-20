package gzhu.edu.cn.exam.modules.organization.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:专业
 * @author: 丁国柱
 * @create: 2021-05-02 23:34
 */
@Data
@TableName(value = "org_major",resultMap = "baseResultMap")
public class Major extends BaseEntity {

    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    private String name;

    private String description;

    @TableField(exist = false)
    private College college;

    private Integer collegeId;

    @TableField(exist = false)
    private School school;

    private Integer schoolId;



}