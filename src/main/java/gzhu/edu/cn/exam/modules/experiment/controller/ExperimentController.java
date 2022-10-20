package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.*;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.enums.TeamType;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @program: mix-tech
 * @description:实验管理
 * @author: 丁国柱
 * @create: 2021-05-26 15:21
 */
@Controller
@RequestMapping("/experiment")
public class ExperimentController {

    @Resource
    private IApplyService applyService;

    @Resource
    private IUserService userService;

    @Resource
    private ISignupService signupService;

    @Resource
    private ILabService labService;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @Resource
    private IExpTypeService expTypeService;

    @GetMapping("/getLabList")
    @ResponseBody
    public R getLabList() {
        LambdaQueryWrapper<Lab> w = new LambdaQueryWrapper<>();
        w.eq(Lab::getIsCustomize, 0);
        return R.ok().put("data", this.labService.list(w));
    }

    @GetMapping("/getTeamType")
    @ResponseBody
    public R getTeamType() {
        return R.ok().put("data", TeamType.show());
    }

    @GetMapping("/getExpTypeList")
    @ResponseBody
    public R getExpTypeList() {
        return R.ok().put("data", this.expTypeService.list());
    }

    @GetMapping("/add")
    public String add(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        return "modules/experiment/add";
    }

    @GetMapping("/updateApply/{id}")
    public String update(Model model, Authentication authentication, @PathVariable String id) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("applyId", id);
        return "modules/experiment/add";
    }


    @GetMapping("/show/{id}")
    public String show(Model model, Authentication authentication, @PathVariable String id) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("applyId", id);
        model.addAttribute("onlyShow", "1");
        return "modules/experiment/add";
    }

    @GetMapping("/getById/{id}")
    @ResponseBody
    public R getById(@PathVariable String id) {
        Apply apply = this.applyService.getById(id);
        if (Objects.nonNull(apply)) {
////            String team = apply.getTeam();
//            if (Objects.nonNull(team) && !team.isEmpty()) {
//                String[] s = team.split(" ");
//                if (s.length == 2) {
//                    apply.setTeamYear(s[0]);
//                    apply.setTeamId(TeamType.getByName(s[1]));
//                }
//            }
            if (apply.getIsCheckTime() == 0) {
                //自定义实验室
                apply.setCustomize(apply.getLab().getName());
                apply.setLabId(4);
            }
            apply.setExpLabRecordList(expLabRecordService.getByApplyId(id));
        }
        return R.ok().put("data", apply);
    }


    @GetMapping("/{id}")
    public String index(@PathVariable Integer id, Model model) {
        Apply apply = this.applyService.getById(id);
        model.addAttribute("apply", apply);
        return "modules/experiment/experiment";
    }

    /**
     * 实验报名
     *
     * @return 返回jsp页面
     */
    @GetMapping("/signup")
    public String index() {
        return "modules/experiment/signup-vue";
    }

    /**
     * 可报名的实验
     *
     * @param page  分页
     * @param limit 每页条数
     * @return
     */
    @GetMapping("/signup/list.json")
    @ResponseBody
    public PageData<Signup> list(Apply apply,
                                 int page,
                                 int limit,
                                 String name,
                                 Authentication authentication
    ) {
        //return this.signupService.
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        Assert.notNull(currentUser, "登录用户不存在!");
        if (Objects.nonNull(name)) {
            //设置搜索的实验部分名字
            apply.setName(name);
        }
        apply.setStatus(ApplyType.ADMIN_ACCEPT.getCode());
        apply.setIsLock("0");
        PageData<Apply> data = this.applyService.getPage(page, limit, apply);
        List<Apply> applyList = data.getData();
        if (Objects.nonNull(applyList) && !applyList.isEmpty()) {
            PageData<Signup> signupPageData = new PageData<>();
            List<Signup> res = new ArrayList<>();
            applyList.forEach(item -> {
                QueryWrapper<Signup> wp = new QueryWrapper<>();
                wp.eq("apply_id", item.getId()).eq("signup_user_id", currentUser.getId());
                Signup signup = this.signupService.getBaseMapper().selectOne(wp);
                if (Objects.isNull(signup)) {
                    signup = new Signup();
                }
                signup.setApply(item);
                if (Objects.nonNull(signup.getLabRecordId())) {
                    signup.setExpLabRecord(expLabRecordService.getById(signup.getLabRecordId()));
                }
                if (Objects.nonNull(signup.getApply())) {
                    signup.setLab(labService.getById(signup.getApply().getLabId()));
                }
                List<ExpLabRecord> list = expLabRecordService.getAvailableExpLabRecordList(item.getId());
                signup.setAvailableNum(list.size());
                res.add(signup);
            });
            signupPageData.setCode(0);
            signupPageData.setCount(data.getCount());
            signupPageData.setMsg(data.getMsg());
            signupPageData.setData(res);
            return signupPageData;
        } else {
            PageData<Signup> signupPageData = new PageData<>();
            signupPageData.setCode(0);
            signupPageData.setCount(0);
            return signupPageData;
        }
    }


    @GetMapping("/signup/type")
    @ResponseBody
    public R signUpType() {
        return R.ok().put("data", SignUpType.show());
    }

    /**
     * 实验报名
     *
     * @return
     */
    @GetMapping("/signup/save/{applyId}/{labRecordId}")
    @ResponseBody
    public R saveOrUpdate(Authentication authentication, @PathVariable String applyId, @PathVariable String labRecordId) {
        //获取当前当前用户
        User currentUser = this.userService.findByName(authentication.getName());
        if (Objects.isNull(currentUser)) {
            return R.error("当前用户不存在");
        }
        if (Objects.isNull(applyId) || Objects.isNull(labRecordId)) {
            return R.error("提交非法数据");
        }
        Apply apply = applyService.getById(applyId);
        if (Objects.isNull(apply)) {
            return R.error("该实验不存在");
        }
        ExpLabRecord record = expLabRecordService.getById(labRecordId);
        if (Objects.isNull(record)) {
            return R.error("提交非法数据");
        }
        if (record.getNum() - record.getAlreadyNum() < 1) {
            return R.error("该时间段人数已满");
        }
        if (apply.getStatus() != ApplyType.ADMIN_ACCEPT.getCode()) {
            return R.error("该实验状态不正确");
        }
        if ("1".equals(apply.getIsLock())) {
            return R.error("该实验已被锁定");
        }
        R r = signupService.signUp(currentUser, Integer.valueOf(applyId), Integer.valueOf(labRecordId));
        //更新实验时间记录数据
        expLabRecordService.updateRecordAlreadyNum(Integer.valueOf(labRecordId));
        applyService.updateStatisticsById(applyId);
        return r;
    }

    @Resource
    private IExpSignupStatisticsService expSignupStatisticsService;

    @GetMapping("/cancelSignUp/{signUpId}")
    @ResponseBody
    public R cancelSignUp(@PathVariable String signUpId) {
        //取消报名
        Signup signup = signupService.getById(signUpId);
        if (Objects.nonNull(signup)) {
            if (!signup.getStatus().equals(SignUpType.APPLY_ING.getCode())) {
                //记录爽约次数
                String key = ("cancel:" + signup.getSignupUserId()).intern();
                synchronized (key) {
                    ExpSignupStatistics expSignupStatistics = expSignupStatisticsService.getByUserId(signup.getSignupUserId());
                    expSignupStatistics.setNoShow(expSignupStatistics.getNoShow() + 1);
                    expSignupStatisticsService.updateById(expSignupStatistics);
                }
            }
            signup.setStatus(SignUpType.CANCEL.getCode());
            signupService.updateById(signup);
            //更新已报名人数
            expLabRecordService.updateRecordAlreadyNum(signup.getLabRecordId());
            applyService.updateStatisticsById(String.valueOf(signup.getApplyId()));
        }
        signupService.initRealHourAndConfirmTypeById(signUpId);
        return R.ok("取消成功");
    }

