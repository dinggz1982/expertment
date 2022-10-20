package gzhu.edu.cn.exam.modules.borrow.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowDto;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrument;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentService;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2021/12/10
 */
@Slf4j
@Controller
@RequestMapping("/borrow/instrument/")
public class InstrumentBorrowController {

    @Resource
    private ILabService labService;
    @Resource
    private IUserService userService;
    @Resource
    private ExpInstrumentService expInstrumentService;
    @Resource
    private ExpInstrumentRecordService expInstrumentRecordService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/borrow/instrument-borrow";
    }

    @GetMapping("/getInstrumentList")
    @ResponseBody
    public R getLabList() {
        LambdaQueryWrapper<ExpInstrument> w = new LambdaQueryWrapper<>();
        return R.ok().put("data", expInstrumentService.getBaseMapper().selectList(w));
    }

    @PostMapping("/saveInstrumentRecord")
    @ResponseBody
    public R saveInstrumentRecord(@RequestBody @Validated InstrumentBorrowDto dto, Authentication authentication) {
        //获取当前当前用户
        User currentUser = userService.findByName(authentication.getName());
        expInstrumentRecordService.saveInstrumentRecord(dto, currentUser);
        return R.ok("提交成功");
    }

}
