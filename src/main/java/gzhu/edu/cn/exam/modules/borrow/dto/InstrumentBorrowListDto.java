package gzhu.edu.cn.exam.modules.borrow.dto;

import lombok.Data;

/**
 * <p>
 * 仪器申请记录表
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
@Data
public class InstrumentBorrowListDto {

    private static final long serialVersionUID = 1L;

    private String id;

    /**
     * 实验室id
     */
    private String instrumentId;

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

    private String statusName;

    /**
     * 申请用户id
     */
    private String userId;

    /**
     * 申请时间
     */
    private String applyTime;

    private String returnTime;

    /**
     * 仪器名称
     */
    private String name;

    /**
     * 借用人真实姓名
     */
    private String realName;

    /**
     * 导师驳回理由
     */
    private String teacherRejectReason;

    private String experimenterRejectReason;
}
