package gzhu.edu.cn.exam.modules.volunteer.vo;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

/**
 * @author Yinglei Jie on 2022/3/5
 */
@Data
public class VolunteerNoticeVo {

    @NotEmpty(message = "内容不能为空")
    private String content;
}
