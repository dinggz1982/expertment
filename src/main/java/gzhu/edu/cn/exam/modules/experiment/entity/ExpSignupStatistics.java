package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * <p>
 * 被试实验统计
 * </p>
 *
 * @author loading
 * @since 2021-11-23
 */
@Data
@TableName(value = "exp_signup_statistics")
public class ExpSignupStatistics {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 合格数
     */
    private Integer upToStandrad;

    /**
     * 不合格数
     */
    private Integer belowGrade;

    /**
     * 爽约数
     */
    private Integer noShow;

    /**
     * 总获得学分
     */
    private String totalScore;

}
