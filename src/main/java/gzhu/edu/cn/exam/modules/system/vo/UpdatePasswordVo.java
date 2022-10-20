package gzhu.edu.cn.exam.modules.system.vo;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

/**
 * @author Yinglei Jie on 2021/11/19
 */
@Data
public class UpdatePasswordVo {

    @NotEmpty
    private String newPsw;

    @NotEmpty
    private String oldPsw;

    @NotEmpty
    private String rePsw;
}
