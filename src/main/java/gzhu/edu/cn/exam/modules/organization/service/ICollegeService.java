package gzhu.edu.cn.exam.modules.organization.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.College;

import java.io.Serializable;
import java.util.List;

public interface ICollegeService extends IService<College> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param college:检索的学院信息
     * @return 返回分页信息
     */
    PageData<College> getPage(int page, int limit, College college);

    /**
     * 根据school id 获取存在的学院列表
     *
     * @param schoolId school id
     * @return 返回列表数据
     */
    List<Integer> getExistCollegeBySchool(Serializable schoolId);

    /**
     * 根据school id删除
     *
     * @param id school id
     */
    void delCollegeBySchoolId(int id);

    /**
     * 根据college id删除学院
     *
     * @param id college id
     */
    void delCollegeById(int id);
}
