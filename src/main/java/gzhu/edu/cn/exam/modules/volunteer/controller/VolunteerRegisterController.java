package gzhu.edu.cn.exam.modules.volunteer.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.volunteer.enums.DiagnosisType;
import gzhu.edu.cn.exam.modules.volunteer.service.VolunteerRegisterService;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2022/2/28
 */
@Slf4j
@Controller
@RequestMapping("/volunteer/register")
public class VolunteerRegisterController {
    @Resource
    private VolunteerRegisterService volunteerRegisterService;


    @GetMapping("/getDiagnosisType")
    @ResponseBody
    public R getDiagnosisType() {
        JSONArray jsonArray = new JSONArray();
        DiagnosisType[] values = DiagnosisType.values();
        for (DiagnosisType value : values) {
            JSONObject json = new JSONObject();
            json.put("code", value.getCode());
            json.put("desc", value.getDesc());
            jsonArray.add(json);
        }
        return R.ok().put("data", jsonArray);
    }

    @GetMapping({"/", "index"})
    public String index() {
        return "volunteer/volunteer-register";
    }

    @PostMapping("/saveVolunteerRegister")
    @ResponseBody
    public R saveVolunteerRegister(@RequestBody VolunteerRegisterVo vo) {
        log.error("前端传值：{}", vo);
        volunteerRegisterService.saveVolunteerRegister(vo);
        return R.ok();
    }
}
