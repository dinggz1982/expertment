package gzhu.edu.cn.exam.modules.experiment.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpSignupStatistics;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 被试实验统计 Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2021-11-23
 */
public interface ExpSignupStatisticsMapper extends BaseMapper<ExpSignupStatistics> {

    /**
     * 更新学生统计合格数
     *
     * @param userId user id
     * @param type   类型id
     */
    void updateUpToStandradByUserId(@Param("userId") Integer userId, @Param("type") Integer type);

    /**
     * 更新学生统计不合格数
     *
     * @param userId user id
     * @param type   类型id
     */
    void updateBelowGradeByUserId(@Param("userId") Integer userId, @Param("type") Integer type);

    /**
     * 更新学生总获得学分数
     *
     * @param userId user id
     * @param type   类型id
     * @param status 状态
     */
    void updateTotalScoreByUser(@Param("userId") Integer userId, @Param("type") Integer type, @Param("status") Integer status);


}
