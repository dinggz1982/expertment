package gzhu.edu.cn.exam.modules.course.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.course.entity.SingleChoice;
import gzhu.edu.cn.exam.modules.course.mapper.SingleChoiceMapper;
import gzhu.edu.cn.exam.modules.course.service.ISingleCholceService;
import org.springframework.stereotype.Service;

/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-20 21:34
 */
@Service
public class SingleChoiceService extends ServiceImpl<SingleChoiceMapper, SingleChoice> implements ISingleCholceService {
    @Override
    public PageData<SingleChoice> getPage(int page, int limit, SingleChoice SingleChoice) {
        PageData<SingleChoice> SingleChoicePageData = new PageData<SingleChoice>();
        Page pageInfo = new Page(page,limit);
        QueryWrapper<SingleChoice> queryWrapper = new QueryWrapper<>();
        IPage ipage = this.page(pageInfo,queryWrapper);
        SingleChoicePageData.setCount(ipage.getTotal());//总记录数
        SingleChoicePageData.setData(ipage.getRecords());//当前分页的记录
        SingleChoicePageData.setCode(0);//正确的分页响应code为0
        SingleChoicePageData.setMsg("教材分页");
        return SingleChoicePageData;
    }
}