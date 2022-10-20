package gzhu.edu.cn.exam.modules.experiment.controller;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;


/**
 * 查询实验控制器
 *
 * @author 84271
 */
@Slf4j
@Controller
@RequestMapping("/experiment/query")
public class QueryExperimentController {

    @Resource
    private IUserService userService;

    @Resource
    private IApplyService applyService;

    @Resource
    private ISignupService signupService;

    @GetMapping({"", "/"})
    public String index(Model model, Authentication authentication) {
        User currentUser = this.userService.findByName(authentication.getName());
        model.addAttribute("currentUser", currentUser);
//        List<String> res = applyService.getTeamInfo(currentUser.getId());
//        JSONArray json = new JSONArray();
//        if (Objects.nonNull(res) && !res.isEmpty()) {
//            for (String re : res) {
//                JSONObject object = new JSONObject();
//                object.put("name", re);
//                object.put("value", re);
//                json.add(object);
//            }
//        }
//        model.addAttribute("team", json.toString());
        List<User> user = userService.getStudentList(currentUser.getUsername());
        JSONArray userJson = new JSONArray();
        if (Objects.nonNull(user) && !user.isEmpty()) {
            for (User re : user) {
                JSONObject object = new JSONObject();
                object.put("name", re.getRealName());
                object.put("value", re.getId());
                userJson.add(object);
            }
        }
        model.addAttribute("user", userJson.toString());
        return "modules/experiment/queryExperiment";
    }


    @GetMapping("/list")
    @ResponseBody
    public PageData<Apply> list(int page, int limit, String team, String userId, Authentication authentication) {
        List<String> userIds = JSONUtil.parseArray(userId).toList(String.class);
        User currentUser = this.userService.findByName(authentication.getName());
        QueryWrapper<Apply> wp = new QueryWrapper<>();
        wp.eq("teacher_confirm_user_id", currentUser.getId())
                .eq(Objects.nonNull(team) && !team.isEmpty(), "team", team)
                .in(Objects.nonNull(userIds) && !userIds.isEmpty(), "apply_user_id", userIds);
        Page<Apply> pageInfo = new Page<>(page, limit);
        applyService.page(pageInfo, wp);
        PageData<Apply> applyPageData = new PageData<>();
        applyPageData.setCount(pageInfo.getTotal());
        applyPageData.setData(pageInfo.getRecords());
        applyPageData.setCode(0);
        return applyPageData;
    }

}
