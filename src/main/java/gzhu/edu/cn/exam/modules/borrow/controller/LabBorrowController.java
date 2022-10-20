package gzhu.edu.cn.exam.modules.borrow.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2021/12/10
 */
@Slf4j
@Controller
@RequestMapping("/borrow/lab/")
public class LabBorrowController {

    @Resource
    private ILabService labService;

    @Resource
    private IUserService userService;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/borrow/lab-borrow";
    }


    @GetMapping("/getLabList")
    @ResponseBody
    public R getLabList() {
        LambdaQueryWrapper<Lab> w = new LambdaQueryWrapper<>();
        w.eq(Lab::getIsCustomize, 0);
        return R.ok().put("data", labService.getBaseMapper().selectList(w));
    }


    @PostMapping("/saveLabRecord")
    @ResponseBody
    public R saveLabRecord(@RequestBody @Validated LabBorrowDto dto, Authentication authentication) throws Exception {
        //获取当前当前用户
        User currentUser = userService.findByName(authentication.getName());
        Assert.notNull(currentUser, "当前用户不存在");
        expLabRecordService.saveLabRecord(dto, currentUser);
        return R.ok("提交成功");
    }


}
