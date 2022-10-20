package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:实验类型
 * @author: 丁国柱
 * @create: 2021-05-24 21:54
 */
@Data
@TableName(value = "exp_type")
public class ExpType extends BaseEntity {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    private String description;

}