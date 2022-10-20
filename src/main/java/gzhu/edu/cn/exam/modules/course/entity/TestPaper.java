package gzhu.edu.cn.exam.modules.course.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.system.entity.User;
import lombok.Data;

import java.util.Date;
import java.util.Set;

/*
 * @Author 老丁
 * @Description //TODO $
 **/
@Data
@TableName(value = "course_test_paper",resultMap = "baseResultMap")
public class TestPaper extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    private Integer createUserId;

    @TableField(exist = false)
    private User createUser;

    private Date createTime;

    @TableField(exist = false)
    private Set<SingleChoice> singleChoices;

}

