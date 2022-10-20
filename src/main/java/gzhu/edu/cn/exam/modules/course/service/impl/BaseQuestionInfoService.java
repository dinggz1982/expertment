package gzhu.edu.cn.exam.modules.course.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.course.entity.BaseQuestionInfo;
import gzhu.edu.cn.exam.modules.course.mapper.BaseQuestionInfoMapper;
import gzhu.edu.cn.exam.modules.course.service.IBaseQuestionInfoService;
import org.springframework.stereotype.Service;

/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-20 21:34
 */
@Service
public class BaseQuestionInfoService extends ServiceImpl<BaseQuestionInfoMapper, BaseQuestionInfo> implements IBaseQuestionInfoService {

    @Override
    public PageData<BaseQuestionInfo> getPage(int page, int limit, BaseQuestionInfo baseQuestionInfo) {
        PageData<BaseQuestionInfo> schoolPageData = new PageData<BaseQuestionInfo>();
        Page pageInfo = new Page(page,limit);
        QueryWrapper<BaseQuestionInfo> queryWrapper = new QueryWrapper<>();
        if(baseQuestionInfo.getTitle()!=null&&baseQuestionInfo.getTitle().length()>0){
            queryWrapper.like("title",baseQuestionInfo.getTitle());
        }
        IPage ipage = this.page(pageInfo,queryWrapper);
        schoolPageData.setCount(ipage.getTotal());//总记录数
        schoolPageData.setData(ipage.getRecords());//当前分页的记录
        schoolPageData.setCode(0);//正确的分页响应code为0
        schoolPageData.setMsg("试题基本信息分页");
        return schoolPageData;
    }
}