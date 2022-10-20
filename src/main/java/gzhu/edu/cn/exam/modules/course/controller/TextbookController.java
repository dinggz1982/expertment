package gzhu.edu.cn.exam.modules.course.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.course.entity.Textbook;
import gzhu.edu.cn.exam.modules.course.service.ITextbookService;
import gzhu.edu.cn.exam.modules.knowledge.service.ISubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: exam
 * @description: 教材管理
 * @author: 丁国柱
 * @create: 2021-05-01 19:24
 */
@Controller
@RequestMapping("/course/textbook")
public class TextbookController {
    @Autowired
    private ITextbookService textbookService;

    @Autowired
    private ISubjectService subjectService;
    /**
     * 教材管理页面
     *
     * @return
     */
    @GetMapping({"","/"})
    public String index(Model model) {
        model.addAttribute("subjects",this.subjectService.list());
        return "modules/course/textbook";
    }


    /**
     * 保存或更新教材
     * @param textbook
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Textbook textbook) {
        ResonseData data = new ResonseData();
        try {
            if(textbook.getId()!=null&&textbook.getId()>0){
                this.textbookService.updateById(textbook);
                data.setMsg("成功更新教材！");
            }else {
                this.textbookService.save(textbook);
                data.setMsg("成功保存教材！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存教材失败");
        }
        return data;
    }

    /**
     * 教材分页
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<Textbook> list(Textbook textbook, int page, int limit){
        return  this.textbookService.getPage(page,limit,textbook);
    }


    /**
     * 删除用户
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id){
        ResonseData data = new ResonseData();
        try{
            this.textbookService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除教材！");
        }catch (Exception e){
            data.setMsg("删除用户教材");
            e.printStackTrace();
        }
        return data;
    }

}