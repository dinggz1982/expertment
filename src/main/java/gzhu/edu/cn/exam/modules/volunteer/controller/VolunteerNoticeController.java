package gzhu.edu.cn.exam.modules.volunteer.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.system.entity.SystemSetting;
import gzhu.edu.cn.exam.modules.system.service.SystemSettingService;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerNoticeVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2022/3/5
 */
@Slf4j
@Controller
@RequestMapping("/volunteer/notice")
public class VolunteerNoticeController {
    @Resource
    private SystemSettingService systemSettingService;


    private static final String KEY = "volunteer_notice";

    @GetMapping("/")
    public String index() {
        return "volunteer/volunteer-notice";
    }


    @RequestMapping("/getVolunteerNotice")
    @ResponseBody
    public R getVolunteerNotice() {
        LambdaQueryWrapper<SystemSetting> q = new LambdaQueryWrapper<>();
        q.eq(SystemSetting::getSettingKey, KEY);
        SystemSetting systemSetting = systemSettingService.getBaseMapper().selectOne(q);
        return R.ok().put("data", systemSetting);
    }


    @RequestMapping("/saveVolunteerNotice")
    @ResponseBody
    public R saveVolunteerNotice(@RequestBody @Validated VolunteerNoticeVo vo) {
        LambdaUpdateWrapper<SystemSetting> w = new LambdaUpdateWrapper<>();
        w.eq(SystemSetting::getSettingKey, KEY).set(SystemSetting::getValue, vo.getContent());
        systemSettingService.update(w);
        return R.ok();
    }
}
