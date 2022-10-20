package gzhu.edu.cn.exam.modules.organization.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.organization.dto.OrganizationDto;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @program: mix-tech
 * @description: 学校管理
 * @author: 丁国柱
 * @create: 2021-05-01 19:24
 */
@Controller
@RequestMapping("/org/school")
public class SchoolController {
    @Autowired
    private ISchoolService schoolService;

    /**
     * 学校管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index() {
        return "modules/organization/school";
    }


    /**
     * 保存或更新学校
     *
     * @param school
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(School school) {
        ResonseData data = new ResonseData();
        try {
            if (school.getId() != null && school.getId() > 0) {
                this.schoolService.updateById(school);
                data.setMsg("成功更新学校！");
            } else {
                this.schoolService.save(school);
                data.setMsg("成功保存学校！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存学校失败");
        }
        return data;
    }

    /**
     * 学校分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<School> list(School school, int page, int limit) {
        return this.schoolService.getPage(page, limit, school);
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
            schoolService.delSchoolById(id);
            data.setCode(200);
            data.setMsg("成功删除学校！");
        } catch (Exception e) {
            data.setMsg("删除用户学校");
            e.printStackTrace();
        }
        return data;
    }


    @GetMapping("/getSchoolList")
    @ResponseBody
    public R getSchoolList() {
        return R.ok().put("data", schoolService.getBaseMapper().selectList(null));
    }


    @GetMapping("/getSchoolTree")
    @ResponseBody
    public R getSchoolTree() {
        List<OrganizationDto> res = schoolService.getSchoolTree();
        return R.ok().put("data", res);
    }
}
