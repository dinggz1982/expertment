package gzhu.edu.cn.exam.modules.experiment.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.TeamType;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.experiment.vo.TimeListVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;

/**
 * @program: mix-tech
 * @description:实验申请
 * @author: 丁国柱
 * @create: 2021-05-15 22:46
 */
@Slf4j
@Controller
@RequestMapping("/experiment/apply")
@Transactional(rollbackFor = Exception.class)
public class ApplyController {

    @Resource
    private ILabService labService;

    @Resource
    private IExpTypeService expTypeService;

    @Resource
    private IApplyService applyService;

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;

    @Resource
    private IUserService userService;

    @Resource
    private IExpLabRecordService expLabRecordService;


    /**
     * 获取
     *
     * @return 返回数据
     */
    @ResponseBody
    @GetMapping("/getApplyType")
    public R getStudentApplyType() {
        return R.ok().put("data", ApplyType.show());
    }

    /**
     * 实验申请管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("labs", this.labService.list());
        model.addAttribute("types", this.expTypeService.list());
        model.addAttribute("teamType", TeamType.show());
        return "modules/experiment/apply";
    }


    /**
     * 图片上传
     *
     * @param file
     * @param request
     * @return
     */
    @PostMapping(value = "/uploadImages")
    @ResponseBody
    public Map<String, Object> fileUpload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        if (file.isEmpty()) {
            map.put("code", 0);
            map.put("msg", "文件为空空");
        }
        // 文件名
        String fileName = file.getOriginalFilename();
        // 后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        // 新文件名
        fileName = UUID.randomUUID() + suffixName;
        File dest = new File(uploadFolder + fileName);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);
            map.put("code", 0);
            map.put("msg", "图片上传成功！");
            Image image = new Image();
            image.setSrc(staticAccessPath + fileName);
            map.put("data", image);
        } catch (IOException e) {
            map.put("code", 0);
            map.put("msg", "图片上传异常！");
            e.printStackTrace();
        }
        return map;
    }

    @GetMapping("/recall/{id}")
    @ResponseBody
    public ResonseData recall(@PathVariable String id) {
        Apply apply = this.applyService.getById(id);
        if (Objects.nonNull(apply)) {
            //8表示已撤回
            apply.setStatus(8);
            applyService.updateById(apply);
            expLabRecordService.reCallApply(id);
        }
        ResonseData data = new ResonseData();
        data.setCode(200);
        data.setMsg("撤回成功");
        return data;
    }

    /**
     * 保存或更新实验申请
     *
     * @param apply
     * @return
     */
    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(@RequestBody Apply apply, Authentication authentication) throws ParseException {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
//        apply.fixTeam();
        //获得当前用户的导师信息
        if (currentUser.getTeacherNo() != null &&
                currentUser.getTeacherNo().length() > 0 &&
                !"0000".equals(currentUser.getTeacherNo())) {
            User teacher = this.userService.findByName(currentUser.getTeacherNo());
            if (Objects.nonNull(teacher)) {
                apply.setTeacherConfirmUserId(teacher.getId());
            } else {
                throw new RuntimeException("当前导师不存在，如无导师请设置导师为`0000`");
            }
        }
        apply.setApplyTime(new Date());
        //如果当前用户是老师或管理员，则由管理员进行审核
        ResonseData data = new ResonseData();
//        String dateTime = apply.getDateTime();
//        if (dateTime != null && dateTime.length() > 0) {
//            Date startDate;
//            Date endDate;
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String[] times = dateTime.split(" - ");
////            startDate = sdf.parse(times[0]);
////            endDate = sdf.parse(times[1]);
////            apply.setStartDate(startDate);
////            apply.setEndDate(endDate);
//        }
        try {
            if (apply.getId() != null && apply.getId() > 0) {
                if (apply.getLabId() == 4) {
                    Apply byId = applyService.getById(apply.getId());
                    Lab lab = labService.getById(byId);
                    lab.setName(apply.getCustomize());
                    lab.setIsCustomize(1);
                    labService.updateById(lab);
                } else {
                    apply.setIsCheckTime(1);
                }
                applyService.updateById(apply);
                data.setMsg("成功更新实验申请！");
            } else {
                if (apply.getLabId() == 4) {
                    //自定义实验室
                    apply.setIsCheckTime(0);
                    Lab lab = new Lab();
                    //保存自定义实验室
                    lab.setName(apply.getCustomize());
                    lab.setIsCustomize(1);
                    labService.save(lab);
                    apply.setLabId(lab.getId());
                } else {
                    apply.setIsCheckTime(1);
                }
                apply.setRemains(apply.getNumber());
                this.applyService.save(apply);
                data.setMsg("成功保存实验申请！");
            }
            if (apply.getIsCheckTime() == 1) {
                //检验时间是否冲突
                expLabRecordService.checkApplyLabTime(apply.getId(), apply.getLabId());
            }
            expLabRecordService.saveRecord(apply);
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存实验申请失败");
        }
        applyService.updateStatisticsById(String.valueOf(apply.getId()));
        return data;
    }

    /**
     * 实验申请分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("/list.json")
    @ResponseBody
    @Deprecated
    public PageData<Apply> list(Apply apply, int page, int limit, Authentication authentication) {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        apply.setApplyUserId(currentUser.getId());
        return this.applyService.getPage(page, limit, apply);
    }


    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            this.applyService.removeById(id);
            expLabRecordService.delByApplyId(id);
            data.setCode(200);
            data.setMsg("成功删除实验申请！");
        } catch (Exception e) {
            data.setMsg("删除用户实验申请失败");
            e.printStackTrace();
        }
        return data;
    }


    /**
     * 提交审批
     *
     * @param id
     * @return
     */
    @PostMapping("/approve")
    @ResponseBody
    public ResonseData approve(int id, Authentication authentication) {
        ResonseData data = new ResonseData();
        try {
            User currentUser = this.userService.findByName(authentication.getName());
            if (currentUser.getTeacherNo() != null &&
                    currentUser.getTeacherNo().length() > 0 &&
                    !"0000".equals(currentUser.getTeacherNo())) {
                User teacher = this.userService.findByName(currentUser.getTeacherNo());
                if (Objects.nonNull(teacher)) {
                    Apply apply = applyService.getById(id);
                    apply.setTeacherConfirmUserId(teacher.getId());
                    applyService.updateById(apply);
                } else {
                    throw new RuntimeException("当前导师不存在，如无导师请设置导师为`0000`");
                }
            }
            applyService.updateApply(id, ApplyType.WAIT_TEACHER.getCode());
            data.setCode(200);
            data.setMsg("成功提交实验申请！");
        } catch (Exception e) {
            data.setMsg("提交实验申请失败，请联系管理员！");
            e.printStackTrace();
        }
        return data;
    }

    @ResponseBody
    @PostMapping("/updateLabRecordList/{applyId}/{labId}")
    public R updateLabRecordList(@PathVariable String applyId, @RequestBody List<TimeListVo> data, @PathVariable String labId) {
        //更新实验室时间段
        expLabRecordService.updateLabRecordList(applyId, labId, data);
        return R.ok("更新成功");
    }


    @Data
    class Image {
        private String src;
        private String title;
    }

}
