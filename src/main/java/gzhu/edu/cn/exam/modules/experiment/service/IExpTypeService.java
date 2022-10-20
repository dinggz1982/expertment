package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface IExpTypeService extends IService<ExpType> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param expType:检索的实验类型信息
     * @return
     */
    public PageData<ExpType> getPage(int page, int limit, ExpType expType);

}