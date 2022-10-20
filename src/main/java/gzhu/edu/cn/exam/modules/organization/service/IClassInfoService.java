package gzhu.edu.cn.exam.modules.organization.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.ClassInfo;

public interface IClassInfoService extends IService<ClassInfo> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param classInfo:检索的班级信息
     * @return 返回分页数据
     */
    PageData<ClassInfo> getPage(int page, int limit, ClassInfo classInfo);

    /**
     * 根据school id删除相关班级
     *
     * @param id school id
     */
    void delClassInfoBySchoolId(int id);

    /**
     * 根据college id 删除相关班级
     *
     * @param id college id
     */
    void delClassInfoByCollegeId(int id);

    /**
     * 根据 major id删除相关班级
     *
     * @param id major id
     */
    void delClassInfoByMajorId(int id);
}
