package gzhu.edu.cn.exam.modules.front.controller;

import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.experiment.vo.LabSearchPageVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2022/3/5
 */
@Slf4j
@RestController
@RequestMapping("/api/front/lab")
public class FrontLabController {
    @Resource
    private ILabService labService;

    @RequestMapping("/list")
    @ResponseBody
    public R list(@RequestParam(required = false, defaultValue = "1") int page, @RequestParam(required = false, defaultValue = "10") int limit) {
        LabSearchPageVo vo = new LabSearchPageVo();
        vo.setPage(page);
        vo.setLimit(limit);
        vo.setFrontShow("1");
        return R.ok().put("data", labService.getLabPage(vo));
    }
}
