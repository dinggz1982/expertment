package gzhu.edu.cn.exam.modules.organization.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.organization.dto.ClassAllInfoDto;
import gzhu.edu.cn.exam.modules.organization.dto.OrganizationDto;
import gzhu.edu.cn.exam.modules.organization.entity.School;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 84271
 */
public interface SchoolMapper extends BaseMapper<School> {

    /**
     * 获取存在的学校id
     *
     * @return 返回id列表
     */
    List<Integer> getExistSchoolId();


    /**
     * 获取 学校树状列表
     *
     * @return 返回数据
     */
    List<OrganizationDto> getSchoolTree();

    /**
     * 根据名称获取班级树状信息
     *
     * @param schoolName  学校名称
     * @param collegeName 学院名称
     * @param majorName   专业名称
     * @param className   班级名称
     * @return 返回搜索信息
     */
    ClassAllInfoDto getClassAllInfoByName(@Param("schoolName") String schoolName, @Param("collegeName") String collegeName, @Param("majorName") String majorName, @Param("className") String className);
}
