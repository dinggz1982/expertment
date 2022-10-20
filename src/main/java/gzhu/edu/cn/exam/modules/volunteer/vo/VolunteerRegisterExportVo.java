package gzhu.edu.cn.exam.modules.volunteer.vo;

import cn.hutool.core.annotation.Alias;
import com.alibaba.fastjson.JSON;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerDiagnosisInfo;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author Yinglei Jie on 2022/3/6
 */
@Data
public class VolunteerRegisterExportVo {
    /**
     * 为谁注册
     */
    @Alias("为谁注册")
    private String registerType;

    /**
     * 姓名
     */
    @Alias("姓名")
    private String name;

    /**
     * 出生年月日
     */
    @Alias("出生年月日")
    private String birth;

    /**
     * 性别
     */
    @Alias("性别")
    private String sex;

    /**
     * 民族
     */
    @Alias("民族")
    private String nationality;

    /**
     * 使用语言
     */
    @Alias("使用语言")
    private String language;

    /**
     * email
     */
    @Alias("email")
    private String email;

    /**
     * mobile
     */
    @Alias("手机号")
    private String mobile;

    /**
     * wechat
     */
    @Alias("微信号")
    private String wechat;

    /**
     * 注册时间
     */
    @Alias("注册时间")
    private String registerDate;


    @Alias("诊断症状")
    private String info;

    public static List<VolunteerRegisterExportVo> toExcelDataList(List<VolunteerRegister> data) {
        List<VolunteerRegisterExportVo> res = new ArrayList<>();
        if (Objects.nonNull(data) && !data.isEmpty()) {
            data.forEach(item -> {
                VolunteerRegisterExportVo vo = new VolunteerRegisterExportVo();
                vo.setBirth(item.getBirth());
                vo.setEmail(item.getEmail());
                vo.setRegisterDate(item.getRegisterDate());
                vo.setRegisterType(item.getRegisterType());
                vo.setMobile(item.getMobile());
                vo.setName(item.getName());
                vo.setSex(item.getSex());
                vo.setNationality(item.getNationality());
                vo.setWechat(item.getWechat());
                String language = item.getLanguage();
                if (Objects.nonNull(language) && !language.isEmpty()) {
                    List<String> list = JSON.parseArray(language, String.class);
                    if (Objects.nonNull(list) && !list.isEmpty()) {
                        vo.setLanguage(String.join("、", list));
                    }
                }
                List<VolunteerDiagnosisInfo> info = item.getInfo();
                if (Objects.nonNull(info) && !info.isEmpty()) {
                    List<String> collect = info.stream().map(VolunteerDiagnosisInfo::getDiagnosisInfo).collect(Collectors.toList());
                    if (!collect.isEmpty()) {
                        vo.setInfo(String.join("、", collect));
                    }
                }
                res.add(vo);
            });
        }
        return res;
    }

}
