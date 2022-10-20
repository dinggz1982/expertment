package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.mapper.LabMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.experiment.vo.LabSearchPageVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Objects;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:48
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class LabServiceImpl extends ServiceImpl<LabMapper, Lab> implements ILabService {
    @Override
    public PageData<Lab> getPage(int page, int limit, Lab lab) {
        PageData<Lab> schoolPageData = new PageData<>();
        Page<Lab> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Lab> queryWrapper = new LambdaQueryWrapper<>();
        //不显示自定义实验室
        queryWrapper.ne(Lab::getIsCustomize, 1);
        if (lab.getName() != null && lab.getName().length() > 0) {
            queryWrapper.like(Lab::getName, lab.getName());
        }
        IPage<Lab> ipage = this.page(pageInfo, queryWrapper);
        //总记录数
        schoolPageData.setCount(ipage.getTotal());
        //当前分页的记录
        schoolPageData.setData(ipage.getRecords());
        //正确的分页响应code为0
        schoolPageData.setCode(0);
        schoolPageData.setMsg("实验室分页");
        return schoolPageData;
    }


    @Override
    public IPage<Lab> getLabPage(LabSearchPageVo vo) {
        IPage<Lab> pageData = new Page<>(vo.getPage(), vo.getLimit());
        LambdaQueryWrapper<Lab> queryWrapper = new LambdaQueryWrapper<>();
        //不显示自定义实验室
        queryWrapper.ne(Lab::getIsCustomize, 1);
        if (Objects.nonNull(vo.getName()) && !vo.getName().isEmpty()) {
            queryWrapper.like(Lab::getName, vo.getName());
        }
        if (Objects.nonNull(vo.getFrontShow())) {
            queryWrapper.eq(Lab::getFrontShow, vo.getFrontShow());
        }
        //按照sort字段排序
        queryWrapper.orderByDesc(Lab::getFrontShow).orderByAsc(Lab::getSort);
        this.page(pageData, queryWrapper);
        return pageData;
    }

    @Override
    public void updateLabSort(Lab lab) {
        Assert.notNull(lab.getId(), "非法数据");
        Lab data = this.getById(lab.getId());
        Assert.notNull(data, "实验室不存在");
        int sortData = lab.getSort();
        data.setSort(sortData);
        this.updateById(data);
    }

    @Override
    public Lab getByName(String name) {
        QueryWrapper<Lab> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("name",name);
        return this.getOne(queryWrapper);
    }
}
