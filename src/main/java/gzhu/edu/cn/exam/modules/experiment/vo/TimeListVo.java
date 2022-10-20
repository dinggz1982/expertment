package gzhu.edu.cn.exam.modules.experiment.vo;

import lombok.Data;

/**
 * 实验室申请时间、人数
 *
 * @author Yinglei Jie on 2021/11/20
 */
@Data
public class TimeListVo {

    private Integer id;

    private String startTime;

    private String endTime;

    private Integer num;
}
