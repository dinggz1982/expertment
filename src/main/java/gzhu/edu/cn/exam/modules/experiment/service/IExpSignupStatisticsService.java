package gzhu.edu.cn.exam.modules.experiment.service;


import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpSignupStatistics;

/**
 * <p>
 * 被试实验统计 服务类
 * </p>
 *
 * @author loading
 * @since 2021-11-23
 */
public interface IExpSignupStatisticsService extends IService<ExpSignupStatistics> {


    /**
     * 检查基础数据是否已经存在
     *
     * @param userId user id
     * @return 返回数据库数据
     */
    ExpSignupStatistics checkData(Integer userId);

    /**
     * 通过user id 获取信息
     *
     * @param userId user id
     * @return 返回数据库信息
     */
    ExpSignupStatistics getByUserId(Integer userId);

    /**
     * 根据user id更新信息
     *
     * @param userId user id
     */
    void updateByUserId(Integer userId);
}
