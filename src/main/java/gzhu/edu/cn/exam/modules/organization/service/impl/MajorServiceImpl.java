package gzhu.edu.cn.exam.modules.organization.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.Major;
import gzhu.edu.cn.exam.modules.organization.mapper.MajorMapper;
import gzhu.edu.cn.exam.modules.organization.service.IClassInfoService;
import gzhu.edu.cn.exam.modules.organization.service.IMajorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @program: mix-tech
 * @description: 专业服务
 * @author: 丁国柱
 * @create: 2021-05-01 19:22
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class MajorServiceImpl extends ServiceImpl<MajorMapper, Major> implements IMajorService {

    @Resource
    private IClassInfoService classInfoService;

    @Override
    public PageData<Major> getPage(int page, int limit, Major major) {
        PageData<Major> collegePageData = new PageData<>();
        IPage<Major> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Major> queryWrapper = new LambdaQueryWrapper<>();
        if (major.getName() != null && major.getName().length() > 0) {
            queryWrapper.like(Major::getName, major.getName());
        }
        if (major.getSchoolId() != null && major.getSchoolId() > 0) {
            queryWrapper.eq(Major::getSchoolId, major.getSchoolId());
        }
        this.page(pageInfo, queryWrapper);
        collegePageData.setCount(pageInfo.getTotal());
        collegePageData.setData(pageInfo.getRecords());
        collegePageData.setCode(0);
        collegePageData.setMsg("专业分页");
        return collegePageData;
    }

    @Override
    public void delMajorBySchoolId(int id) {
        LambdaUpdateWrapper<Major> w = new LambdaUpdateWrapper<>();
        w.eq(Major::getSchoolId, id);
        this.baseMapper.delete(w);
    }

    @Override
    public void delMajorByCollegeId(int id) {
        LambdaUpdateWrapper<Major> w = new LambdaUpdateWrapper<>();
        w.eq(Major::getCollegeId, id);
        this.baseMapper.delete(w);
    }

    @Override
    public void delMajorById(int id) {
        classInfoService.delClassInfoByMajorId(id);
        this.removeById(id);
    }
}
