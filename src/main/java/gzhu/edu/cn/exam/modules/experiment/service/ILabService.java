package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.vo.LabSearchPageVo;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface ILabService extends IService<Lab> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param lab:检索的学校信息
     * @return
     */
    PageData<Lab> getPage(int page, int limit, Lab lab);

    /**
     * 后端获取实验室分页数据
     *
     * @param vo 前端传值
     * @return 返回分页数据
     */
    IPage<Lab> getLabPage(LabSearchPageVo vo);


    /**
     * 更新实验室排序
     *
     * @param lab lab 前端传值
     */
    void updateLabSort(Lab lab);

    /**
     * 根据实验室名字查询
     * @param name
     * @return
     */
    Lab getByName(String name);

}
