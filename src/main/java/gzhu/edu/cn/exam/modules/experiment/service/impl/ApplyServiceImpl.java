package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.datamanage.dto.ItemDataExportDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyConfirmType;
import gzhu.edu.cn.exam.modules.experiment.enums.ApplyType;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.mapper.ApplyMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.experiment.vo.LockExperimentVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * @program: mix-tech
 * @description:实验申请（主试角色）
 * @author: 丁国柱
 * @create: 2021-05-15 22:48
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ApplyServiceImpl extends ServiceImpl<ApplyMapper, Apply> implements IApplyService {

    @Resource
    private ApplyMapper applyMapper;

    @Resource
    private IExpLabRecordService expLabRecordService;

    @Resource
    private ISignupService signupService;

    @Override
    public PageData<Apply> getPage(int page, int limit, Apply apply) {
        PageData<Apply> applyPageData = new PageData<Apply>();
        Page<Apply> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<Apply> w = new LambdaQueryWrapper<>();
        w.eq(Apply::getCanSignup, 1);
        w.orderByDesc(Apply::getApplyTime);
        if (apply.getName() != null && apply.getName().length() > 0) {
            w.like(Apply::getName, apply.getName());
        }
        if (apply.getIsLock() != null) {
            w.like(Apply::getIsLock, apply.getIsLock());
        }
        if (apply.getApplyUserId() != null && apply.getApplyUserId() > 0) {
            w.eq(Apply::getApplyUserId, apply.getApplyUserId());
        }
        if (apply.getTeacherConfirmUserId() != null && apply.getTeacherConfirmUserId() > 0) {
            w.eq(Apply::getTeacherConfirmUserId, apply.getTeacherConfirmUserId());
        }
        if (apply.getStatus() != null && apply.getStatus() > 0) {
            w.eq(Apply::getStatus, apply.getStatus());
        }
        IPage<Apply> ipage = this.page(pageInfo, w);
        //总记录数
        applyPageData.setCount(ipage.getTotal());
        //当前分页的记录
        applyPageData.setData(ipage.getRecords());
        //正确的分页响应code为0
        applyPageData.setCode(0);
        applyPageData.setMsg("实验申请分页");
        return applyPageData;
    }

    @Override
    public void updateApply(int id, int status) {
        this.applyMapper.updateApply(id, status);
    }

    @Override
    public void teacherApprove(String applyId, Integer approve, String reason) {
        Apply apply = this.getById(applyId);
        if (Objects.isNull(apply)) {
            throw new RuntimeException("该实验不存在!");
        } else {
            //检验该实验的时间是否合理
            if (approve.equals(1)) {
                //通过审核,校验时间
                if (apply.getIsCheckTime() == 1) {
                    expLabRecordService.checkApplyLabTime(apply.getId(), apply.getLabId());
                }
                apply.setStatus(ApplyType.TEACHER_ACCEPT.getCode());
                //更新状态
                expLabRecordService.updateLabPassStatus(apply.getId(), "1");
            } else {
                apply.setStatus(ApplyType.TEACHER_RECALL.getCode());
                apply.setTeacherReason(reason);
                //取消占用状态
                expLabRecordService.updateLabPassStatus(apply.getId(), "0");
            }
            this.updateById(apply);
        }
    }

    @Override
    public void adminApprove(String applyId, Integer approve, String reason) {
        Apply apply = this.getById(applyId);
        if (Objects.isNull(apply)) {
            throw new RuntimeException("该实验不存在");
        } else {
            if (!apply.getStatus().equals(ApplyType.TEACHER_ACCEPT.getCode())) {
                throw new RuntimeException("实验状态不正确");
            }
            if (approve.equals(1)) {
                //通过审核,校验实验时间
                if (apply.getIsCheckTime() == 1) {
                    expLabRecordService.checkApplyLabTime(apply.getId(), apply.getLabId());
                }
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                //设置通过审核 时间
                apply.setConfirmTime(sdf.format(new Date()));
                apply.setStatus(ApplyType.ADMIN_ACCEPT.getCode());
                expLabRecordService.updateLabPassStatus(apply.getId(), "1");
            } else {
                apply.setStatus(ApplyType.ADMIN_RECALL.getCode());
                apply.setAdminReason(reason);
                //取消占用状态
                expLabRecordService.updateLabPassStatus(apply.getId(), "0");
            }
            this.updateById(apply);
        }
    }

    @Override
    public void updateStatisticsById(String applyId) {
        Apply apply = this.getById(applyId);
        //更新报名数
        LambdaQueryWrapper<Signup> w = new LambdaQueryWrapper<>();
        w.eq(Signup::getApplyId, applyId).notIn(Signup::getStatus, SignUpType.CANCEL.getCode(), SignUpType.REJECT.getCode(), SignUpType.NO_SHOW.getCode(), SignUpType.BELOW_GRADE.getCode());
        int sum = signupService.getBaseMapper().selectCount(w);
        apply.setApplyNumber(sum);
        //更新完成数
        LambdaQueryWrapper<Signup> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Signup::getApplyId, applyId)
                .eq(Signup::getStatus, SignUpType.ADMIN_PASS.getCode())
                .eq(Signup::getConfirmType, ApplyConfirmType.UP_TO_STANDARD.getCode());
        Integer sum2 = signupService.getBaseMapper().selectCount(wrapper);
        apply.setFinishNumber(sum2);
        if (sum < apply.getNumber()) {
            apply.setCanSignup(1);
        } else {
            apply.setCanSignup(0);
        }
        this.updateById(apply);
    }

    @Override
    public List<ItemDataExportDto> getExportToExcelData(String applyId, String expTypeId) {
        return this.baseMapper.getExportToExcelData(applyId, expTypeId, SignUpType.ADMIN_PASS.getCode());
    }

    @Override
    public void unlockExperiment(String id) {
        LambdaUpdateWrapper<Apply> w = new LambdaUpdateWrapper<>();
        w.eq(Apply::getId, id).set(Apply::getIsLock, "0").set(Apply::getLockReason, "");
        this.update(w);
    }

    @Override
    public void lockExperiment(LockExperimentVo vo) {
        Apply apply = this.getById(vo.getId());
        if (Objects.isNull(apply)) {
            throw new RuntimeException("该实验不存在");
        }
        if (apply.getStatus() != ApplyType.ADMIN_ACCEPT.getCode()) {
            throw new RuntimeException("实验状态不正确");
        }
        if ("1".equals(apply.getIsLock())) {
            //1代表实验已锁定
            throw new RuntimeException("该实验已处于锁定状态");
        }
        apply.setIsLock("1");
        apply.setLockReason(vo.getReason());
        this.updateById(apply);
    }

    @Override
    public IPage<Apply> listAdminApproveListBySearchContent(IPage<Apply> pageInfo, Integer type, String search) {
        return this.baseMapper.listAdminApproveListBySearchContent(pageInfo, type, search);
    }

    @Override
    public List<Integer> getUserApproveApplyIdList(Serializable userId) {
        return this.baseMapper.getUserApproveApplyIdList(userId);
    }

    @Override
    public IPage<Apply> getNewExperimentApply(IPage<Apply> pageData) {
        return this.baseMapper.getNewExperimentApply(pageData, ApplyType.ADMIN_ACCEPT.getCode());
    }


    //    @Override
//    public List<String> getTeamInfo(Integer userId) {
//        return this.baseMapper.getTeamInfo(userId);
//    }
//
//    @Override
//    public PageData<Apply> getPageForSignUp(int page, int limit, Apply apply) {
//        PageData<Apply> applyPageData = new PageData<Apply>();
//        Page pageInfo = new Page(page,limit);
//        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
//        if(apply.getName()!=null&&apply.getName().length()>0){
//            queryWrapper.like("name",apply.getName());
//        }
//        queryWrapper.eq("status",3);
//        queryWrapper.eq("finished",0);
//        IPage ipage = this.page(pageInfo,queryWrapper);
//        applyPageData.setCount(ipage.getTotal());//总记录数
//        applyPageData.setData(ipage.getRecords());//当前分页的记录
//        applyPageData.setCode(0);//正确的分页响应code为0
//        applyPageData.setMsg("实验报名分页");
//        return applyPageData;
//    }
}
