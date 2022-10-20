package gzhu.edu.cn.exam.modules.borrow.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

/**
 * @author Yinglei Jie on 2021/12/10
 */
@Data
public class LabBorrowDto {

    @NotNull(message = "实验室不能为空")
    private Integer labId;

    private List<Date> time;

    @NotEmpty(message = "理由不能为空")
    private String reason;

}
