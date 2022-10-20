package gzhu.edu.cn.exam.modules.organization.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.Major;

public interface IMajorService extends IService<Major> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param major:检索的学院信息
     * @return 返回分页数据
     */
    PageData<Major> getPage(int page, int limit, Major major);

    /**
     * 根据school id删除专业
     *
     * @param id school id
     */
    void delMajorBySchoolId(int id);

    /**
     * 删除相关专业
     *
     * @param id college id
     */
    void delMajorByCollegeId(int id);

    /**
     * 根据id删除专业
     *
     * @param id id
     */
    void delMajorById(int id);

}
