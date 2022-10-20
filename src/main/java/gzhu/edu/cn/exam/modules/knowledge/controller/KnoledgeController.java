package gzhu.edu.cn.exam.modules.knowledge.controller;

import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.model.TreeData;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeService;
import gzhu.edu.cn.exam.modules.knowledge.service.ISubjectService;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @program: mix-tech
 * @description:知识控制器
 * @author: 丁国柱
 * @create: 2021-05-02 08:43
 */
@Controller
@RequestMapping("/knowledge/knowledge")
public class KnoledgeController {

    @Autowired
    private ISubjectService subjectService;

    @Autowired
    private IKnowledgeService knowledgeService;

    @GetMapping({"","/"})
    public String index(Model model,Integer subjectId){
        if(subjectId!=null&&subjectId>0){
            Subject subject = subjectService.getById(subjectId);
            model.addAttribute("subject",subject);
        }
        List<Subject> subjects = this.subjectService.list();
        model.addAttribute("subjects",subjects);
        return "modules/knowledge/knowledge";
    }

    @PostMapping("/tree/{subjectId}")
    @ResponseBody
    public TreeData<Knowledge> tree(@PathVariable Integer subjectId){
        TreeData<Knowledge> treeData = new TreeData<>();
        List<Knowledge> knowledges = this.knowledgeService.getKnowledgeBySubjectId(subjectId);
        treeData.setData(knowledges);
        treeData.setCount(knowledges.size());
        treeData.setCode(0);
        return treeData;
    }

    /**
     * 保存或更新知识
     * @param knowledge
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Knowledge knowledge) {
        ResonseData data = new ResonseData();
        try {
            if(knowledge.getId()!=null&&knowledge.getId()>0){
                this.knowledgeService.updateById(knowledge);
                data.setMsg("成功更新知识点！");
            }else {
                this.knowledgeService.save(knowledge);
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
            this.knowledgeService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除知识点！");
        }catch (Exception e){
            data.setMsg("删除知识点");
            e.printStackTrace();
        }
        return data;
    }


}