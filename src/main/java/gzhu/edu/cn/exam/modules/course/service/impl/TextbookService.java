package gzhu.edu.cn.exam.modules.course.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.course.entity.Textbook;
import gzhu.edu.cn.exam.modules.course.mapper.TextbookMapper;
import gzhu.edu.cn.exam.modules.course.service.ITextbookService;
import org.springframework.stereotype.Service;

/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-20 21:34
 */
@Service
public class TextbookService extends ServiceImpl<TextbookMapper, Textbook> implements ITextbookService {
    @Override
    public PageData<Textbook> getPage(int page, int limit, Textbook textbook) {
        PageData<Textbook> textbookPageData = new PageData<Textbook>();
        Page pageInfo = new Page(page,limit);
        QueryWrapper<Textbook> queryWrapper = new QueryWrapper<>();
        if(textbook.getName()!=null&&textbook.getName().length()>0){
            queryWrapper.like("name",textbook.getName());
        }
        IPage ipage = this.page(pageInfo,queryWrapper);
        textbookPageData.setCount(ipage.getTotal());//总记录数
        textbookPageData.setData(ipage.getRecords());//当前分页的记录
        textbookPageData.setCode(0);//正确的分页响应code为0
        textbookPageData.setMsg("教材分页");
        return textbookPageData;
    }
}