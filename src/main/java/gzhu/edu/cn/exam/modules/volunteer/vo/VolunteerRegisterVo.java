package gzhu.edu.cn.exam.modules.volunteer.vo;

import lombok.Data;

import java.util.List;

/**
 * @author Yinglei Jie on 2022/3/1
 */
@Data
public class VolunteerRegisterVo {

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
    private List<String> language;

    /**
     * 诊断信息
     */
    private List<String> info;

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


    private String infoOther;
}
