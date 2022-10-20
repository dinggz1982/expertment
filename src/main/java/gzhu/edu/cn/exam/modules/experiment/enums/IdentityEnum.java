package gzhu.edu.cn.exam.modules.experiment.enums;

import lombok.Getter;

import java.util.Objects;

/**
 * @author Yinglei Jie on 2021/10/4
 */
@Getter
public enum IdentityEnum {

    /**
     * 教师
     */
    TEACHER("教师"),

    /**
     * 研究生
     */
    GRADUATE_STUDENT("研究生"),

    /**
     * 本科生
     */
    UNDERGRADUATE_STUDENT("本科生");

    IdentityEnum(String name) {
        this.name = name;
    }

    String name;


    public static boolean checkName(String name) {
        if (Objects.isNull(name) || name.isEmpty()) {
            return false;
        }
        IdentityEnum[] values = IdentityEnum.values();
        for (IdentityEnum value : values) {
            if (value.name.equals(name)) {
                return true;
            }
        }
        return false;
    }

    public static String[] getNameList() {
        IdentityEnum[] values = IdentityEnum.values();
        String[] res = new String[values.length];
        for (int i = 0; i < values.length; i++) {
            res[i] = values[i].name;
        }
        return res;
    }
}
