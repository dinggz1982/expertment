package gzhu.edu.cn.exam.modules.organization.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.ClassStudent;
import gzhu.edu.cn.exam.modules.organization.mapper.ClassStudentMapper;
import gzhu.edu.cn.exam.modules.organization.service.IClassStudentService;
import gzhu.edu.cn.exam.modules.organization.service.ICollegeService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @program: mix-tech
 * @description: 班级-学生服务层代码
 * @author: 丁国柱
 * @create: 2021-05-01 19:22
 */
@Service
public class ClassStudentServiceImpl extends ServiceImpl<ClassStudentMapper, ClassStudent> implements IClassStudentService {

    @Resource
    private ISchoolService schoolService;
    @Resource
    private ICollegeService collegeService;
    @Resource
    private IMajorService majorService;
    @Resource
    private ClassStudentMapper classStudentMapper;

    @Override
    public PageData<ClassStudent> getPage(int page, int limit, ClassStudent classStudent) {
        PageData<ClassStudent> collegePageData = new PageData<>();
        IPage<ClassStudent> pageInfo = new Page<>(page, limit);
        QueryWrapper<ClassStudent> queryWrapper = new QueryWrapper<>();
        if (classStudent.getClassId() != null) {
            queryWrapper.eq("class_id", classStudent.getClassId());
        }
        this.page(pageInfo, queryWrapper);
        collegePageData.setCount(pageInfo.getTotal());
        collegePageData.setData(pageInfo.getRecords());
        collegePageData.setCode(0);
        collegePageData.setMsg("班级-学生分页");
        return collegePageData;
    }

    @Override
    public void addClassStudent(int classId, int userId) {
        QueryWrapper<ClassStudent> classStudentQuery = new QueryWrapper<>();
        classStudentQuery.eq("class_id", classId).eq("student_id", userId);
        classStudentMapper.delete(classStudentQuery);
        classStudentMapper.addClassStudent(classId, userId);
    }

}
