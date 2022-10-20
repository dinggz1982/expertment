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
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-26 22:46
 */
@Data
@TableName(value = "exp_approve",resultMap = "baseResultMap")
public class Approve {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(exist = false)
    private Apply apply;

    private Integer applyId;

    //0。导师审批，1。管理员审批
    private boolean type;

    @TableField(exist = false)
    private User approveUser;

    private Integer approveUserId;

    private boolean approve;

    private Date createTime;

    private String audit;

}