package gzhu.edu.cn.exam.modules.organization.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.organization.entity.College;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;

public interface CollegeMapper extends BaseMapper<College> {
    /**
     * 根据school id 返回存在的学院列表
     *
     * @param schoolId school id
     * @return 返回列表
     */
    List<Integer> getExistCollegeBySchool(@Param("schoolId") Serializable schoolId);
}
