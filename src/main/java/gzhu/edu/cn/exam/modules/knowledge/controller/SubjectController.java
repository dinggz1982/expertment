package gzhu.edu.cn.exam.modules.knowledge.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.knowledge.entity.Subject;
import gzhu.edu.cn.exam.modules.knowledge.service.ISubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: mix-tech
 * @description:学科控制器
 * @author: 丁国柱
 * @create: 2021-05-02 08:19
 */
@Controller
@RequestMapping("/knowledge/subject")
public class SubjectController {
    @Autowired
    private ISubjectService subjectService;
    /**
     * 学科管理页面
     *
     * @return
     */
    @GetMapping({"","/"})
    public String index() {
        return "modules/knowledge/subject";
    }


    /**
     * 保存或更新学科
     * @param subject
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Subject subject) {
        ResonseData data = new ResonseData();
        try {
            if(subject.getId()!=null&&subject.getId()>0){
                this.subjectService.updateById(subject);
                data.setMsg("成功更新学科！");
            }else {
                this.subjectService.save(subject);
                data.setMsg("成功保存学科！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存学科失败");
        }
        return data;
    }

    /**
     * 学科分页
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<Subject> list(Subject subject, int page, int limit){
        return  this.subjectService.getPage(page,limit,subject);
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
            this.subjectService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除学科！");
        }catch (Exception e){
            data.setMsg("删除用户学科");
            e.printStackTrace();
        }
        return data;
    }


}