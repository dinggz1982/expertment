package gzhu.edu.cn.exam.modules.experiment.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 被试实验学时按类型统计 Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2021-12-08
 */
public interface ExpApplyHourStatisticsMapper extends BaseMapper<ExpApplyHourStatistics> {

    /**
     * 查询用户未添加的id
     *
     * @param userId user id
     * @param isBase is base字段
     * @return 返回exp type id
     */
    List<Integer> getNotExistExpTypeId(@Param("userId") Integer userId, @Param("isBase") String isBase);


    /**
     * 获取数据库中 实验类型id列表
     *
     * @return 返回数据
     */
    List<Integer> getApplyTypeIdList();

    /**
     * 根据user id 和type id更新学生获取的总学分
     *
     * @param userId user id
     * @param typeId type id
     * @param status status
     */
    @Deprecated
    void updateByUserIdAndTypeId(@Param("userId") Integer userId, @Param("typeId") Integer typeId, @Param("status") int status);

    /**
     * 查询被试各实验类型获得的总学分
     *
     * @param userId user id
     * @return 返回查询结果
     */
    List<RealHourGroupByTypeVo> getHourGroupByType(@Param("userId") Integer userId);

    /**
     * 增加某个用户某个实验类型的学分
     *
     * @param userId user id
     * @param typeId type id
     * @param num    hour num
     * @return 影响条数
     */
    int addHour(@Param("userId") Serializable userId, @Param("typeId") Serializable typeId, @Param("num") Serializable num);

    /**
     * 获取用户基础用户学时
     *
     * @param userId user id
     * @return 返回列表数据
     */
    List<ExpApplyHourStatistics> getUserBaseApplyHourStatistics(@Param("userId") Serializable userId);

    /**
     * 更新用户的基础实验学时
     *
     * @param userId user id
     * @param typeId type id
     * @param hour   学时
     * @return 返回条数
     */
    int updateUserBaseHour(@Param("userId") Integer userId, @Param("typeId") String typeId, @Param("hour") String hour);

    /**
     * 审核通过，更新用户 type id 下非 is_base记录学分
     *
     * @param signupUserId user id
     * @param typeId       type id
     * @param status       status
     */
    @Deprecated
    void updateUserNotBaseHour(@Param("signupUserId") Integer signupUserId, @Param("typeId") Integer typeId, @Param("status") int status);

    /**
     * 获取所有实验类型
     *
     * @return 返回列表
     */
    List<Integer> getAllHourTypeId();

    /**
     * 更新用户某个实验类型的总获得实验时
     *
     * @param userId      user id
     * @param typeId      type id
     * @param status      status
     * @param confirmType confirm type
     * @return 返回影响条数
     */
    int updateUserHourByUserIdAndTypeId(@Param("userId") Integer userId, @Param("typeId") Integer typeId, @Param("status") int status, @Param("confirmType") int confirmType);
}
