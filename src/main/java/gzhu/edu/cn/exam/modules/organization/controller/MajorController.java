package gzhu.edu.cn.exam.modules.organization.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.organization.entity.Major;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: mix-tech
 * @description:专业控制器
 * @author: 丁国柱
 * @create: 2021-05-12 14:31
 */
@Controller
@RequestMapping("/org/major")
public class MajorController {

    @Resource
    private IMajorService majorService;

    @Resource
    private ISchoolService schoolService;

    /**
     * 专业管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index(Model model) {
        //获取学校信息
        List<School> schools = this.schoolService.list();
        model.addAttribute("schools", schools);
        return "modules/organization/major";
    }

    /**
     * 根据学院id获取专业信息
     *
     * @param collegeId
     * @return
     */
    @PostMapping("/getMajorByCollegeId")
    @ResponseBody
    public Map<String, Object> getCollegeBySchoolId(Integer collegeId) {
        Map<String, Object> map = new HashMap<>();
        try {
            QueryWrapper<Major> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("college_id", collegeId);
            map.put("code", 200);
            map.put("data", this.majorService.list(queryWrapper));
        } catch (Exception e) {
            map.put("code", 500);
            e.printStackTrace();
        }
        return map;
    }


    /**
     * 保存或更新专业
     *
     * @param major
     * @return
     */
    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Major major) {
        ResonseData data = new ResonseData();
        try {
            if (major.getId() != null && major.getId() > 0) {
                this.majorService.updateById(major);
                data.setMsg("成功更新专业！");
            } else {
                this.majorService.save(major);
                data.setMsg("成功保存专业！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存专业失败");
        }
        return data;
    }

    /**
     * 专业分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<Major> list(Major major, int page, int limit) {
        return this.majorService.getPage(page, limit, major);
    }


    /**
     * 删除专业
     *
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            majorService.delMajorById(id);
            data.setCode(200);
            data.setMsg("成功删除专业！");
        } catch (Exception e) {
            data.setMsg("删除用户专业");
            e.printStackTrace();
        }
        return data;
    }

    @GetMapping("/getByCollegeId/{id}")
    @ResponseBody
    public R getByCollegeId(@PathVariable String id) {
        LambdaQueryWrapper<Major> w = new LambdaQueryWrapper<>();
        w.eq(Major::getCollegeId, id);
        return R.ok().put("data", majorService.getBaseMapper().selectList(w));
    }


    @GetMapping("/getById/{id}")
    @ResponseBody
    public R getById(@PathVariable String id) {
        return R.ok().put("data", majorService.getById(id));
    }
}
