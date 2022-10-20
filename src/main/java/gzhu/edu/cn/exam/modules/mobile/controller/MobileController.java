package gzhu.edu.cn.exam.modules.mobile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @program: exam
 * @description: 手机端
 * @author: 丁国柱
 * @create: 2021-05-01 10:06
 */
@Controller
public class MobileController {
    @GetMapping("mobile")
    public String index(){
        return "mobile/index";
    }

    /**
     * 传感器列表
     * @return
     */
    @GetMapping("mobile/list")
    public String list(){
        return "modules/sensor/sensor";
    }

    /**
     * 传感器数据列表
     * @return
     */
    @GetMapping("mobile/sensorData")
    public String sensorData(){

        return "mobile/data";
    }

}