package gzhu.edu.cn.exam.modules.system.service;


import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.system.entity.ItsFrontTeacher;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author loading
 * @since 2022-02-22
 */
public interface ItsFrontTeacherService extends IService<ItsFrontTeacher> {

    /**
     * 添加一个首页新教师
     *
     * @param userId user id
     */
    void addFrontTeacher(String userId);

}
