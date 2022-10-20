package gzhu.edu.cn.exam.modules.experiment.controller;


import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpBranchLab;
import gzhu.edu.cn.exam.modules.experiment.service.ExpBranchLabService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;
import java.util.Objects;

/**
 * <p>
 * 实验分室 前端控制器
 * </p>
 *
 * @author loading
 * @since 2022-04-05
 */
@Slf4j
@Controller
@RequestMapping("/exp-branch-lab")
public class ExpBranchLabController {

    @Resource
    private ExpBranchLabService expBranchLabService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/experiment/exp-branch-lab-page";
    }

    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public R saveNewExpBranch(@RequestBody ExpBranchLab expBranchLab) {
        //保存新的实验分室
        if (Objects.nonNull(expBranchLab)) {
            expBranchLabService.saveOrUpdateExpBranch(expBranchLab);
        }
        return R.ok();
    }

    @GetMapping("/getTableList")
    @ResponseBody
    public R getTableList(@RequestParam Map<String, String> params) {
        return R.ok().put("data", expBranchLabService.getTableList(params));
    }
}
