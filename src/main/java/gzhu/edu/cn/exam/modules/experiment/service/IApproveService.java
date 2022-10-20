package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.experiment.entity.Approve;

/**
 * @program: mix-tech
 * @description:实验审批
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface IApproveService extends IService<Approve> {

    /**
     * 保存审批信息
     * @param approve
     */
    public void saveApprove(Approve approve);

}