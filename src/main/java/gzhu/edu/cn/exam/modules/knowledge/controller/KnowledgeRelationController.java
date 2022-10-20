package gzhu.edu.cn.exam.modules.knowledge.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeRelationService;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @program: mix-tech
 * @description:知识关系编辑
 * @author: 丁国柱
 * @create: 2021-05-02 16:44
 */
@Controller
@RequestMapping("/knowledge/relation")
public class KnowledgeRelationController {

    @Autowired
    private IKnowledgeService knowledgeService;

    @Autowired
    private IKnowledgeRelationService knowledgeRelationService;
    /**
     * 知识关联
     *
     * @return
     */
    @GetMapping({"","/"})
    public String index(Model model)
    {
        model.addAttribute("kos",this.knowledgeService.list());
        return "modules/knowledge/relation";
    }

    /**
     * 知识关系分页
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<KnowledgeRelation> list(KnowledgeRelation knowledgeRelation, int page, int limit){
        return  this.knowledgeRelationService.getPage(page,limit,knowledgeRelation);
    }

    /**
     * 保存或更新知识关系
     * @param knowledgeRelation
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(KnowledgeRelation knowledgeRelation) {
        ResonseData data = new ResonseData();
        /*Integer koAId = knowledgeRelation.getKoAId();
        if(koAId!=null&&koAId>0){
            Knowledge koA = this.knowledgeService.getById(koAId);
            knowledgeRelation.setKoA(koA.getName());
        }
        Integer koBId = knowledgeRelation.getKoBId();
        if(koBId!=null&&koBId>0){
            Knowledge koB = this.knowledgeService.getById(koBId);
            knowledgeRelation.setKoB(koB.getName());
        }*/
        try {
            if(knowledgeRelation.getId()!=null&&knowledgeRelation.getId()>0){
                this.knowledgeRelationService.updateById(knowledgeRelation);
                data.setMsg("成功更新知识关系！");
            }else {
                this.knowledgeRelationService.save(knowledgeRelation);
                data.setMsg("成功保存知识关系！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存知识关系失败");
        }
        return data;
    }

    /**
     * 删除知识关系
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id){
        ResonseData data = new ResonseData();
        try{
            this.knowledgeRelationService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除知识关系！");
        }catch (Exception e){
            data.setMsg("删除知识关系");
            e.printStackTrace();
        }
        return data;
    }

    @GetMapping("graph/{subjectId}")
    public String graph(Model model, @PathVariable Integer subjectId){
        List<KnowledgeRelation> knowledgeRelations = this.knowledgeRelationService.list();
        StringBuffer nodes = new StringBuffer();
        StringBuffer edges = new StringBuffer();
        Set<Knowledge> knowledges = new HashSet<>();
        for (KnowledgeRelation knowledgeRelation:knowledgeRelations
        ) {
            //处理节点
            Knowledge fromKnowledge = knowledgeRelation.getKoA();
            Knowledge toKnowledge =knowledgeRelation.getKoB();
            if (!knowledges.contains(fromKnowledge)) {
                nodes.append("{ id: " + fromKnowledge.getId() + ", label: \'" + fromKnowledge.getName() + "\'},");
                knowledges.add(fromKnowledge);
            }
            if (!knowledges.contains(toKnowledge)) {
                nodes.append("{ id: " + toKnowledge.getId() + ", label: \'" + toKnowledge.getName() + "\'},");
                knowledges.add(toKnowledge);
            }
            //处理边
            edges.append("{ from:" + fromKnowledge.getId() + ",to:" + toKnowledge.getId() + ",label:\'" + knowledgeRelation.getRelation() + "\',arrows: 'to' },");
        }
        model.addAttribute("edges", edges.toString());
        model.addAttribute("nodes", nodes.toString());
        return "modules/knowledge/knowledgeGraph";
    }

}