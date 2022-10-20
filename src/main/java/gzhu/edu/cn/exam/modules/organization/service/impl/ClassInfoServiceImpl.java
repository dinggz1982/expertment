package gzhu.edu.cn.exam.modules.organization.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.ClassInfo;
import gzhu.edu.cn.exam.modules.organization.mapper.ClassInfoMapper;
import gzhu.edu.cn.exam.modules.organization.service.IClassInfoService;
import gzhu.edu.cn.exam.modules.organization.service.ICollegeService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @program: mix-tech
 * @description: 专业服务
 * @author: 丁国柱
 * @create: 2021-05-01 19:22
 */
@Service
public class ClassInfoServiceImpl extends ServiceImpl<ClassInfoMapper, ClassInfo> implements IClassInfoService {

    @Resource
    private ISchoolService schoolService;
    @Resource
    private ICollegeService collegeService;
    @Resource
    private IMajorService majorService;

    @Override
    public PageData<ClassInfo> getPage(int page, int limit, ClassInfo classInfo) {
        PageData<ClassInfo> collegePageData = new PageData<>();
        IPage<ClassInfo> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<ClassInfo> queryWrapper = new LambdaQueryWrapper<>();
        if (classInfo.getName() != null && classInfo.getName().length() > 0) {
            queryWrapper.like(ClassInfo::getName, classInfo.getName());
        }
        if (classInfo.getSchoolId() != null && classInfo.getSchoolId() > 0) {
            queryWrapper.eq(ClassInfo::getSchoolId, classInfo.getSchoolId());
        }
        this.page(pageInfo, queryWrapper);
        collegePageData.setCount(pageInfo.getTotal());
        collegePageData.setData(pageInfo.getRecords());
        collegePageData.setCode(0);
        collegePageData.setMsg("班级分页");
        return collegePageData;
    }

    @Override
    public void delClassInfoBySchoolId(int id) {
        LambdaUpdateWrapper<ClassInfo> w = new LambdaUpdateWrapper<>();
        w.eq(ClassInfo::getSchoolId, id);
        this.baseMapper.delete(w);
    }

    @Override
    public void delClassInfoByCollegeId(int id) {
        LambdaUpdateWrapper<ClassInfo> w = new LambdaUpdateWrapper<>();
        w.eq(ClassInfo::getCollegeId, id);
        this.baseMapper.delete(w);
    }

    @Override
    public void delClassInfoByMajorId(int id) {
        LambdaUpdateWrapper<ClassInfo> w = new LambdaUpdateWrapper<>();
        w.eq(ClassInfo::getMajorId, id);
        this.baseMapper.delete(w);
    }
}
