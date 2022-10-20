package gzhu.edu.cn.exam.modules.experiment.service;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 被试实验学时按类型统计 服务类
 * </p>
 *
 * @author loading
 * @since 2021-12-08
 */
public interface IExpApplyHourStatisticsService extends IService<ExpApplyHourStatistics> {

    /**
     * 新建用户基础数据
     *
     * @param userId user id
     * @param isBase is base字段
     */
    void initUserData(Integer userId, String isBase);

    /**
     * 统计用户各个实验类型的获得总学分
     *
     * @param userId user id
     */
    @Deprecated
    void calUserHour(Integer userId);

    /**
     * 查询被试各实验类型获得的总学分
     *
     * @param id user id
     * @return 返回查询结果
     */
    List<RealHourGroupByTypeVo> getHourGroupByType(Integer id);

    /**
     * 给用户增加实验时
     *
     * @param userId user id
     * @param hour   增加的实验时
     */
    void updateUserHour(Integer userId, JSONObject hour);

    /**
     * 管理员审核通过，增加用户的实验时
     *
     * @param signUpId sign up id
     */
    void updateBySignUpId(Integer signUpId);

    /**
     * 获取用户基础用户学时
     *
     * @param userId user id
     * @return 返回列表数据
     */
    List<ExpApplyHourStatistics> getUserBaseApplyHourStatistics(Serializable userId);

    /**
     * 通过 user id 更新用户实验时数据
     *
     * @param userId user id
     */
    void updateUserHourByUserId(Integer userId);
}
