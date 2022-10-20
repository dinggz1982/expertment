package gzhu.edu.cn.exam.modules.course.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.course.entity.SingleChoice;

/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-20 21:33
 */
public interface ISingleCholceService extends IService<SingleChoice> {
    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param singleCholce:检索的教材信息
     * @return
     */
    public PageData<SingleChoice> getPage(int page, int limit, SingleChoice singleCholce);
}