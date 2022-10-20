package gzhu.edu.cn.exam.modules.organization.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.dto.OrganizationDto;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import gzhu.edu.cn.exam.modules.organization.mapper.SchoolMapper;
import gzhu.edu.cn.exam.modules.organization.service.IClassInfoService;
import gzhu.edu.cn.exam.modules.organization.service.ICollegeService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import gzhu.edu.cn.exam.modules.organization.service.ISchoolService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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
public class SchoolServiceImpl extends ServiceImpl<SchoolMapper, School> implements ISchoolService {

    @Resource
    private ICollegeService collegeService;
    @Resource
    private IMajorService majorService;
    @Resource
    private IClassInfoService classInfoService;

    @Override
    public PageData<School> getPage(int page, int limit, School school) {
        PageData<School> schoolPageData = new PageData<>();
        Page<School> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<School> queryWrapper = new LambdaQueryWrapper<>();
        if (school.getName() != null && school.getName().length() > 0) {
            queryWrapper.like(School::getName, school.getName());
        }
        this.page(pageInfo, queryWrapper);
        schoolPageData.setCount(pageInfo.getTotal());
        schoolPageData.setData(pageInfo.getRecords());
        schoolPageData.setCode(0);
        schoolPageData.setMsg("学校分页");
        return schoolPageData;
    }

    @Override
    public List<Integer> getExistSchoolId() {
        return this.baseMapper.getExistSchoolId();
    }

    @Override
    public void delSchoolById(int id) {
        //删除学院
        collegeService.delCollegeBySchoolId(id);
        //删除专业
        majorService.delMajorBySchoolId(id);
        //删除相关班级
        classInfoService.delClassInfoBySchoolId(id);
        //删除学校
        this.removeById(id);
    }

    @Override
    public List<OrganizationDto> getSchoolTree() {
        return this.baseMapper.getSchoolTree();
    }
}
