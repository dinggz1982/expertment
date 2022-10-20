package gzhu.edu.cn.exam.modules.volunteer.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.List;

/**
 * <p>
 *
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
@Data
public class VolunteerRegister {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 为谁注册
     */
    private String registerType;

    /**
     * 姓名
     */
    private String name;

    /**
     * 出生年月日
     */
    private String birth;

    /**
     * 性别
     */
    private String sex;

    /**
     * 民族
     */
    private String nationality;

    /**
     * 使用语言
     */
    private String language;

    /**
     * email
     */
    private String email;

    /**
     * mobile
     */
    private String mobile;

    /**
     * wechat
     */
    private String wechat;

    /**
     * 注册时间
     */
    private String registerDate;


    @TableField(exist = false)
    private List<VolunteerDiagnosisInfo> info;
}
