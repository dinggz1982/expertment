package gzhu.edu.cn.exam.modules.organization.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.organization.entity.ClassStudent;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

public interface ClassStudentMapper extends BaseMapper<ClassStudent> {

    @Insert("insert into org_class_student (class_id,student_id) values (${classId},${userId})")
    public void addClassStudent(@Param("classId") int classId,@Param("userId") int userId);


}
