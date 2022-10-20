package gzhu.edu.cn.exam.modules.organization.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:学院
 * @author: 丁国柱
 * @create: 2021-05-02 22:22
 */
@Data
@TableName(value = "org_college",resultMap = "baseResultMap")
public class College extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    @TableField(exist = false)
    private School school;

    private String description;

    //学校id
    private Integer schoolId;

}