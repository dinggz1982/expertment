package gzhu.edu.cn.exam.modules.course.controller;

import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.model.TreeData;
import gzhu.edu.cn.exam.modules.course.entity.Outline;
import gzhu.edu.cn.exam.modules.course.entity.Textbook;
import gzhu.edu.cn.exam.modules.course.service.IOutlineService;
import gzhu.edu.cn.exam.modules.course.service.ITextbookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @program: exam
 * @description:教材大纲控制器
 * @author: 丁国柱
 * @create: 2021-05-02 08:43
 */
@Controller
@RequestMapping("/course/outline")
public class OutlineController {

    @Autowired
    private ITextbookService textbookService;


    @Autowired
    private IOutlineService outlineService;

    @GetMapping("/{textbookId}")
    public String index(Model model,@PathVariable  Integer textbookId){
        Textbook textbook = textbookService.getById(textbookId);
        model.addAttribute("textbook",textbook);
        return "modules/course/outline";
    }

    @PostMapping("/tree/{textbookId}")
    @ResponseBody
    public TreeData<Outline> tree(@PathVariable Integer textbookId){
        TreeData<Outline> treeData = new TreeData<>();
        List<Outline> outlines = this.outlineService.getOutlineByTextbookId(textbookId);
        treeData.setData(outlines);
        treeData.setCount(outlines.size());
        treeData.setCode(0);
        return treeData;
    }

    /**
     * 保存或更新知识
     * @param outline
     * @return
     */
    @PostMapping("saveOrUpdate/{textbookId}")
    @ResponseBody
    public ResonseData saveOrUpdate(Outline outline,@PathVariable Integer textbookId) {
        ResonseData data = new ResonseData();
        outline.setTextbookId(textbookId);
        try {
            if(outline.getId()!=null&&outline.getId()>0){
                this.outlineService.updateById(outline);
                data.setMsg("成功更新知识点！");
            }else {
                this.outlineService.save(outline);
                data.setMsg("成功保存知识点！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存知识点失败");
        }
        return data;
    }

    /**
     * 删除知识点
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id){
        ResonseData data = new ResonseData();
        try{
            this.outlineService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除知识点！");
        }catch (Exception e){
            data.setMsg("删除知识点");
            e.printStackTrace();
        }
        return data;
    }


}