package gzhu.edu.cn.exam.modules.course.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.course.entity.BaseQuestionInfo;
import gzhu.edu.cn.exam.modules.course.entity.SingleChoice;
import gzhu.edu.cn.exam.modules.course.service.IBaseQuestionInfoService;
import gzhu.edu.cn.exam.modules.course.service.ISingleCholceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 单选题控制器
 */
@Controller
@RequestMapping("course/singleChoice/")
public class SingleCholceController {


    @Autowired
    private ISingleCholceService singleCholceService;

    @Autowired
    private IBaseQuestionInfoService baseQuestionInfoService;


    @GetMapping("edit/{id}")
    public String edit(@PathVariable Integer id, Model model){
        BaseQuestionInfo baseQuestionInfo =   baseQuestionInfoService.getById(id);
        QueryWrapper<SingleChoice> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("base_question_id",id);
        SingleChoice singleChoice = this.singleCholceService.getOne(queryWrapper);
        model.addAttribute("question",singleChoice);
        model.addAttribute("baseQuestionInfo",baseQuestionInfo);
        return "/modules/course/addSingleChoice";
    }



    /**
     * 保存或更新知识
     * @param singleChoice
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(SingleChoice singleChoice) {
        ResonseData data = new ResonseData();
        try {
            if(singleChoice.getId()!=null&&singleChoice.getId()>0){
                this.singleCholceService.updateById(singleChoice);
                data.setMsg("成功更新单选题！");
            }else {
                this.singleCholceService.save(singleChoice);
                data.setMsg("成功保存单选题！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存单选题失败");
        }
        return data;
    } 


}
