package gzhu.edu.cn.exam.modules.system.vo;

import cn.hutool.core.annotation.Alias;
import lombok.Data;

/**
 * @author Yinglei Jie on 2021/12/26
 */
@Data
public class UserExportToExcelVo {
    @Alias("用户名")
    private String username;
    @Alias("真实姓名")
    private String realName;
    @Alias("性别")
    private String gender;
    @Alias("邮箱")
    private String email;
    @Alias("电话")
    private String tel;
    @Alias("微信")
    private String weichat;
    @Alias("导师账号")
    private String teacherNo;
    @Alias("出生年月")
    private String birth;
    @Alias("身份")
    private String identity;
    @Alias("年龄")
    private String age;
}
