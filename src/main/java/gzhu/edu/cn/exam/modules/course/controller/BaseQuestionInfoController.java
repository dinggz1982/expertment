package gzhu.edu.cn.exam.modules.course.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.model.TreeData;
import gzhu.edu.cn.exam.modules.course.entity.BaseQuestionInfo;
import gzhu.edu.cn.exam.modules.course.entity.Outline;
import gzhu.edu.cn.exam.modules.course.service.IBaseQuestionInfoService;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import gzhu.edu.cn.exam.modules.knowledge.service.IKnowledgeService;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 题库管理--基本信息控制器
 */
@Controller
@RequestMapping("course/baseQuestion")
public class BaseQuestionInfoController {

    @Autowired
    private IBaseQuestionInfoService baseQuestionInfoService;


    @Autowired
    private IKnowledgeService knowledgeService;

    /**
     * 试题基本信息
     *
     * @return
     */
    @GetMapping({"/", "", "/index"})
    public String index() {
        return "modules/course/baseQuestionInfo";
    }


    /**
     * 试题分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<BaseQuestionInfo> list(BaseQuestionInfo baseQuestionInfo, int page, int limit) {
        return this.baseQuestionInfoService.getPage(page, limit, baseQuestionInfo);
    }


    /**
     * 新增试题基本信息
     *
     * @return
     */
    @GetMapping("add")
    public String add(Model model) {
        List<Knowledge> knowledges = this.knowledgeService.getKnowledgeBySubjectId(1);
        model.addAttribute("knowledges",knowledges);
        return "modules/course/addBaseQuestionInfo";
    }

    /**
     * 保存或更新试题基本信息
     *
     * @param baseQuestionInfo
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public Map<String, Object> saveOrUpdate(BaseQuestionInfo baseQuestionInfo) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (baseQuestionInfo.getId() != null && baseQuestionInfo.getId() > 0) {
                this.baseQuestionInfoService.updateById(baseQuestionInfo);
                map.put("msg", "成功更新知识点！");
                map.put("id", baseQuestionInfo.getId());
            } else {
                this.baseQuestionInfoService.save(baseQuestionInfo);
                map.put("id", baseQuestionInfo.getId());
                map.put("msg", "成功保存知识点！");
            }
            map.put("code", 200);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "保存知识点失败！");
        }
        return map;
    }


}
