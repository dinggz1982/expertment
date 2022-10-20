package gzhu.edu.cn.exam.modules.borrow.enums;

import lombok.Getter;

/**
 * @author Yinglei Jie on 2021/12/11
 */
@Getter
public enum LabBorrowStatusEnum {

    /**
     * 申请中
     */
    APPLYING(1, "申请中"),

    /**
     * 导师同意
     */
    TEACHER_AGREE(2, "导师已同意"),

    /**
     * 导师拒绝
     */
    TEACHER_REJECT(3, "导师已驳回"),

    /**
     * 实验员已同意
     */
    EXPERIMENTER_AGREE(4, "实验员已同意"),

    /**
     * 实验员已驳回
     */
    EXPERIMENTER_REJECT(5, "实验员已驳回"),

    /**
     * 已撤回
     */
    RECALL(6, "已撤回");

    /**
     * code
     */
    int code;

    /**
     * desc
     */
    String desc;

    LabBorrowStatusEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static String getDescById(Integer status) {
        LabBorrowStatusEnum[] values = LabBorrowStatusEnum.values();
        for (LabBorrowStatusEnum value : values) {
            if (value.code == status) {
                return value.desc;
            }
        }
        return null;
    }
}
