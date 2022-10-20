package gzhu.edu.cn.exam.modules.borrow.dto;

import lombok.Data;

/**
 * @author Yinglei Jie on 2021/12/10
 */
@Data
public class LabBorrowListDto {

    private String id;

    private String labId;

    private String reason;

    private String name;

    private String startTime;

    private String endTime;

    private String applyTime;

    private Integer status;

    private String statusName;

    private String realName;
    /**
     * 导师拒绝理由
     */
    private String teacherRejectReason;
    private String experimenterRejectReason;
}
