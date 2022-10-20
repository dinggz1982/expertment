package gzhu.edu.cn.exam.modules.experiment.entity;

import gzhu.edu.cn.exam.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 仪器申请记录表
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ExpInstrumentRecord extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 实验室id
     */
    private Integer instrumentId;

    /**
     * 开始时间
     */
    private String startTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 0待审核 1审核通过
     */
    private String isPass;

    /**
     * 申请理由
     */
    private String reason;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 申请用户id
     */
    private Integer userId;

    /**
     * 申请时间
     */
    private String applyTime;

    /**
     * 归还时间
     */
    private String returnTime;

    /**
     * 导师拒绝理由
     */
    private String teacherRejectReason;

    /**
     * 审核导师id
     */
    private Integer approveTeacherId;

    /**
     * 实验员拒绝理由
     */
    private String experimenterRejectReason;
}
