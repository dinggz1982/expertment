package gzhu.edu.cn.exam.modules.system.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.utils.UploadUserUtils;
import gzhu.edu.cn.exam.modules.experiment.enums.IdentityEnum;
import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IRoleService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import gzhu.edu.cn.exam.modules.system.vo.DelUserListVo;
import gzhu.edu.cn.exam.modules.system.vo.UpdatePasswordVo;
import gzhu.edu.cn.exam.modules.system.vo.UpdateUserRoleVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @program: exam
 * @description:用户管理
 * @author: 丁国柱
 * @create: 2021-04-04 22:32
 */
@Slf4j
@Transactional(rollbackFor = Exception.class)
@Controller
@RequestMapping("/system/user/")
public class UserController {

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;

    @Resource
    private IUserService userService;

    @Resource
    private IRoleService roleService;

    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    private BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);


    @GetMapping("/loginError")
    public String loginError(Model model) {
        //登录失败返回错误信息
        model.addAttribute("errMsg", "用户名或密码不正确!");
        return "redirect:/login";
    }

    /**
     * 用户管理页面
     *
     * @return
     */
    @GetMapping("index")
    public String index(Model model) {
        List<Role> roles = roleService.getBaseMapper().selectList(null);
        if (!roles.isEmpty()) {
            roles.forEach(item -> item.setMenus(null));
        }
        model.addAttribute("roles", JSONUtil.parse(roles));
        return "/system/user/index-vue";
    }

    @GetMapping("/updateUserInfoPage")
    public String updateUserInfoPage(Authentication authentication, Model model) {
        User currentUser = userService.findByName(authentication.getName());
        currentUser.setPassword(null);
        model.addAttribute("user", JSONUtil.toJsonStr(currentUser));
        return "/system/user/updateUserInfo";
    }

    /**
     * 保存或用户
     *
     * @param user
     * @return
     */
    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(User user) {
        ResonseData data = new ResonseData();
        try {
            int result = this.userService.saveOrUpdateUser(user);
            if (result == 2) {
                data.setCode(200);
                data.setMsg("成功更新用户！");
            } else if (result == 1) {
                data.setCode(200);
                data.setMsg("成功保存用户！");
            } else {
                data.setCode(0);
                data.setMsg("该用户已存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存用户失败");
        }
        return data;
    }

    /**
     * 用户分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("/list.json")
    @ResponseBody
    public PageData<User> list(User user, int page, int limit, @RequestParam Map<String, String> params) {
        PageData<User> pageInfo = this.userService.getPage(page, limit, user, params);
        List<User> data = pageInfo.getData();
        if (Objects.nonNull(data) && !data.isEmpty()) {
            data.forEach(item -> item.setHourStatistics(expApplyHourStatisticsService.getUserBaseApplyHourStatistics(item.getId())));
        }
        return pageInfo;
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
            userService.delUserById(id);
            data.setCode(200);
            data.setMsg("成功删除用户！");
        } catch (Exception e) {
            data.setMsg("删除用户失败");
            e.printStackTrace();
        }
        return data;
    }

    /**
     * 用户修改密码
     *
     * @return
     */
    @PostMapping("updatePassword")
    @ResponseBody
    public ResonseData updatePassword(@Validated UpdatePasswordVo vo, Authentication authentication) {
        System.out.println(authentication.getName());
        User currentUser = this.userService.findByName(authentication.getName());
        ResonseData data = new ResonseData();
        if (Objects.equals(vo.getNewPsw(), vo.getRePsw())) {
//            BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
            if (!bc.matches(vo.getOldPsw(), currentUser.getPassword())) {
                data.setCode(-1);
                data.setMsg("旧密码错误！");
                return data;
            }
            //密码正确
            this.userService.resetPassword(currentUser, vo.getRePsw());
            data.setCode(200);
            data.setMsg("成功修改密码！");
        }
        return data;
    }


    /**
     * 修改用户密码，默认为123456
     *
     * @param user 前端用户
     * @return
     */
    @PostMapping("resetPassword")
    @ResponseBody
    public ResonseData resetPassword(User user) {
        ResonseData data = new ResonseData();
        try {
            String password = "123456";
//            BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
            user.setPassword(bc.encode(password));
            this.userService.resetPassword(user, password);
            data.setCode(200);
            data.setMsg("成功修改密码！");
        } catch (Exception e) {
            data.setMsg("修改密码用户失败");
            e.printStackTrace();
        }
        return data;
    }

    /**
     * 实现文件上传
     *
     * @throws IOException
     * @throws IllegalStateException
     */
    @PostMapping("/saveUserFromFile")
    @ResponseBody
    @Deprecated
    public Map<String, Object> saveUserFromFile(@RequestParam("file") MultipartFile file)
            throws IllegalStateException, IOException {
        Map<String, Object> map = new HashMap<>(16);
        String result = "success";
        try {
            // 如果文件不为空，写入上传路径
            if (!file.isEmpty()) {
                // 上传文件名
                String filename = file.getOriginalFilename();
                String path = uploadFolder + "studentFile/";
                File filepath = new File(path, filename);
                // 判断路径是否存在，如果不存在就创建一个
                if (!filepath.getParentFile().exists()) {
                    filepath.getParentFile().mkdirs();
                }
                // 将上传文件保存到一个目标文件当中
                file.transferTo(new File(path + File.separator + filename));
                // 输出文件上传最终的路径 测试查看
                List<User> users = UploadUserUtils.getUsers(path + File.separator + filename, "/t");

                //批量保存用户
                // this.userService.saveBatchUser(users);
                for (User user : users) {
                    this.userService.saveOrUpdateUser(user);
                }
                map.put("code", 0);
                map.put("msg", "用户上传成功");
            }
        } catch (Exception e) {
            map.put("msg", "用户上传失败！");
            e.printStackTrace();
        }
        return map;
    }

    @PostMapping("/delUserList")
    @ResponseBody
    public R delUser(@RequestBody DelUserListVo vo) {
        List<Integer> ids = vo.getIds();
        if (Objects.nonNull(ids) && !ids.isEmpty()) {
            ids.forEach(item -> {
                if (item != 1) {
                    //不能删除管理员
                    userService.delUserById(item);
                }
            });
        }
        return R.ok("删除成功!");
    }

    @GetMapping("/delUser/{userId}")
    @ResponseBody
    public R delUser(@PathVariable String userId) {
        if (!"1".equals(userId)) {
            //不能删除管理员用户
            userService.delUserById(userId);
        }
        return R.ok("删除成功!");
    }

    @GetMapping("/checkUsername/{username}")
    @ResponseBody
    public R checkUsername(@PathVariable String username) {
        if ("0000".equals(username)) {
            //若无导师，则填入0000
            return R.ok();
        }
        LambdaQueryWrapper<User> w = new LambdaQueryWrapper<>();
        w.eq(User::getUsername, username);
        User user = userService.getBaseMapper().selectOne(w);
        if (Objects.nonNull(user)) {
            return R.ok();
        } else {
            return R.error();
        }
    }

//    private String[] IGNORE_URL = {"/login", "/vue/", "/static/", "/system/registry/registry", "/system/user/checkUserInfoIsComplete", "/element-ui/", "/system/registry/toRegistry"};

    @GetMapping("/checkUserInfoIsComplete")
    @ResponseBody
    public R checkUserInfoIsComplete(HttpServletRequest request, Authentication authentication) {
//        String requestURI = request.getRequestURI();
//        log.error("url为：{}", requestURI);
//        for (int i = 0; i < IGNORE_URL.length; i++) {
//            if (requestURI.startsWith(IGNORE_URL[i])) {
//                return R.ok().put("data", true);
//            }
//        }
        //获取当前登录用户
        User currentUser = userService.findByName(authentication.getName());
        Set<Role> roles = currentUser.getRoles();
        if (Objects.nonNull(roles) && !roles.isEmpty()) {
            Set<Integer> collect = roles.stream().map(Role::getId).collect(Collectors.toSet());
            if (collect.contains(1)) {
                //超级管理员身份,跳过
                return R.ok().put("data", true);
            } else {
                //不是超级管理员和管理员
                if (IdentityEnum.TEACHER.getName().equals(currentUser.getIdentity())) {
                    return checkTeacher(currentUser);
                } else if (IdentityEnum.GRADUATE_STUDENT.getName().equals(currentUser.getIdentity()) ||
                        IdentityEnum.UNDERGRADUATE_STUDENT.getName().equals(currentUser.getIdentity())) {
                    return checkStudent(currentUser);
                } else {
                    //身份为空,判断角色中是否为
                    if (collect.contains(3)) {
                        //教师角色
                        return checkTeacher(currentUser);
                    } else if (collect.contains(4) || collect.contains(5)) {
                        return checkStudent(currentUser);
                    } else {
                        return checkGeneralUser(currentUser);
                    }
                }
            }
        }
        return R.ok().put("data", true);
    }

    private R checkTeacher(User user) {
        if (Objects.isNull(user.getEmail()) || user.getEmail().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(user.getTel()) || user.getTel().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(user.getWeichat()) || user.getWeichat().isEmpty()) {
            return R.ok().put("data", false);
        }
        return R.ok().put("data", true);
    }

    private R checkStudent(User currentUser) {
        if (Objects.isNull(currentUser.getEmail()) || currentUser.getEmail().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(currentUser.getTeacherNo()) || currentUser.getTeacherNo().isEmpty()) {
            return R.ok().put("data", false);
        }

        if (Objects.isNull(currentUser.getTel()) || currentUser.getTel().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(currentUser.getWeichat()) || currentUser.getWeichat().isEmpty()) {
            return R.ok().put("data", false);
        }
        return R.ok().put("data", true);
    }

    private R checkGeneralUser(User currentUser) {
        if (Objects.isNull(currentUser.getEmail()) || currentUser.getEmail().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(currentUser.getTel()) || currentUser.getTel().isEmpty()) {
            return R.ok().put("data", false);
        }
        if (Objects.isNull(currentUser.getWeichat()) || currentUser.getWeichat().isEmpty()) {
            return R.ok().put("data", false);
        }
        return R.ok().put("data", true);
    }


    @PostMapping("/saveUserInfo")
    @ResponseBody
    public R saveUserInfo(User user, Authentication authentication) {
        User currentUser = userService.findByName(authentication.getName());
        if (Objects.nonNull(currentUser)) {
            LambdaUpdateWrapper<User> w = new LambdaUpdateWrapper<>();
            w.eq(User::getId, currentUser.getId());
            w.set(Objects.nonNull(user.getEmail()) && !user.getEmail().isEmpty(), User::getEmail, user.getEmail());
            w.set(Objects.nonNull(user.getTel()) && !user.getTel().isEmpty(), User::getTel, user.getTel());
            w.set(Objects.nonNull(user.getPassword()) && !user.getPassword().isEmpty(), User::getPassword, bc.encode(user.getPassword()));
            w.set(Objects.nonNull(user.getTeacherNo()) && !user.getTeacherNo().isEmpty(), User::getTeacherNo, user.getTeacherNo());
            w.set(Objects.nonNull(user.getWeichat()) && !user.getWeichat().isEmpty(), User::getWeichat, user.getWeichat());
            w.set(Objects.nonNull(user.getGender()) && !user.getGender().isEmpty(), User::getGender, user.getGender());
            w.set(Objects.nonNull(user.getAge()), User::getAge, user.getAge());
            w.set(User::getSchoolId, user.getSchoolId());
            w.set(User::getCollegeId, user.getCollegeId());
            w.set(User::getMajorId, user.getMajorId());
            w.set(User::getClassId, user.getClassId());
            userService.update(w);
        }
        return R.ok("保存成功");
    }


    @PostMapping("/updateUserRole")
    @ResponseBody
    public R updateUserRole(@RequestBody UpdateUserRoleVo vo) {
        log.debug("前端传值:{}", vo);
        userService.updateUserRole(vo);
        return R.ok();
    }
}
