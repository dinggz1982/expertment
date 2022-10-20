package gzhu.edu.cn.exam.modules.experiment.vo;

import lombok.Data;

/**
 * @author Yinglei Jie on 2021/12/20
 */
@Data
public class LockExperimentVo {
    /**
     * 需要锁定的实验id
     */
    private String id;

    /**
     * 锁定的理由
     */
    private String reason;

}
