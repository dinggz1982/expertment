package gzhu.edu.cn.exam.modules.system.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @author Yinglei Jie on 2022/2/22
 */
@Data
public class SearchTeacherVo {

    @NotNull(message = "搜索内容不能为空")
    private String name;


}
