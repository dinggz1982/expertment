package gzhu.edu.cn.exam.modules.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @program: exam
 * @description: 系统主页入口
 * @author: 丁国柱
 * @create: 2021-04-30 21:00
 */
@Controller
public class IndexController {

    @GetMapping({"", "/", "/index"})
    public String index() {
        return "index";
    }

    @GetMapping("index_innovation")
    public String index_innovation() {
        return "index_innovation";
    }
    @GetMapping("index_teaching")
    public String index_teaching(){
        return "index_teaching";
    }
    @GetMapping("/experiment_more")
    public String index_experiment_more(){
            return "experiment_more";
    }
    @GetMapping("/dynamic_more")
    public String index_dynamic_more(){
        return "dynamic_more";
    }
    @GetMapping("index_experimentIntro_more")
    public String index_experimentIntro_more(){
        return "experimentIntro_more";
    }

}