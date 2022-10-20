package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import gzhu.edu.cn.exam.modules.system.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotEmpty;

/**
 * <p>
 *
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ExpInstrument extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    //仪器名称
    @NotEmpty(message = "仪器名称不能为空!")
    private String name;

    //存放地点
    private String address;

    //仪器描述
    private String description;

    //实验室的id
    private String labId;

    //所属实验室
    @TableField(exist = false)
    private Lab lab;

    @TableField(exist = false)
    private String labName;

    //负责教师1
    private String teacher1;
    @TableField(exist = false)
    private User teacher01;

    //负责教师2
    private String teacher2;
    @TableField(exist = false)
    private User teacher02;

    //负责教师3
    private String teacher3;
    @TableField(exist = false)
    private User teacher03;

    /**
     * 添加时间
     */
    private String addTime;


}
