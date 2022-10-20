package gzhu.edu.cn.exam.modules.course.controller;

import gzhu.edu.cn.exam.modules.course.entity.TestPaper;
import gzhu.edu.cn.exam.modules.course.service.ITestPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * @Author 老丁
 * @Description //TODO
 **/
@Controller
@RequestMapping("/testPaper")
public class TestPaperController {

    @Autowired
    private ITestPaperService testPaperService;

    @GetMapping("{id}")
    public String paper(@PathVariable Integer id, Model model){

        //获取当前试卷
        TestPaper testPaper = this.testPaperService.getById(id);
        model.addAttribute("testPaper",testPaper);

        return "modules/course/111";
    }


}
