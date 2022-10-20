package gzhu.edu.cn.exam.modules.experiment.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.experiment.vo.AdminApplyApproveVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * 实验结果审批前端控制器
 *
 * @author 84271
 */
@Slf4j
@Controller
@RequestMapping("/experiment/result")
public class AdminResultApproveController {

    @Resource
    private IApplyService applyService;

    @Resource
    private ISignupService signupService;

    @Resource
    private IUserService userService;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @Resource
    private ILabService labService;

    @Resource
    private IExpTypeService expTypeService;

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        model.addAttribute("status", SignUpType.show());
        List<ExpType> list = expTypeService.getBaseMapper().selectList(null);
        model.addAttribute("type", JSONUtil.parse(list));
        return "/modules/experiment/admin-result-approve-vue";
    }

    @GetMapping("/getApproveApplyList")
    @ResponseBody
    public R getApproveApplyList() {
        LambdaQueryWrapper<Apply> w = new LambdaQueryWrapper<>();
        w.eq(Apply::getStatus, ApplyType.ADMIN_ACCEPT.getCode())
                .orderByDesc(Apply::getApplyTime);
        List<Apply> list = applyService.getBaseMapper().selectList(w);
        return R.ok().put("data", list);
    }

    @GetMapping("/list/{applyId}/{status}")
    @ResponseBody
    public R adminApplySignUpList(int page, int limit, @PathVariable Integer applyId, @PathVariable Integer status) {
//        LambdaQueryWrapper<Signup> w = new LambdaQueryWrapper<>();
        IPage<Signup> iPage = new Page<>(page, limit);
        signupService.getAdminApplyResultSignUpPage(iPage, applyId, status);
        if (!iPage.getRecords().isEmpty()) {
            iPage.getRecords().forEach(item -> {
                item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
                if (Objects.nonNull(item.getApply())) {
                    User user = userService.getById(item.getApply().getApplyUserId());
                    if (Objects.nonNull(user)) {
                        user.setPassword(null);
                        item.getApply().setApplyUser(user);
                    }
                }
                if (Objects.nonNull(item.getExpLabRecord())) {
                    //设置实验室信息
                    item.setLab(labService.getById(item.getExpLabRecord().getLabId()));
                }
            });
        }
        return R.ok().put("data", iPage);
    }

    @PostMapping("/approveSignUp")
    @ResponseBody
    public R approveSignUp(@RequestBody AdminApplyApproveVo vo) {
        signupService.approveSignUp(vo);
        return R.ok("审核成功!");
    }
}
