package gzhu.edu.cn.exam.modules.borrow.controller;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.borrow.enums.LabBorrowStatusEnum;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
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
 * 借用列表页面控制器
 *
 * @author Yinglei Jie on 2021/12/11
 */
@Slf4j
@Controller
@RequestMapping("/borrow/list/")
public class BorrowListController {

    @Resource
    private IExpLabRecordService expLabRecordService;
    @Resource
    private IUserService userService;
    @Resource
    private ExpInstrumentRecordService expInstrumentRecordService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/borrow/borrow-list";
    }

    @GetMapping("/getBorrowStatusList")
    @ResponseBody
    public R getBorrowStatusList() {
        JSONArray json = new JSONArray();
        LabBorrowStatusEnum[] values = LabBorrowStatusEnum.values();
        for (LabBorrowStatusEnum value : values) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.putOpt("id", value.getCode());
            jsonObject.putOpt("desc", value.getDesc());
            json.put(jsonObject);
        }
        return R.ok().put("data", json);
    }

    @GetMapping("/labList")
    @ResponseBody
    public R getLabList(@RequestParam(required = false, defaultValue = "1") Integer page,
                        @RequestParam(required = false, defaultValue = "10") Integer limit,
                        Authentication authentication) {
        //获取当前当前用户
        User currentUser = userService.findByName(authentication.getName());
        return R.ok().put("data", expLabRecordService.selectUserApplyLabList(page, limit, currentUser));
    }

    @GetMapping("/instrumentList")
    @ResponseBody
    public R instrumentList(@RequestParam(required = false, defaultValue = "1") Integer page,
                            @RequestParam(required = false, defaultValue = "10") Integer limit,
                            Authentication authentication) {
        //获取当前当前用户
        User currentUser = userService.findByName(authentication.getName());
        return R.ok().put("data", expInstrumentRecordService.selectUserApplyInstrumentList(page, limit, currentUser));
    }
}
