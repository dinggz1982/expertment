package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 实验室申请记录表
 * </p>
 *
 * @author loading
 * @since 2021-11-20
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("exp_lab_record")
public class ExpLabRecord extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 实验室id
     */
    private Integer labId;

    /**
     * 实验id
     */
    private Integer applyId;

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
     * 人数
     */
    private Integer num;

    /**
     * 已经报名人数
     */
    private Integer alreadyNum;

    /**
     * 已完成人数
     */
    private Integer finishNum;

    /**
     * 自定义申请时，申请理由
     */
    private String reason;

    /**
     * 申请状态
     */
    private Integer status;

    /**
     * 申请时间
     */
    private String applyTime;

    /**
     * 申请用户id
     */
    private Integer userId;

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
