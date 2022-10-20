package gzhu.edu.cn.exam.modules.organization.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.base.model.TreeData;
import gzhu.edu.cn.exam.base.utils.UploadUserUtils;
import gzhu.edu.cn.exam.modules.knowledge.entity.Knowledge;
import gzhu.edu.cn.exam.modules.organization.entity.ClassInfo;
import gzhu.edu.cn.exam.modules.organization.entity.ClassStudent;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import gzhu.edu.cn.exam.modules.organization.service.IClassInfoService;
import gzhu.edu.cn.exam.modules.organization.service.IClassStudentService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: mix-tech
 * @description:班级管理
 * @author: 丁国柱
 * @create: 2021-05-13 11:58
 */
@Controller
@RequestMapping("/org/classInfo")
public class ClassInfoController {

    @Resource
    private IMajorService majorService;
    @Resource
    private ISchoolService schoolService;
    @Resource
    private IClassInfoService classInfoService;
    @Resource
    private IClassStudentService classStudentService;


    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;

    @Autowired
    private IUserService userService;

    /**
     * 班级管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index(Model model) {
        //获取学校信息
        List<School> schools = this.schoolService.list();
        model.addAttribute("schools", schools);

        return "modules/organization/classInfo";
    }

    @PostMapping("/tree")
    @ResponseBody
    public TreeData<Knowledge> tree() {
        TreeData<Knowledge> treeData = new TreeData<>();
       /* List<Knowledge> knowledges = this.knowledgeService.getKnowledgeBySubjectId(subjectId);
        treeData.setData(knowledges);
        treeData.setCount(knowledges.size());*/
        treeData.setCode(0);
        return treeData;
    }

    /**
     * 保存或更新班级
     *
     * @param classInfo
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(ClassInfo classInfo) {
        ResonseData data = new ResonseData();
        try {
            if (classInfo.getId() != null && classInfo.getId() > 0) {
                this.classInfoService.updateById(classInfo);
                data.setMsg("成功更新班级！");
            } else {
                this.classInfoService.save(classInfo);
                data.setMsg("成功保存班级！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存班级失败");
        }
        return data;
    }

    /**
     * 班级分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<ClassInfo> list(ClassInfo classInfo, int page, int limit) {
        return this.classInfoService.getPage(page, limit, classInfo);
    }


    /**
     * 删除班级
     *
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            this.classInfoService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除班级！");
        } catch (Exception e) {
            data.setMsg("删除用户班级");
            e.printStackTrace();
        }
        return data;
    }

    @GetMapping("/{id}")
    public String classStudent(Model model, @PathVariable Integer id) {
        ClassInfo classInfo = this.classInfoService.getById(id);
        model.addAttribute("classInfo", classInfo);
        return "modules/organization/classStudent";

    }

    /**
     * 班级分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("studentList.json/{clssInfoId}")
    @ResponseBody
    public PageData<ClassStudent> studentList(@PathVariable Integer clssInfoId, ClassStudent classStudent, int page, int limit) {
        classStudent.setClassId(clssInfoId);
        return this.classStudentService.getPage(page, limit, classStudent);
    }


    /**
     * 实现文件上传
     *
     * @throws IOException
     * @throws IllegalStateException
     */
    @PostMapping("/uploadStudent/{classId}")
    @ResponseBody
    public Map<String, Object> saveUserFromFile(@PathVariable Integer classId, @RequestParam("file") MultipartFile file)
            throws IllegalStateException, IOException {
        Map<String, Object> map = new HashMap<>();
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
                    user = this.userService.findByName(user.getUsername());
                    this.classStudentService.addClassStudent(classId, user.getId());
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

    @GetMapping("/getByMajorId/{id}")
    @ResponseBody
    public R getByMajorId(@PathVariable String id) {
        LambdaQueryWrapper<ClassInfo> w = new LambdaQueryWrapper<>();
        w.eq(ClassInfo::getMajorId, id);
        return R.ok().put("data", classInfoService.getBaseMapper().selectList(w));
    }

    @GetMapping("/getById/{id}")
    @ResponseBody
    public R getById(@PathVariable String id) {
        return R.ok().put("data", classInfoService.getById(id));
    }
}