//
//    /**
//     * 实验报名
//     *
//     * @param signup
//     * @return
//     */
//    @PostMapping("/signup/save/{applyId}/{labRecordId}")
//    @ResponseBody
//    public ResonseData saveOrUpdate(@PathVariable Integer applyId, Signup signup, Authentication authentication) throws ParseException {
//        //获取当前当前用户
//        User currentUser = this.userService.findByName(authentication.getName());
//        Assert.notNull(currentUser, "用户不存在");
//        ResonseData data = new ResonseData();
//        try {
//            QueryWrapper<Signup> qw = new QueryWrapper<>();
//            qw.eq("apply_id", applyId).eq("signup_user_id", currentUser.getId());
//            Signup up = this.signupService.getBaseMapper().selectOne(qw);
//            if (Objects.nonNull(up)) {
//                data.setMsg("请忽重复报名");
//                return data;
//            }
//            signup.setApplyId(applyId);
//            signup.setCreateTime(new Date());
//            signup.setSignupUserId(currentUser.getId());
//            signup.setStatus(SignUpType.APPLY_ING.getCode());
//            this.signupService.saveSignup(signup);
//            data.setMsg("报名成功！");
//            data.setCode(200);
//        } catch (Exception e) {
//            e.printStackTrace();
//            data.setMsg("报名失败");
//        }
//        return data;
//    }

    @ResponseBody
    @GetMapping("/getLabRecordByApplyId/{id}")
    public R getLabRecordByApplyId(@PathVariable String id) {
        LambdaQueryWrapper<ExpLabRecord> w = new LambdaQueryWrapper<>();
        w.eq(ExpLabRecord::getApplyId, id);
        //获取实验时间记录列表
        List<ExpLabRecord> expLabRecords = expLabRecordService.getBaseMapper().selectList(w);
        return R.ok().put("data", expLabRecords);
    }


}
