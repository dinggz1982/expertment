package gzhu.edu.cn.exam.modules.experiment.controller;

import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.ExperimentDescription;
import gzhu.edu.cn.exam.modules.experiment.service.IExperimentDescriptionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2022/2/17
 */
@Slf4j
@Controller
@Transactional(rollbackFor = Exception.class)
@RequestMapping("/experiment/setDescription")
public class SetExperimentDescriptionController {

    @Resource
    private IExperimentDescriptionService experimentDescriptionService;

    @GetMapping({"", "/"})
    public String index() {
        return "modules/experiment/set/set-experiment-description-vue";
    }


    @GetMapping("/get-description")
    @ResponseBody
    public R getDescription() {
        ExperimentDescription description = experimentDescriptionService.getById(1);
        return R.ok().put("data", description);
    }

    @PostMapping("/save")
    @ResponseBody
    public R save(@RequestBody ExperimentDescription description) {
        experimentDescriptionService.saveOrUpdate(description);
        return R.ok();
    }

}
