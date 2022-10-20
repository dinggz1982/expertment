package gzhu.edu.cn.exam.modules.experiment.enums;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import lombok.Getter;

/**
 * @author Yinglei Jie on 2021/11/21
 */
@Getter
public enum ApplyType {
    /**
     * 未提交
     */
    NOT_SUBMIT(0, "未提交"),

    /**
     * 等待导师审批
     */
    WAIT_TEACHER(1, "等待导师审批"),

    /**
     * 导师已确认
     */
    TEACHER_ACCEPT(2, "导师已确认"),

    /**
     * 管理员已确认
     */
    ADMIN_ACCEPT(3, "管理员已确认"),

    /**
     * 导师驳回
     */
    TEACHER_RECALL(4, "导师驳回"),

    /**
     * 管理员驳回
     */
    ADMIN_RECALL(5, "管理员驳回"),
    /**
     * 数据收集中
     */
    DATA_COLLECT(6, "数据收集中"),

    /**
     * 已完成
     */
    FINISH(7, "已完成"),

    /**
     * 已撤回
     */
    USER_RECALL(8, "已撤回");

    /**
     * 编号
     */
    int code;
    /**
     * 描述
     */
    String desc;

    ApplyType(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }


    public static JSONArray show() {
        JSONArray json = new JSONArray();
        ApplyType[] values = ApplyType.values();
        for (ApplyType value : values) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", value.code);
            jsonObject.put("desc", value.desc);
            json.put(jsonObject);
        }
        return json;
    }
}
