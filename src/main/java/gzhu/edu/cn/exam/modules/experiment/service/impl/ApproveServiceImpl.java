package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.Approve;
import gzhu.edu.cn.exam.modules.experiment.mapper.ApproveMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IApproveService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-26 22:59
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ApproveServiceImpl extends ServiceImpl<ApproveMapper, Approve> implements IApproveService {

    @Autowired
    private IApplyService applyService;


    @Override
    @Transactional
    public void saveApprove(Approve approve) {
        if (approve.isType()) {
            //管理员审批
            if (approve.isApprove()) {
                //管理员审批通过
                this.applyService.updateApply(approve.getApplyId(), 3);
            } else {
                this.applyService.updateApply(approve.getApplyId(), 5);
            }
        } else {
            //教师审批
            if (approve.isApprove()) {
                //管理员审批通过
                this.applyService.updateApply(approve.getApplyId(), 2);
            } else {
                this.applyService.updateApply(approve.getApplyId(), 4);
            }
        }
        this.save(approve);
    }
}
