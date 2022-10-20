package gzhu.edu.cn.exam.modules.experiment.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpSignupStatistics;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyConfirmType;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpSignupStatisticsMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IExpSignupStatisticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;

/**
 * <p>
 * 被试实验统计 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-11-23
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpSignupStatisticsServiceImpl extends ServiceImpl<ExpSignupStatisticsMapper, ExpSignupStatistics> implements IExpSignupStatisticsService {

    @Override
    public ExpSignupStatistics checkData(Integer userId) {
        LambdaQueryWrapper<ExpSignupStatistics> w = new LambdaQueryWrapper<>();
        try {
            w.eq(ExpSignupStatistics::getUserId, userId);
            ExpSignupStatistics one = this.getOne(w);
            if (Objects.isNull(one)) {
                one = new ExpSignupStatistics();
                one.setUserId(userId);
                one.setUpToStandrad(0);
                one.setBelowGrade(0);
                one.setNoShow(0);
                this.save(one);
            }
            return one;
        } catch (Exception e) {
            return this.getOne(w);
        }
    }

    @Override
    public ExpSignupStatistics getByUserId(Integer userId) {
        return checkData(userId);
    }


    @Override
    public void updateByUserId(Integer userId) {
        //更新合格数
        this.baseMapper.updateUpToStandradByUserId(userId, ApplyConfirmType.UP_TO_STANDARD.getCode());
        //更新不合格数
        this.baseMapper.updateBelowGradeByUserId(userId, ApplyConfirmType.BELOW_GRADE.getCode());
        //更新总获得学分
        this.baseMapper.updateTotalScoreByUser(userId, ApplyConfirmType.UP_TO_STANDARD.getCode(), SignUpType.ADMIN_PASS.getCode());
    }
}
