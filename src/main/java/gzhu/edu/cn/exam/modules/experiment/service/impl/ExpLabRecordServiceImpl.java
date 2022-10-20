package gzhu.edu.cn.exam.modules.experiment.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.exception.LabException;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowDto;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.SubmitApproveDto;
import gzhu.edu.cn.exam.modules.borrow.enums.LabBorrowStatusEnum;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpLabRecord;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpLabRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.experiment.utils.TimeUtil;
import gzhu.edu.cn.exam.modules.experiment.vo.TimeListVo;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static gzhu.edu.cn.exam.base.utils.TimeUtils.getAlphalDate;

/**
 * <p>
 * 实验室申请记录表 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-11-20
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpLabRecordServiceImpl extends ServiceImpl<ExpLabRecordMapper, ExpLabRecord> implements IExpLabRecordService {

    @Resource
    private ISignupService signupService;
    @Resource
    private IApplyService applyService;
    @Resource
    private IUserService userService;
    @Resource
    private ILabService labService;

    @Resource
    private ExpLabRecordMapper expLabRecordMapper;

    private static final long ONE_DAY_MS = 86400000L;

    @Override
    public void delByApplyId(Integer applyId) {
        LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
        w.eq(ExpLabRecord::getApplyId, applyId);
        this.baseMapper.delete(w);
    }

    @Override
    public void saveRecord(Apply apply) {
        String key = "save:" + String.valueOf(apply.getId()).intern();
        synchronized (key) {
            if (Objects.nonNull(apply.getId())) {
                List<TimeListVo> list = apply.getLabSignUpList();
                if (Objects.nonNull(list) && !list.isEmpty()) {
                    this.delByApplyId(apply.getId());
                    list.forEach(item -> {
                        ExpLabRecord record = new ExpLabRecord();
                        record.setApplyId(apply.getId());
                        record.setLabId(apply.getLabId());
                        record.setNum(item.getNum());
                        record.setStartTime(item.getStartTime());
                        record.setEndTime(item.getEndTime());
                        this.save(record);
                    });
                }
            }
        }
    }

    @Override
    public List<ExpLabRecord> getByApplyId(String id) {
        LambdaQueryWrapper<ExpLabRecord> w = new LambdaQueryWrapper<>();
        w.eq(ExpLabRecord::getApplyId, id);
        return this.baseMapper.selectList(w);
    }

    @Override
    public void reCallApply(String id) {
        LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
        w.eq(ExpLabRecord::getApplyId, id).set(ExpLabRecord::getIsPass, 0);
        this.update(w);
    }

    @Override
    public int checkLab(Integer id, String start, String end) {
        if (Objects.isNull(id)) {
            return this.baseMapper.checkLab(id, start, end);
        }
        return 0;
    }


    @Override
    public int getAlreadyNum(ExpLabRecord item) {
        LambdaQueryWrapper<Signup> w = new LambdaQueryWrapper<>();
        w.eq(Signup::getLabRecordId, item.getId()).ne(Signup::getStatus, SignUpType.CANCEL.getCode());
        return signupService.getBaseMapper().selectCount(w);
    }


    @Override
    public void updateRecordAlreadyNum(Integer labRecordId) {
        this.baseMapper.updateRecordAlreadyNum(labRecordId);
    }

    @Override
    public void updateLabRecordList(String applyId, String labId, List<TimeListVo> vo) {
        if (vo.size() == 0) {
            //列表为0,把数据库的数据全删除了
            LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
            w.eq(ExpLabRecord::getApplyId, applyId);
            this.baseMapper.delete(w);
        }
        Apply apply = applyService.getById(applyId);
        if (Objects.isNull(apply)) {
            throw new RuntimeException("实验不存在!");
        }
        if (!vo.isEmpty()) {
            //校验前端传来的时间段是否有冲突
            boolean match = TimeUtil.checkList(vo);
            if (match) {
                throw new RuntimeException("设置的实验时间存在冲突!");
            }
            //还存在的id
            List<Integer> collect = vo.stream().map(TimeListVo::getId).collect(Collectors.toList());
            LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
            w.eq(ExpLabRecord::getApplyId, applyId).eq(ExpLabRecord::getLabId, labId).notIn(ExpLabRecord::getId, collect);
            //删除不存在的id
            this.baseMapper.delete(w);
            vo.forEach(item -> {
                if (Objects.nonNull(item.getId())) {
                    ExpLabRecord expLabRecord = this.getById(item.getId());
                    int num = expLabRecordMapper.updateCheckLab(expLabRecord.getId(), apply.getLabId(), item.getStartTime(), item.getEndTime());
                    if (num > 0) {
                        //时间段已经被占用了
                        throw new RuntimeException("设置的实验时间段已经被其他实验占用,占用时间段为：" + item.getStartTime() + "-" + item.getEndTime());
                    }
                    expLabRecord.setNum(item.getNum());
                    expLabRecord.setStartTime(item.getStartTime());
                    expLabRecord.setEndTime(item.getEndTime());
                    if (apply.getStatus().equals(ApplyType.TEACHER_ACCEPT.getCode()) || apply.getStatus().equals(ApplyType.ADMIN_ACCEPT.getCode())) {
                        //目前只有审核通过才走这个接口
                        expLabRecord.setIsPass("1");
                    }
                    this.updateById(expLabRecord);
                } else {
                    int num = expLabRecordMapper.checkLab(apply.getLabId(), item.getStartTime(), item.getEndTime());
                    if (num > 0) {
                        //时间段已经被占用了
                        throw new RuntimeException("设置的实验时间段已经被其他实验占用，占用时间段为： " + item.getStartTime() + " - " + item.getEndTime());
                    }
                    ExpLabRecord expLabRecord = new ExpLabRecord();
                    expLabRecord.setLabId(Integer.valueOf(labId));
                    expLabRecord.setApplyId(Integer.valueOf(applyId));
                    expLabRecord.setStartTime(item.getStartTime());
                    expLabRecord.setEndTime(item.getEndTime());
                    expLabRecord.setNum(item.getNum());
                    if (apply.getStatus().equals(ApplyType.TEACHER_ACCEPT.getCode()) || apply.getStatus().equals(ApplyType.ADMIN_ACCEPT.getCode())) {
                        expLabRecord.setIsPass("1");
                    }
                    this.save(expLabRecord);
                }
            });
        }
    }

    @Override
    public void checkApplyLabTime(Integer applyId, Integer labId) {
        LambdaQueryWrapper<ExpLabRecord> w = new LambdaQueryWrapper<>();
        w.eq(ExpLabRecord::getApplyId, applyId);
        List<ExpLabRecord> list = this.baseMapper.selectList(w);
        if (!list.isEmpty()) {
            list.forEach(item -> {
                int num = this.baseMapper.updateCheckLab(item.getId(), labId, item.getStartTime(), item.getEndTime());
                if (num > 0) {
                    throw new RuntimeException("设置的实验时间段已经被其他实验占用，占用时间段为： " + item.getStartTime() + " - " + item.getEndTime());
                }
            });
        }
    }

    @Override
    public void updateLabPassStatus(Integer applyId, String s) {
        LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
        w.eq(ExpLabRecord::getApplyId, applyId).set(ExpLabRecord::getIsPass, s);
        this.update(w);
    }

    @Override
    public void updateByApplyId(String applyId) {
        LambdaQueryWrapper<ExpLabRecord> w = new LambdaQueryWrapper<>();
        w.eq(ExpLabRecord::getApplyId, applyId).select(ExpLabRecord::getId);
        List<ExpLabRecord> list = this.baseMapper.selectList(w);
        if (!list.isEmpty()) {
            list.forEach(item -> this.baseMapper.updateRecordAlreadyNum(item.getId()));
        }
    }

    @Override
    public void saveLabRecord(LabBorrowDto dto, User currentUser) throws Exception {
        List<Date> time = dto.getTime();
        if (time.size() != 2) {
            throw new RuntimeException("时间段不符合!");
        }
        Lab lab = labService.getById(dto.getLabId());
        if (Objects.isNull(lab)) {
            throw new RuntimeException("该实验室不存在!");
        }
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        long startTime = time.get(0).getTime();
        long endTime = time.get(1).getTime();
        Assert.isTrue(endTime > startTime, "结束时间小于开始时间");
        Assert.isTrue(endTime - startTime <= ONE_DAY_MS * 3, "申请时间不能超过三天");
        String start = df.format(time.get(0));
        String end = df.format(time.get(1));

        int i = this.baseMapper.updateCheckLab(null, lab.getId(), start, end);
        if (i > 0) {
            List<User> takeUpList = this.baseMapper.getLabTakeUpList(null, lab.getId(), start, end);
            List<ExpLabRecord> records = this.baseMapper.getUpdateCheckLab(null, lab.getId(), start, end);
            Assert.isTrue(!records.isEmpty(), "数据验证失败");
            ExpLabRecord data = records.get(0);
            String res = getAlphalDate(time.get(0), time.get(1), df.parse(data.getStartTime()), df.parse(data.getEndTime()));
            throw new LabException("设置的实验时间段已经被其他实验占用，冲突的时间段为： " + res, takeUpList);
        }
        ExpLabRecord record = new ExpLabRecord();
        record.setReason(dto.getReason());
        record.setLabId(dto.getLabId());
        record.setApplyId(-1);
        record.setNum(0);
        record.setApplyTime(df.format(new Date()));
        record.setUserId(currentUser.getId());
        record.setAlreadyNum(0);
        String teacherNo = currentUser.getTeacherNo();
        if (Objects.nonNull(teacherNo) && !teacherNo.isEmpty()) {
            User teacher = userService.findByName(teacherNo);
            log.info("当前提交实验室用户的导师信息为：{}", teacher);
            if (Objects.nonNull(teacher)) {
                record.setApproveTeacherId(teacher.getId());
            }
        }
        record.setStatus(LabBorrowStatusEnum.APPLYING.getCode());
        record.setStartTime(start);
        record.setEndTime(end);
        this.save(record);
    }

    @Override
    public IPage<LabBorrowListDto> selectUserApplyLabList(Integer page, Integer limit, User currentUser) {
        IPage<LabBorrowListDto> pageInfo = new Page<>(page, limit);
        this.baseMapper.selectUserApplyLabList(pageInfo, currentUser.getId());
        List<LabBorrowListDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return pageInfo;
    }

    @Override
    public void teacherApproveLabRecord(SubmitApproveDto dto) {
        ExpLabRecord record = this.getById(dto.getId());
        if (Objects.isNull(record)) {
            throw new RuntimeException("非法参数");
        }
        Assert.isTrue(Objects.equals(record.getStatus(), LabBorrowStatusEnum.APPLYING.getCode()), "审核状态不正确");
        if (dto.getIsApprove() == 0) {
            //不同意
            record.setStatus(LabBorrowStatusEnum.TEACHER_REJECT.getCode());
            record.setIsPass("0");
            record.setTeacherRejectReason(dto.getReason());
            this.updateById(record);
        } else if (dto.getIsApprove() == 1) {
            //同意
            int i = this.baseMapper.updateCheckLab(record.getId(), record.getLabId(), record.getStartTime(), record.getEndTime());
            if (i > 0) {
                throw new RuntimeException("设置的实验时间段已经被其他实验占用，冲突的时间段为： " + record.getStartTime() + " - " + record.getEndTime());
            }
            record.setStatus(LabBorrowStatusEnum.TEACHER_AGREE.getCode());
            record.setTeacherRejectReason("");
            this.updateById(record);
        }
    }

    @Override
    public void teacherApproveLabRecordList(SubmitApproveDto dto) {
        if (dto.getIds().isEmpty()) {
            throw new RuntimeException("非法参数");
        }
        LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
        if (dto.getIsApprove() == 0) {
            //不同意
            w.set(ExpLabRecord::getStatus, LabBorrowStatusEnum.TEACHER_REJECT.getCode())
                    .set(ExpLabRecord::getTeacherRejectReason, dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            w.set(ExpLabRecord::getStatus, LabBorrowStatusEnum.TEACHER_AGREE.getCode())
                    .set(ExpLabRecord::getTeacherRejectReason, null);
        }
        w.in(ExpLabRecord::getId, dto.getIds());
        this.update(w);
    }

    //    IExpLabRecordService
    @Override
    public void experimenterApproveLabRecord(SubmitApproveDto dto) {
        ExpLabRecord record = this.getById(dto.getId());
        if (Objects.isNull(record)) {
            throw new RuntimeException("非法参数");
        }
        Assert.isTrue(Objects.equals(record.getStatus(), LabBorrowStatusEnum.TEACHER_AGREE.getCode()), "当前审核状态不正确");
        if (dto.getIsApprove() == 0) {
            //不同意
            record.setStatus(LabBorrowStatusEnum.EXPERIMENTER_REJECT.getCode());
            record.setExperimenterRejectReason(dto.getReason());
            record.setIsPass("0");
        } else if (dto.getIsApprove() == 1) {
            //同意
            int i = this.baseMapper.updateCheckLab(record.getId(), record.getLabId(), record.getStartTime(), record.getEndTime());
            if (i > 0) {
                throw new RuntimeException("设置的实验时间段已经被其他实验占用，冲突的时间段为： " + record.getStartTime() + " - " + record.getEndTime());
            }
            record.setStatus(LabBorrowStatusEnum.EXPERIMENTER_AGREE.getCode());
            record.setIsPass("1");
            record.setExperimenterRejectReason(null);
        }
        this.updateById(record);
    }

    @Override
    @Deprecated
    public void experimenterApproveLabRecordList(SubmitApproveDto dto) {
        if (dto.getIds().isEmpty()) {
            throw new RuntimeException("非法参数");
        }
        LambdaUpdateWrapper<ExpLabRecord> w = new LambdaUpdateWrapper<>();
        if (dto.getIsApprove() == 0) {
            //不同意
            w.set(ExpLabRecord::getStatus, LabBorrowStatusEnum.EXPERIMENTER_REJECT.getCode())
                    .set(ExpLabRecord::getExperimenterRejectReason, dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            w.set(ExpLabRecord::getStatus, LabBorrowStatusEnum.EXPERIMENTER_AGREE.getCode())
                    .set(ExpLabRecord::getIsPass, "1")
                    .set(ExpLabRecord::getExperimenterRejectReason, null);
        }
        w.in(ExpLabRecord::getId, dto.getIds());
        this.update(w);
    }

    @Override
    public List<ExpLabRecord> getAvailableExpLabRecordList(Serializable applyId) {
        return this.baseMapper.getAvailableExpLabRecordList(applyId);
    }
}
