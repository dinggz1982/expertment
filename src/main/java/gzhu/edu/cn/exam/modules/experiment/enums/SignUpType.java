package gzhu.edu.cn.exam.modules.experiment.enums;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import lombok.Getter;

/**
 * @author Yinglei Jie on 2021/9/29
 */
@Getter
public enum SignUpType {
    /**
     * 1.申请中
     */
    APPLY_ING(1, "申请中"),

    /**
     * 2.主试审核通过，未进行实验
     */
    APPLY_PAST(2, "主试审核通过，未进行实验"),

//    /**
//     * 3.完成实验
//     */
//    FINISHED(3, "完成实验"),

    /**
     * 取消实验
     */
    CANCEL(4, "已取消报名"),

    /**
     * 已驳回
     */
    REJECT(5, "已驳回"),

    /**
     * 主试已确认，等待管理员审核
     */
    MAIN_TEST_CONFIRM(6, "主试已确认，等待管理员审核"),

    /**
     * 管理员审核通过
     */
    ADMIN_PASS(7, "管理员审核通过"),

    /**
     * 管理员审核拒绝
     */
    ADMIN_REJECT(8, "管理员审核拒绝"),

    /**
     * 爽约
     */
    NO_SHOW(9, "爽约"),

    /**
     * 不合格
     */
    BELOW_GRADE(10, "不合格");

    /**
     * 编号
     */
    int code;

    /**
     * 描述
     */
    String desc;

    SignUpType(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }


    public static JSONArray show() {
        JSONArray json = new JSONArray();
        SignUpType[] values = SignUpType.values();
        for (SignUpType value : values) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", value.code);
            jsonObject.put("desc", value.desc);
            json.put(jsonObject);
        }
        return json;
    }

}
