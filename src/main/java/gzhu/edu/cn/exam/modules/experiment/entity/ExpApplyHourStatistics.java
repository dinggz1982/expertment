package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * <p>
 * 被试实验学时按类型统计
 * </p>
 *
 * @author loading
 * @since 2021-12-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("exp_apply_hour_statistics")
public class ExpApplyHourStatistics extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 实验类型id
     */
    private Integer applyTypeId;

    /**
     * 总学时
     */
    private BigDecimal totalHour;

    /**
     * 是否为基础学时(0非基础，1基础)
     */
    private String isBase;


}
