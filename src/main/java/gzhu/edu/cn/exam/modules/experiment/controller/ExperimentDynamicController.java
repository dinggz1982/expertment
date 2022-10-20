package gzhu.edu.cn.exam.modules.experiment.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.entity.PageEntity;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.ExperimentDynamic;
import gzhu.edu.cn.exam.modules.experiment.service.IExperimentDynamicService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author loading
 * @since 2022-02-17
 */
@Slf4j
@Controller
@RequestMapping("/experiment/dynamic")
public class ExperimentDynamicController {
    @Resource
    private IExperimentDynamicService experimentDynamicService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/experiment/experiment-dynamic-vue";
    }

    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public R saveOrUpdate(@RequestBody @Validated ExperimentDynamic dynamic) {
        if (Objects.isNull(dynamic.getId())) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            dynamic.setCreateTime(sdf.format(new Date()));
        }
        experimentDynamicService.saveOrUpdate(dynamic);
        return R.ok();
    }

    @PostMapping("/listAll")
    @ResponseBody
    public R listAll(@RequestBody PageEntity pageEntity) {
        IPage<ExperimentDynamic> page = new Page<>(pageEntity.getPage(), pageEntity.getLimit());
        LambdaQueryWrapper<ExperimentDynamic> w = new LambdaQueryWrapper<>();
        w.orderByDesc(ExperimentDynamic::getCreateTime).orderByDesc(ExperimentDynamic::getId);
        experimentDynamicService.getBaseMapper().selectPage(page, w);
        return R.ok().put("data", page);
    }

    @PostMapping("/updatePublish")
    @ResponseBody
    public R updatePublish(@RequestBody ExperimentDynamic dynamic) {
        LambdaUpdateWrapper<ExperimentDynamic> w = new LambdaUpdateWrapper<>();
        w.eq(ExperimentDynamic::getId, dynamic.getId()).set(ExperimentDynamic::getIsPublish, dynamic.getIsPublish());
        experimentDynamicService.update(w);
        return R.ok();
    }

    @GetMapping("/delById/{id}")
    @ResponseBody
    public R del(@PathVariable String id) {
        experimentDynamicService.removeById(id);
        return R.ok();
    }


    @GetMapping("/getDynamicList")
    @ResponseBody
    public R getDynamicList(@RequestParam(required = false, defaultValue = "1") Integer page,
                            @RequestParam(required = false, defaultValue = "10") Integer limit) {
        IPage<ExperimentDynamic> pageData = new Page<>(page, limit);
        LambdaQueryWrapper<ExperimentDynamic> w = new LambdaQueryWrapper<>();
        w.eq(ExperimentDynamic::getIsPublish, 1)
                .orderByDesc(ExperimentDynamic::getCreateTime)
                .orderByDesc(ExperimentDynamic::getId);
        experimentDynamicService.getBaseMapper().selectPage(pageData, w);
        return R.ok().put("data", pageData);
    }


}
