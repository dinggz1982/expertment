package gzhu.edu.cn.exam.modules.course.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.course.entity.BaseQuestionInfo;

public interface IBaseQuestionInfoService extends IService<BaseQuestionInfo> {


    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param baseQuestionInfo:检索的试题基本信息
     * @return
     */
    public PageData<BaseQuestionInfo> getPage(int page, int limit, BaseQuestionInfo baseQuestionInfo);
}
