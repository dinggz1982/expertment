package gzhu.edu.cn.exam.modules.volunteer.vo;

import lombok.Data;

/**
 * @author Yinglei Jie on 2022/3/2
 */
@Data
public class RegisterListRequestVo {

    private Integer page = 1;

    private Integer limit = 10;

    private String name;

}
