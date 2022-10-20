package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpTypeMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:48
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpTypeServiceImpl extends ServiceImpl<ExpTypeMapper, ExpType> implements IExpTypeService {
    @Override
    public PageData<ExpType> getPage(int page, int limit, ExpType xexpType) {
        PageData<ExpType> schoolPageData = new PageData<ExpType>();
        Page pageInfo = new Page(page, limit);
        QueryWrapper<ExpType> queryWrapper = new QueryWrapper<>();
        if (xexpType.getName() != null && xexpType.getName().length() > 0) {
            queryWrapper.like("name", xexpType.getName());
        }
        IPage ipage = this.page(pageInfo, queryWrapper);
        schoolPageData.setCount(ipage.getTotal());//总记录数
        schoolPageData.setData(ipage.getRecords());//当前分页的记录
        schoolPageData.setCode(0);//正确的分页响应code为0
        schoolPageData.setMsg("实验室分页");
        return schoolPageData;
    }
}
