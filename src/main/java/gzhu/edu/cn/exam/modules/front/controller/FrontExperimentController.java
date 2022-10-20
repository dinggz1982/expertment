package gzhu.edu.cn.exam.modules.front.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 首页实验列表
 *
 * @author Yinglei Jie on 2022/2/10
 */
@Slf4j
@RestController
@RequestMapping("/api/front/experiment")
public class FrontExperimentController {

    @Resource
    private IApplyService applyService;

    @GetMapping("/getNewExperimentApply")
    public R getNewExperimentApply(@RequestParam(required = false, defaultValue = "1") Integer page,
                                   @RequestParam(required = false, defaultValue = "10") Integer limit) {
        IPage<Apply> pageData = new Page<>(page, limit);
        return R.ok().put("data", applyService.getNewExperimentApply(pageData));
    }
}
