package gzhu.edu.cn.exam.modules.volunteer.enums;

import lombok.Getter;

/**
 * @author Yinglei Jie on 2022/2/28
 */
@Getter
public enum DiagnosisType {

    /**
     * 自闭症谱系障碍 (包含阿斯伯格综合征和PDD-NOS)
     */
    A(1, "自闭症谱系障碍 (包含阿斯伯格综合征和PDD-NOS)"),
    /**
     * 发育迟缓或智力障碍
     */
    B(2, "发育迟缓或智力障碍"),
    /**
     * 唐氏综合症
     */
    C(3, "唐氏综合症"),

    /**
     * 脆性X染色体综合征
     */
    D(4, "脆性X染色体综合征"),

    /**
     * 22q11.2 缺失综合征
     */
    E(5, "22q11.2 缺失综合征"),
    /**
     * ADHD（注意缺陷多动障碍）
     */
    F(6, "ADHD（注意缺陷多动障碍）"),
    /**
     * 学习障碍（如，读写障碍）
     */
    G(7, "学习障碍（如，读写障碍）"),
    /**
     * 无任何诊断，普通正常人
     */
    H(8, "无任何诊断，普通正常人");

    /**
     * 诊断类型编号
     */
    int code;

    /**
     * 诊断类型描述
     */
    String desc;


    DiagnosisType(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static String getDescByCode(int code) {
        DiagnosisType[] values = DiagnosisType.values();
        for (DiagnosisType value : values) {
            if (value.code == code) {
                return value.desc;
            }
        }
        return "";
    }

}
