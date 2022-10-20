package gzhu.edu.cn.exam.modules.system.entity;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotEmpty;
import java.util.List;
import java.util.Set;

/**
 * 用户实体类
 *
 * @TableName("users")表示数据库中的表为users， 如果数据表为its_users，则注解应为@TableName("its_users")
 */
@EqualsAndHashCode(callSuper = true)
@TableName(value = "its_user", resultMap = "baseResultMap")
@Data
public class User extends BaseEntity {
    public static final Integer ONLINE = 1;
    public static final Integer OFFLINE = 0;
    //主键
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    //用户名
    @NotEmpty(message = "用户名不能为空", groups = RegistryGroup.class)
    private String username;

    //密码
//    @JsonIgnore
    @JSONField(serialize = false)
    @NotEmpty(message = "密码不能为空", groups = RegistryGroup.class)
    private String password;

    //真实姓名
    private String realName;

    /**
     * 首页老师显示头像路径
     */
    private String avatarPath;

    //性别
    private String gender;

    private String email;

    @NotEmpty(message = "电话不能为空", groups = RegistryGroup.class)
    private String tel;

    @NotEmpty(message = "微信不能为空", groups = RegistryGroup.class)
    private String weichat;

    //导师工号--对应用户的username
    private String teacherNo;

    @TableField(exist = false)
    private User teacher;

    //学号
    // private String studentNo;

    @TableField(exist = false)
    private Set<Role> roles;

    //存储角色id
    @TableField(exist = false)
    private String userEditRoleSel;

    //头像
    private String avatar;

    //状态
    private Integer status;


    /**
     * 出生年月
     */
    @NotEmpty(message = "出生年月不能为空", groups = RegistryGroup.class)
    private String birth;

    /**
     * 身份
     */
    private String identity;

    /**
     * 学校id
     */
    private Integer schoolId;

    /**
     * 学院id
     */
    private Integer collegeId;

    /**
     * 专业id
     */
    private Integer majorId;

    /**
     * 班级id
     */
    private Integer classId;

    private Integer age;

    /**
     * 职称或职务
     */
    private String positionName;

    /**
     * 教师首页排序
     */
    private Integer frontSort;

    @TableField(exist = false)
    private JSONObject hour;


    @TableField(exist = false)
    private List<ExpApplyHourStatistics> hourStatistics;
}
