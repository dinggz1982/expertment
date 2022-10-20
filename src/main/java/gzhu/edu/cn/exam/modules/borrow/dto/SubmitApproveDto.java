package gzhu.edu.cn.exam.modules.borrow.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author Yinglei Jie on 2021/12/12
 */
@Data
public class SubmitApproveDto {

    @NotEmpty(message = "非法参数")
    private String type;

    @NotNull(message = "非法参数")
    private Integer id;

    @NotNull(message = "非法参数")
    private Integer isApprove;

    private String reason;

    /**
     * 多选时id列表
     */
    private List<Integer> ids;
}
