package gzhu.edu.cn.exam.modules.organization.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.dto.OrganizationDto;
import gzhu.edu.cn.exam.modules.organization.entity.School;

import java.util.List;

public interface ISchoolService extends IService<School> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param school:检索的学校信息
     * @return 返回分页数据
     */
    PageData<School> getPage(int page, int limit, School school);

    /**
     * 获取存在的学校id
     *
     * @return 返回id列表
     */
    List<Integer> getExistSchoolId();

    /**
     * 根据id删除学校
     *
     * @param id 学校id
     */
    void delSchoolById(int id);

    /**
     * 获取学校树状列表
     *
     * @return 返回数据
     */
    List<OrganizationDto> getSchoolTree();

}
