package gzhu.edu.cn.exam.modules.organization.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.College;
import gzhu.edu.cn.exam.modules.organization.mapper.CollegeMapper;
import gzhu.edu.cn.exam.modules.organization.service.IClassInfoService;
import gzhu.edu.cn.exam.modules.organization.service.ICollegeService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

/**
 * @program: mix-tech
 * @description: 学校服务
 * @author: 丁国柱
 * @create: 2021-05-01 19:22
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class CollegeServiceImpl extends ServiceImpl<CollegeMapper, College> implements ICollegeService {

    @Resource
    private IMajorService majorService;
    @Resource
    private IClassInfoService classInfoService;

    @Override
    public PageData<College> getPage(int page, int limit, College college) {
        PageData<College> collegePageData = new PageData<>();
        IPage<College> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<College> queryWrapper = new LambdaQueryWrapper<>();
        if (college.getName() != null && college.getName().length() > 0) {
            queryWrapper.like(College::getName, college.getName());
        }
        if (college.getSchoolId() != null && college.getSchoolId() > 0) {
            queryWrapper.eq(College::getSchoolId, college.getSchoolId());
        }
        this.page(pageInfo, queryWrapper);
        collegePageData.setCount(pageInfo.getTotal());
        collegePageData.setData(pageInfo.getRecords());
        collegePageData.setCode(0);
        collegePageData.setMsg("学院分页");
        return collegePageData;
    }

    @Override
    public List<Integer> getExistCollegeBySchool(Serializable schoolId) {
        return this.baseMapper.getExistCollegeBySchool(schoolId);
    }

    @Override
    public void delCollegeBySchoolId(int id) {
        LambdaUpdateWrapper<College> w = new LambdaUpdateWrapper<>();
        w.eq(College::getSchoolId, id);
        this.baseMapper.delete(w);
    }

    @Override
    public void delCollegeById(int id) {
        //删除相关专业
        majorService.delMajorByCollegeId(id);
        //删除相关班级
        classInfoService.delClassInfoByCollegeId(id);
        this.removeById(id);
    }
}
