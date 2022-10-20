package gzhu.edu.cn.exam.modules.experiment.enums;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import lombok.Getter;

/**
 * @author Yinglei Jie on 2021/11/23
 */
@Getter
public enum ApplyConfirmType {
    /**
     * 合格
     */
    UP_TO_STANDARD(1, "合格"),
    /**
     * 不合格
     */
    BELOW_GRADE(2, "不合格"),

    /**
     * 爽约
     */
    NO_SHOW(3, "爽约");

    /**
     * 编号
     */
    int code;
    /**
     * 描述
     */
    String desc;


    ApplyConfirmType(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }


    public static JSONArray show() {
        JSONArray json = new JSONArray();
        ApplyConfirmType[] values = ApplyConfirmType.values();
        for (ApplyConfirmType value : values) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", value.code);
            jsonObject.put("desc", value.desc);
            json.put(jsonObject);
        }
        return json;
    }
}
