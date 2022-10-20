package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpLabRecord;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyConfirmType;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.SignupMapper;
import gzhu.edu.cn.exam.modules.experiment.service.*;
import gzhu.edu.cn.exam.modules.experiment.vo.AdminApplyApproveVo;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @program: mix-tech
 * @description:实验报名（被试角色）
 * @author: 丁国柱
 * @create: 2021-05-15 22:48
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class SignupServiceImpl extends ServiceImpl<SignupMapper, Signup> implements ISignupService {
    @Resource
    private IUserService userService;
    @Resource
    private IApplyService applyService;
    @Resource
    private IExpLabRecordService expLabRecordService;
    @Resource
    private ILabService labService;
    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSignup(Signup signup) {
        Apply apply = this.applyService.getById(signup.getApplyId());
        //更新报名人数
        apply.setApplyNumber(apply.getApplyNumber() + 1);
        //更新剩余人数
        apply.setRemains(apply.getRemains() - 1);
        this.applyService.updateById(apply);
        this.save(signup);
    }

    @Override
    @Transactional(readOnly = true)
    public PageData<Signup> getPage(int page, int limit, Integer applyId, User currentUser) {
        PageData<Signup> data = new PageData<>();
        Page<Signup> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Signup> queryWrapper = new LambdaQueryWrapper<>();
        if (Objects.nonNull(applyId) && applyId != -1) {
            queryWrapper.eq(Signup::getApplyId, applyId);
        }
        queryWrapper.orderByDesc(Signup::getId);
        IPage<Signup> ipage = this.page(pageInfo, queryWrapper);
        //总记录数
        data.setCount(ipage.getTotal());
        //当前分页的记录
        data.setData(ipage.getRecords());
        //正确的分页响应code为0
        data.setCode(0);
        return data;
    }

    @Override
    public IPage<Signup> getPage(int page, int limit, Integer applyId, User user, String prop, String order, String filterStatus) {
//        PageData<Signup> data = new PageData<>();

        if (Objects.isNull(order) || order.isEmpty() || Objects.equals("", order)) {
            order = "ASC";
        }
        IPage<Signup> pageInfo = new Page<>(page, limit);
        this.baseMapper.getTeacherApproveStudentSignUpPage(pageInfo, applyId, user.getId(), ApplyType.ADMIN_ACCEPT.getCode(), prop, order, filterStatus);
//
//        LambdaQueryWrapper<Signup> queryWrapper = new LambdaQueryWrapper<>();
//        if (Objects.nonNull(applyId) && applyId != -1) {
//            queryWrapper.eq(Signup::getApplyId, applyId);
//        } else {
//            queryWrapper.in(Signup::getApplyId, applyService.getUserApproveApplyIdList(user.getId()));
//        }
//        queryWrapper.orderByDesc(Signup::getId);
//        IPage<Signup> ipage = this.page(pageInfo, queryWrapper);
//        //总记录数
//        data.setCount(ipage.getTotal());
//        //当前分页的记录
//        data.setData(ipage.getRecords());
//        //正确的分页响应code为0
//        data.setCode(0);
        return pageInfo;
    }

    @Override
    public PageData<Signup> getMyExperimentPage(int page, int limit, Integer userId, String status) {
        PageData<Signup> data = new PageData<>();
        Page<Signup> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Signup> queryWrapper = new LambdaQueryWrapper<>();
//        QueryWrapper<Signup> queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("signup_user_id", userId);
        queryWrapper.eq(Signup::getSignupUserId, userId);
        queryWrapper.orderByDesc(Signup::getId);
        if (Objects.nonNull(status) && !status.isEmpty()) {
            queryWrapper.eq(Signup::getStatus, status);
        }
//        if (Objects.nonNull(team) && !team.isEmpty()) {
//            QueryWrapper<Apply> wp = new QueryWrapper<>();
////            wp.eq("team", team).select("id");
//            List<Apply> applies = applyService.getBaseMapper().selectList(wp);
//            if (!applies.isEmpty()) {
//                queryWrapper.in("apply_id", applies.stream().map(Apply::getId).collect(Collectors.toList()));
//            }
//        }
        IPage<Signup> ipage = this.page(pageInfo, queryWrapper);
        if (!ipage.getRecords().isEmpty()) {
            ipage.getRecords().forEach(item -> {
                //设置实验室时间记录信息
                item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
                if (Objects.nonNull(item.getApply())) {
                    User user = userService.getById(item.getApply().getApplyUserId());
                    user.setPassword(null);
                    item.getApply().setApplyUser(user);
                }
                if (Objects.nonNull(item.getExpLabRecord())) {
                    //设置实验室信息
                    item.setLab(labService.getById(item.getExpLabRecord().getLabId()));
                }
            });
        }
        //总记录数
        data.setCount(ipage.getTotal());
        //当前分页的记录
        data.setData(ipage.getRecords());
        //正确的分页响应code为0
        data.setCode(0);
        return data;
    }

    @Override
    public void confirmSignUp(String signUpId, String confirm, String hour) {
        Signup sign = this.getById(signUpId);
        if (Objects.nonNull(sign)) {
            sign.setConfirmType(Integer.valueOf(confirm));
            if (confirm.equals(String.valueOf(ApplyConfirmType.UP_TO_STANDARD.getCode()))) {
                sign.setRealHour(hour);
                sign.setStatus(SignUpType.MAIN_TEST_CONFIRM.getCode());
            } else if (confirm.equals(String.valueOf(ApplyConfirmType.BELOW_GRADE.getCode()))) {
                sign.setRealHour(null);
                sign.setStatus(SignUpType.BELOW_GRADE.getCode());
            } else {
                //爽约
                sign.setRealHour(null);
                sign.setStatus(SignUpType.NO_SHOW.getCode());
            }
            this.updateById(sign);
        }
        applyService.updateStatisticsById(String.valueOf(sign.getApplyId()));
        expLabRecordService.updateByApplyId(String.valueOf(sign.getApplyId()));
    }

    @Override
    public R signUp(User currentUser, Integer applyId, Integer labRecordId) {
        Apply apply = applyService.getById(applyId);
        if (!apply.getCanSignup().equals(1)) {
            applyService.updateStatisticsById(String.valueOf(applyId));
            throw new RuntimeException("报名人数已满");
        }
        String key = ("signUp:" + applyId + ":" + labRecordId).intern();
        synchronized (key) {
            LambdaQueryWrapper<Signup> qw = new LambdaQueryWrapper<>();
            qw.eq(Signup::getApplyId, applyId).eq(Signup::getSignupUserId, currentUser.getId());
            Signup up = this.baseMapper.selectOne(qw);
            if (Objects.nonNull(up)) {
                //存在
                if (up.getStatus().equals(SignUpType.CANCEL.getCode())) {
                    //已经取消,执行重新报名
                    ExpLabRecord expLabRecord = expLabRecordService.getById(labRecordId);
                    if (Objects.isNull(expLabRecord)) {
                        return R.error("该实验时间段不存在");
                    }
                    int alreadyNum = expLabRecordService.getAlreadyNum(expLabRecord);
                    if (expLabRecord.getNum().equals(alreadyNum)) {
                        return R.error("该实验时间段报名人数已满");
                    }

                    if (expLabRecord.getNum().equals(expLabRecord.getAlreadyNum())) {
                        return R.error("该实验时间段报名人数已满");
                    }
                    up.setStatus(SignUpType.APPLY_ING.getCode());
                    up.setCreateTime(new Date());
                    up.setLabRecordId(labRecordId);
                    this.updateById(up);
                    return R.ok("报名成功");
                } else {
                    //正常状态(申请中或通过审核)
                    return R.error("请忽重复报名");
                }
            } else {
                //没有报名的
                ExpLabRecord expLabRecord = expLabRecordService.getById(labRecordId);
                if (Objects.isNull(expLabRecord)) {
                    return R.error("该实验时间段不存在");
                }
//                int alreadyNum = expLabRecordService.getAlreadyNum(expLabRecord);
                if (expLabRecord.getAlreadyNum() >= expLabRecord.getNum()) {
                    return R.error("该实验时间段报名人数已满");
                }
                up = new Signup();
                up.setSignupUserId(currentUser.getId());
                up.setApplyId(applyId);
                up.setStatus(SignUpType.APPLY_ING.getCode());
                up.setCreateTime(new Date());
                up.setLabRecordId(labRecordId);
                this.save(up);
                return R.ok("报名成功");
            }
        }
    }

    @Override
    public void initRealHourAndConfirmTypeById(String signUpId) {
        this.baseMapper.initRealHourAndConfirmTypeById(signUpId);
    }

    @Override
    public List<RealHourGroupByTypeVo> getHourGroupByType(Integer userId) {
        return this.baseMapper.getHourGroupByType(userId, SignUpType.ADMIN_PASS.getCode());
    }

    @Override
    public void approveSignUp(AdminApplyApproveVo vo) {
        if (Objects.nonNull(vo.getIds()) && !vo.getIds().isEmpty()) {
            LambdaQueryWrapper<Signup> q = new LambdaQueryWrapper<>();
            //只有状态6可以的id可以通过审核
            q.eq(Signup::getStatus, SignUpType.MAIN_TEST_CONFIRM.getCode()).in(Signup::getId, vo.getIds());
            List<Signup> list = this.getBaseMapper().selectList(q);
            if (Objects.nonNull(list) && !list.isEmpty()) {
                LambdaUpdateWrapper<Signup> w = new LambdaUpdateWrapper<>();
                w.in(Signup::getId, list.stream().map(Signup::getId).collect(Collectors.toList()));
                if (vo.getApprove() == 1) {
                    //审核通过
                    w.set(Signup::getStatus, SignUpType.ADMIN_PASS.getCode());
                } else {
                    //审核拒绝
                    w.set(Signup::getStatus, SignUpType.ADMIN_REJECT.getCode())
                            .set(Signup::getRealHour, null)
                            .set(Signup::getConfirmType, null);
                }
                this.update(w);
                if (vo.getApprove() == 1) {
                    //审核通过，增加学生的实验时
                    vo.getIds().forEach(item -> expApplyHourStatisticsService.updateBySignUpId(item));
                }
            }
        }
    }

    @Override
    public IPage<Signup> selectUserCanSignUp(IPage<Signup> pageInfo, Integer id, String name, String startTime, String endTime, String type) {
        return this.baseMapper.selectUserCanSignUp(pageInfo, id, name, startTime, endTime, type);
    }


    @Override
    public IPage<Signup> selectItemDataByOtherInfo(IPage<Signup> pageInfo, String applyId, String expTypeId, String search, Map<String, String> params) {
        return this.baseMapper.selectItemDataByOtherInfo(pageInfo, applyId, expTypeId, search, params);
    }

    @Override
    public IPage<Signup> getAdminApplyResultSignUpPage(IPage<Signup> iPage, Integer applyId, Integer status) {
        return this.baseMapper.getAdminApplyResultSignUpPage(iPage, applyId, status);
    }
}
