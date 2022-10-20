package gzhu.edu.cn.exam.modules.experiment.service.impl;


import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowDto;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.SubmitApproveDto;
import gzhu.edu.cn.exam.modules.borrow.enums.LabBorrowStatusEnum;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrument;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrumentRecord;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpInstrumentRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 仪器申请记录表 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpInstrumentRecordServiceImpl extends ServiceImpl<ExpInstrumentRecordMapper, ExpInstrumentRecord> implements ExpInstrumentRecordService {
    @Resource
    private ExpInstrumentService expInstrumentService;
    @Resource
    private IUserService userService;

    @Override
    public void saveInstrumentRecord(InstrumentBorrowDto dto, User currentUser) {
        List<Date> time = dto.getTime();
        if (time.size() != 2) {
            throw new RuntimeException("时间段不符合!");
        }
        ExpInstrument expInstrument = expInstrumentService.getById(dto.getId());
        if (Objects.isNull(expInstrument)) {
            throw new RuntimeException("该仪器不存在!");
        }
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String start = df.format(time.get(0));
        String end = df.format(time.get(1));
        ExpInstrumentRecord record = new ExpInstrumentRecord();
        record.setReason(dto.getReason());
        record.setInstrumentId(dto.getId());
        String teacherNo = currentUser.getTeacherNo();
        if (Objects.nonNull(teacherNo) && !teacherNo.isEmpty()) {
            User teacher = userService.findByName(teacherNo);
            log.info("当前提交实验室用户的导师信息为：{}", teacher);
            if (Objects.nonNull(teacher)) {
                record.setApproveTeacherId(teacher.getId());
            }
        }
        record.setApplyTime(df.format(new Date()));
        record.setUserId(currentUser.getId());
        record.setStatus(LabBorrowStatusEnum.APPLYING.getCode());
        record.setStartTime(start);
        record.setEndTime(end);
        this.save(record);
    }

    @Override
    public IPage<InstrumentBorrowListDto> selectUserApplyInstrumentList(Integer page, Integer limit, User currentUser) {
        IPage<InstrumentBorrowListDto> res = this.baseMapper.selectUserApplyInstrumentList(new Page<>(page, limit), currentUser.getId());
        List<InstrumentBorrowListDto> records = res.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return res;
    }

    @Override
    public void teacherApproveInstrumentRecord(SubmitApproveDto dto) {
        ExpInstrumentRecord record = this.getById(dto.getId());
        if (Objects.isNull(record)) {
            throw new RuntimeException("非法参数");
        }
        Assert.isTrue(Objects.equals(record.getStatus(), LabBorrowStatusEnum.APPLYING.getCode()), "审核状态不正确");
        if (dto.getIsApprove() == 0) {
            //不同意
            record.setIsPass("0");
            record.setStatus(LabBorrowStatusEnum.TEACHER_REJECT.getCode());
            record.setTeacherRejectReason(dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            int i = this.baseMapper.checkInstrument(record.getId(), record.getInstrumentId(), record.getStartTime(), record.getEndTime());
            if (i > 0) {
                throw new RuntimeException("设置的仪器借用时间段已经被占用，占用时间段为： " + record.getStartTime() + " - " + record.getEndTime());
            }
            record.setStatus(LabBorrowStatusEnum.TEACHER_AGREE.getCode());
            record.setTeacherRejectReason("");
        }
        this.updateById(record);
    }

    @Override
    public void teacherApproveInstrumentRecordList(SubmitApproveDto dto) {
        if (dto.getIds().isEmpty()) {
            throw new RuntimeException("非法参数");
        }
        LambdaUpdateWrapper<ExpInstrumentRecord> w = new LambdaUpdateWrapper<>();
        if (dto.getIsApprove() == 0) {
            //不同意
            w.set(ExpInstrumentRecord::getStatus, LabBorrowStatusEnum.TEACHER_REJECT.getCode())
                    .set(ExpInstrumentRecord::getTeacherRejectReason, dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            w.set(ExpInstrumentRecord::getStatus, LabBorrowStatusEnum.TEACHER_AGREE.getCode())
                    .set(ExpInstrumentRecord::getTeacherRejectReason, null);
        }
        w.in(ExpInstrumentRecord::getId, dto.getIds());
        this.update(w);
    }

    @Override
    public void experimenterApproveInstrumentRecord(SubmitApproveDto dto) {
        ExpInstrumentRecord record = this.getById(dto.getId());
        if (Objects.isNull(record)) {
            throw new RuntimeException("非法参数");
        }
        Assert.isTrue(Objects.equals(record.getStatus(), LabBorrowStatusEnum.TEACHER_AGREE.getCode()), "审核状态不存在");
        if (dto.getIsApprove() == 0) {
            //不同意
            record.setIsPass("0");
            record.setStatus(LabBorrowStatusEnum.EXPERIMENTER_REJECT.getCode());
            record.setExperimenterRejectReason(dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            int i = this.baseMapper.checkInstrument(record.getId(), record.getInstrumentId(), record.getStartTime(), record.getEndTime());
            if (i > 0) {
                throw new RuntimeException("设置的仪器借用时间段已经占用，占用时间段为： " + record.getStartTime() + " - " + record.getEndTime());
            }
            record.setStatus(LabBorrowStatusEnum.EXPERIMENTER_AGREE.getCode());
            record.setIsPass("1");
            record.setExperimenterRejectReason("");
        }
        this.updateById(record);
    }

    @Override
    @Deprecated
    public void experimenterApproveInstrumentRecordList(SubmitApproveDto dto) {
        if (dto.getIds().isEmpty()) {
            throw new RuntimeException("非法参数");
        }
        LambdaUpdateWrapper<ExpInstrumentRecord> w = new LambdaUpdateWrapper<>();
        if (dto.getIsApprove() == 0) {
            //不同意
            w.set(ExpInstrumentRecord::getStatus, LabBorrowStatusEnum.EXPERIMENTER_REJECT.getCode())
                    .set(ExpInstrumentRecord::getExperimenterRejectReason, dto.getReason());
        } else if (dto.getIsApprove() == 1) {
            //同意
            w.set(ExpInstrumentRecord::getStatus, LabBorrowStatusEnum.EXPERIMENTER_AGREE.getCode())
                    .set(ExpInstrumentRecord::getExperimenterRejectReason, null);
        }
        w.in(ExpInstrumentRecord::getId, dto.getIds());
        this.update(w);
    }

    @Override
    public void updateReturnTime(String id, String returnTime) {
        if (Objects.nonNull(id) && !id.isEmpty()) {
//            String format = null;
//            if (Objects.nonNull(returnTime) && !returnTime.isEmpty()) {
//                try {
//                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
////                    Date date = new Date()
//                    format = df.format(returnTime);
//                } catch (Exception e) {
//                    throw new RuntimeException("时间格式不正确");
//                }
//            }s
            LambdaUpdateWrapper<ExpInstrumentRecord> w = new LambdaUpdateWrapper<>();
            w.set(ExpInstrumentRecord::getReturnTime, returnTime).eq(ExpInstrumentRecord::getId, id);
            this.update(w);
        }
    }
}
