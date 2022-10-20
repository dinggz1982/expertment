package gzhu.edu.cn.exam.modules.experiment.vo;

import lombok.Data;

/**
 * @author Yinglei Jie on 2022/3/4
 */
@Data
public class LabSearchPageVo {

    private String name;

    private String frontShow;

    private int page = 1;

    private int limit = 10;
}
