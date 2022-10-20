package gzhu.edu.cn.exam.modules.system.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.system.entity.ItsFrontTeacher;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import gzhu.edu.cn.exam.modules.system.service.ItsFrontTeacherService;
import gzhu.edu.cn.exam.modules.system.vo.SearchTeacherVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * 后台管理页面：首页教师列表
 *
 * @author Yinglei Jie on 2022/2/22
 */

@Slf4j
@Controller
@RequestMapping("/system/front/teacherList")
public class FrontTeacherListAdminController {
    public static String PREFIX = "/resource/teacher/avatar/";
    @Resource
    private IUserService userService;
    @Resource
    private ItsFrontTeacherService itsFrontTeacherService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "system/front-teacher-list-admin";
    }

    @PostMapping("/searchTeacher")
    @ResponseBody
    public R search(@RequestBody @Validated SearchTeacherVo vo) {
        LambdaQueryWrapper<User> q = new LambdaQueryWrapper<>();
        q.eq(User::getUsername, vo.getName()).eq(User::getIdentity, "教师");
        List<User> list = userService.getBaseMapper().selectList(q);
        return R.ok().put("data", list);
    }

    @PostMapping("/addFrontTeacher/{userId}")
    @ResponseBody
    public R addFrontTeacher(@PathVariable String userId) {
        itsFrontTeacherService.addFrontTeacher(userId);
        return R.ok();
    }

    @RequestMapping("/delById/{id}")
    @ResponseBody
    public R delById(@PathVariable String id) {
        LambdaQueryWrapper<ItsFrontTeacher> u = new LambdaQueryWrapper<>();
        u.eq(ItsFrontTeacher::getUserId, id);
        itsFrontTeacherService.getBaseMapper().delete(u);
        return R.ok();
    }

    @RequestMapping("/getFrontTeacherList")
    @ResponseBody
    public R getFrontTeacherList() {
        List<ItsFrontTeacher> itsFrontTeachers = itsFrontTeacherService.getBaseMapper().selectList(null);
        if (Objects.nonNull(itsFrontTeachers) && !itsFrontTeachers.isEmpty()) {
            List<Integer> idList = itsFrontTeachers.stream().map(ItsFrontTeacher::getUserId).collect(Collectors.toList());
            if (!idList.isEmpty()) {
                LambdaQueryWrapper<User> q = new LambdaQueryWrapper<>();
                q.orderByAsc(User::getFrontSort);
                q.in(User::getId, idList).select(User::getId, User::getFrontSort,
                        User::getAvatarPath, User::getEmail, User::getTel,
                        User::getRealName, User::getPositionName);
                List<User> res = userService.getBaseMapper().selectList(q);
                return R.ok().put("data", res);
            }
        }
        return R.ok().put("data", new ArrayList<>());
    }

    @RequestMapping("/getTeacherAvatar/{path}")
    @ResponseBody
    public byte[] getPhoto(@PathVariable String path) throws Exception {
        File file = new File(PREFIX + path);
        FileInputStream inputStream = new FileInputStream(file);
        byte[] bytes = new byte[inputStream.available()];
        inputStream.read(bytes, 0, inputStream.available());
        return bytes;
    }

    @RequestMapping("/saveTeacherAvatar")
    @ResponseBody
    public R saveTeacherAvatar(MultipartFile file) throws IOException {
        File fileDir = new File(PREFIX);
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        log.error("绝对路径为：{}", fileDir.getAbsolutePath());
        InputStream inputStream = file.getInputStream();
        String contentType = file.getContentType();
        Assert.isTrue(Objects.equals("image/png", contentType) || Objects.equals("image/jpeg", contentType), "请上传图片");
        String originalFilename = file.getOriginalFilename();
        Assert.notNull(originalFilename, "文件名不能为空");
        int i = originalFilename.lastIndexOf(".");
        Assert.isTrue(i > 0, "请上传图片");
        String uuid = UUID.randomUUID().toString();
        String fileName = uuid + originalFilename.substring(i);
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(PREFIX + File.separator + fileName));
        byte[] bs = new byte[1024];
        int len;
        while ((len = inputStream.read(bs)) != -1) {
            bos.write(bs, 0, len);
        }
        bos.flush();
        bos.close();
        return R.ok().put("data", "/system/front/teacherList/getTeacherAvatar/" + fileName);
    }

    @RequestMapping("/updateFrontTeacherInfo")
    @ResponseBody
    public R updateFrontTeacherInfo(@RequestBody User user) {
        //更新首页老师信息
        userService.updateFrontTeacherInfo(user);
        return R.ok();
    }


}
