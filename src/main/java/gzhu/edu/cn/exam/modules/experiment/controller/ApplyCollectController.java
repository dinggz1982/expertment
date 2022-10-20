package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.mapper.ApplyMapper;
import gzhu.edu.cn.exam.modules.experiment.vo.ApplySignUpCollectDto;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 实验报名汇总数据前端控制器
 *
 * @author Yinglei Jie on 2021/12/29
 */
@Slf4j
@Controller
@RequestMapping("/apply/collect")
public class ApplyCollectController {

    @Resource
    private IUserService userService;

    @Resource
    private ApplyMapper applyMapper;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/apply/apply-collect";
    }


    @GetMapping("/list")
    @ResponseBody
    public R list(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
                  @RequestParam(value = "limit", defaultValue = "10", required = false) int limit,
                  Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        IPage<ApplySignUpCollectDto> pageInfo = new Page<>(page, limit);
        applyMapper.getUserApplyCollectPageData(pageInfo, currentUser.getId());
        return R.ok().put("data", pageInfo);
    }
}
