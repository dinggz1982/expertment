package gzhu.edu.cn.exam.modules.experiment.service.impl;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyConfirmType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpApplyHourStatisticsMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
import java.util.Set;

/**
 * <p>
 * 被试实验学时按类型统计 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-12-08
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpApplyHourStatisticsServiceImpl extends ServiceImpl<ExpApplyHourStatisticsMapper, ExpApplyHourStatistics> implements IExpApplyHourStatisticsService {
    @Resource
    private IExpTypeService expTypeService;
    @Resource
    private IUserService userService;
    @Resource
    private ISignupService signupService;
    @Resource
    private IApplyService applyService;

    @Override
    public void initUserData(Integer userId, String isBase) {
        //查询是否还有未添加的id
        List<Integer> ids = this.baseMapper.getNotExistExpTypeId(userId, isBase);
        if (!ids.isEmpty()) {
            String key = ("initStatistics:" + userId).intern();
            synchronized (key) {
                ids.forEach(item -> {
                    ExpApplyHourStatistics entity = new ExpApplyHourStatistics();
                    entity.setUserId(userId);
                    entity.setApplyTypeId(item);
                    entity.setIsBase(isBase);
                    this.save(entity);
                });
            }
        }
    }

    @Override
    public void calUserHour(Integer userId) {
        //先更新基础数据
        initUserData(userId, "0");
        List<Integer> ids = this.baseMapper.getApplyTypeIdList();
        if (!ids.isEmpty()) {
            ids.forEach(item -> this.baseMapper.updateByUserIdAndTypeId(userId, item, SignUpType.ADMIN_PASS.getCode()));
        }
    }

    @Override
    public List<RealHourGroupByTypeVo> getHourGroupByType(Integer id) {
        Assert.notNull(id, "非法请求!");
        initUserData(id, "0");
        return this.baseMapper.getHourGroupByType(id);
    }


    @Override
    public void updateUserHour(Integer userId, JSONObject hour) {
        Set<String> keys = hour.keySet();
        if (!keys.isEmpty()) {
            User user = userService.getById(userId);
            if (Objects.isNull(user)) {
                throw new RuntimeException("输入非法的用户");
            }
            this.initUserData(userId, "1");
            String key = ("updateUserHour:" + userId).intern();
            synchronized (key) {
                keys.forEach(item -> {
                    //获取需要增加的学分
                    String string = hour.getString(item);
                    if (Objects.nonNull(string) && !string.isEmpty() && !"0".equals(string)) {
                        ExpType type = expTypeService.getById(item);
                        if (Objects.isNull(type)) {
                            throw new RuntimeException("输入非法的实验类型");
                        }
                        try {
                            new BigDecimal(string);
                        } catch (Exception e) {
                            throw new RuntimeException("输入非法的学时数据");
                        }
                        int i = this.baseMapper.updateUserBaseHour(userId, item, string);
                        if (i != 1) {
                            log.error("更新条数不为1,请检查代码");
                            throw new RuntimeException("系统错误");
                        }
                    }
                });
            }
        }

    }

    @Override
    public void updateBySignUpId(Integer signUpId) {
        Signup signup = signupService.getById(signUpId);
        if (Objects.isNull(signup)) {
            //报名信息不存在
            throw new RuntimeException("输入了非法的审核数据");
        }
        Apply apply = applyService.getById(signup.getApplyId());
        if (Objects.isNull(apply)) {
            throw new RuntimeException("该实验不存在");
        }
        this.initUserData(signup.getSignupUserId(), "0");
        String key = (this.getClass().getName() + ":updateBySignUpId:" + signUpId).intern();
        synchronized (key) {
////            this.baseMapper.updateUserNotBaseHour(signup.getSignupUserId(), apply.getTypeId(), SignUpType.ADMIN_PASS.getCode());
//            int i = this.baseMapper.addHour(signup.getSignupUserId(), apply.getTypeId(), signup.getRealHour());
//            if (i != 1) {
//                log.error("更新条数不为1,请检查代码");
//                throw new RuntimeException("系统错误");
//            }
            this.updateUserHourByUserId(signup.getSignupUserId());
        }
    }

    @Override
    public List<ExpApplyHourStatistics> getUserBaseApplyHourStatistics(Serializable userId) {
        return this.baseMapper.getUserBaseApplyHourStatistics(userId);
    }

    @Override
    public void updateUserHourByUserId(Integer userId) {
        initUserData(userId, "0");
        List<Integer> list = this.baseMapper.getAllHourTypeId();
        if (Objects.nonNull(list) && !list.isEmpty()) {
            list.forEach(item -> {
                int val = this.baseMapper.updateUserHourByUserIdAndTypeId(userId, item, SignUpType.ADMIN_PASS.getCode(), ApplyConfirmType.UP_TO_STANDARD.getCode());
                if (val > 1) {
                    throw new RuntimeException("系统异常，请联系管理员");
                }
            });
        }
    }
}
