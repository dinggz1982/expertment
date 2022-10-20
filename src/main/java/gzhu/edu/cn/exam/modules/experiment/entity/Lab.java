package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

import javax.validation.constraints.NotEmpty;

/**
 * @program: mix-tech
 * @description: 实验室
 * @author: 丁国柱
 * @create: 2021-05-15 22:22
 */
@Data
@TableName(value = "exp_lab")
public class Lab extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @NotEmpty(message = "实验室名称不能为空")
    private String name;

    private String address;

    private String description;

    /**
     * 是否为自定义实验室
     */
    private Integer isCustomize;

    /**
     * 创建时间
     */
    private String createDate;


    /**
     * 图片列表
     */
    private String imgList;

    /**
     * 是否展示
     */
    private String frontShow;

    /**
     * 排序
     */
    private Integer sort;
}
