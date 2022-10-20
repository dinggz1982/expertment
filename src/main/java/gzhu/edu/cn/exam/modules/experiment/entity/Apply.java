package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.experiment.vo.TimeListVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @program: mix-tech
 * @description: 实验申请
 * @author: 丁国柱
 * @create: 2021-05-24 22:29
 */
@Data
@TableName(value = "exp_apply", resultMap = "baseResultMap")
public class Apply extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    @TableField(exist = false)
    private Lab lab;

    private Integer labId;

    @TableField(exist = false)
    private ExpType type;

    private Integer typeId;

    private String hours;

    //被试数
    private int number;

    //被试数
    private int finishNumber;

    /**
     * 报名数
     */
    private int applyNumber;


    /**
     * 剩余人数
     */
    @TableField(exist = false)
    private int remains;

    //申请时间
    private Date applyTime;

    /**
     * 通过审核时间
     */
    private String confirmTime;

    private String description;

    @TableField(exist = false)
    private String dateTime;


    @TableField(exist = false)
    private User applyUser;

    private Integer applyUserId;

    @TableField(exist = false)
    private User teacherConfirmUser;

    private Integer teacherConfirmUserId;

    @TableField(exist = false)
    private User adminConfirmUser;

    private Integer adminConfirmUserId;

    /**
     * 导师拒绝理由
     */
    private String teacherReason;

    /**
     * 管理员拒绝理由
     */
    private String adminReason;

    /**
     * 是否可报名
     */
    private Integer canSignup;

    //申请状态1，表示正在申请，2表示导师确认，3.表示管理员确认，4表示导师驳回，5表示管理员驳回
    private Integer status;

    //是否完成
    private boolean finished;

    /**
     * 是否验证时间冲突
     */
    private Integer isCheckTime;

    /**
     * 实验是否被锁住
     */
    private String isLock = "0";

    /**
     * 锁定理由
     */
    private String lockReason;

    /**
     * 自定义实验室名称
     */
    @TableField(exist = false)
    private String customize;

    /**
     * 学期
     */
//    private String team = "";

//    @TableField(exist = false)
//    private String teamYear;

//    @TableField(exist = false)
//    private String teamId;

    @TableField(exist = false)
    private List<TimeListVo> labSignUpList;

    @TableField(exist = false)
    private List<ExpLabRecord> expLabRecordList;

//    public void fixTeam() {
//        if (Objects.nonNull(teamYear)) {
//            team = teamYear.replaceAll(" ", "") + " ";
//        }
//        if (Objects.nonNull(teamId)) {
//            team = team + TeamType.getByValue(teamId);
//        }
//    }
}
