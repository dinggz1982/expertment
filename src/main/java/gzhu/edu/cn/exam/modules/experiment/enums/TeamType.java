package gzhu.edu.cn.exam.modules.experiment.enums;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import lombok.Getter;

/**
 * @author Yinglei Jie on 2021/10/4
 */
@Getter
public enum TeamType {
    /**
     * 第一学期
     */
    FIRST("1", "第一学期"),
    /**
     * 第二学期
     */
    SECOND("2", "第二学期");

    TeamType(String value, String name) {
        this.value = value;
        this.name = name;
    }

    String value;
    String name;

    public static String getByName(String name) {
        TeamType[] values = TeamType.values();
        for (TeamType teamType : values) {
            if (teamType.name.equals(name)) {
                return teamType.value;
            }
        }
        return null;
    }

    public static String getByValue(String value) {
        TeamType[] values = TeamType.values();
        for (TeamType teamType : values) {
            if (teamType.value.equals(value)) {
                return teamType.name;
            }
        }
        throw new RuntimeException("学期有误");
    }

    public static JSONArray show() {
        JSONArray json = new JSONArray();
        TeamType[] values = TeamType.values();
        for (TeamType value : values) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", value.value);
            jsonObject.put("name", value.name);
            json.put(jsonObject);
        }
        return json;
    }

}
