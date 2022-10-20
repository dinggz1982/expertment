package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.modules.system.entity.User;
import lombok.Data;

import java.util.Date;

/**
 * @program: mix-tech
 * @description:实验报名
 * @author: 丁国柱
 * @create: 2021-05-27 00:15
 */
@Data
@TableName(value = "exp_signup", resultMap = "baseResultMap")
public class Signup {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(exist = false)
    private Apply apply;

    private Integer applyId;

    //1.报名 2.参加试验 3.完成试验
    private Integer status;

    @TableField(exist = false)
    private User signupUser;

    private Integer signupUserId;


    private Date createTime;

    /**
     * 实验时间记录id
     */
    private Integer labRecordId;

    @TableField(exist = false)
    private ExpLabRecord expLabRecord;

    /**
     * 实验室
     */
    @TableField(exist = false)
    private Lab lab;


    /**
     * 拒绝理由
     */
    private String reason;

    /**
     * 实际获得学时
     */
    private String realHour;

    /**
     * 实验确认类型
     */
    private Integer confirmType;

    @TableField(exist = false)
    private ExpSignupStatistics statistics;

    @TableField(exist = false)
    private Integer availableNum;
}
