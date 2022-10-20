package gzhu.edu.cn.exam.modules.organization.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.organization.entity.College;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import gzhu.edu.cn.exam.modules.organization.service.ICollegeService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @program: mix-tech
 * @description:学院控制器
 * @author: 丁国柱
 * @create: 2021-05-12 14:31
 */
@Controller
@RequestMapping("/org/college")
public class CollegeController {

    @Resource
    private ICollegeService collegeService;

    @Resource
    private ISchoolService schoolService;

    /**
     * 学院管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index(Model model) {
        //获取学校西信息
        List<School> schools = this.schoolService.list();
        model.addAttribute("schools", schools);
        return "modules/organization/college";
    }


    @PostMapping("/getCollegeBySchoolId")
    @ResponseBody
    public Map<String, Object> getCollegeBySchoolId(Integer schoolId) {
        Map<String, Object> map = new HashMap<>();
        try {
            QueryWrapper<College> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("school_id", schoolId);
            map.put("code", 200);
            map.put("data", this.collegeService.list(queryWrapper));
        } catch (Exception e) {
            map.put("code", 500);
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 保存或更新学院
     *
     * @param college
     * @return
     */
    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(College college) {
        ResonseData data = new ResonseData();
        try {
            if (college.getId() != null && college.getId() > 0) {
                this.collegeService.updateById(college);
                data.setMsg("成功更新学院！");
            } else {
                this.collegeService.save(college);
                data.setMsg("成功保存学院！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存学院失败");
        }
        return data;
    }

    /**
     * 学院分页
     *
     * @param page  页数
     * @param limit 页大小
     * @return
     */
    @GetMapping("/list.json")
    @ResponseBody
    public PageData<College> list(College college, int page, int limit) {
        return this.collegeService.getPage(page, limit, college);
    }


    /**
     * 删除学院
     *
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            collegeService.delCollegeById(id);
            data.setCode(200);
            data.setMsg("成功删除学院！");
        } catch (Exception e) {
            data.setMsg("删除用户学院");
            e.printStackTrace();
        }
        return data;
    }


    @GetMapping("/getBySchoolId/{id}")
    @ResponseBody
    public R getBySchoolId(@PathVariable String id) {
        if (Objects.isNull(id) || id.isEmpty()) {
            return R.error("学校id不能为空!");
        }
        LambdaQueryWrapper<College> w = new LambdaQueryWrapper<>();
        w.eq(College::getSchoolId, id);
        return R.ok().put("data", collegeService.getBaseMapper().selectList(w));
    }
}
