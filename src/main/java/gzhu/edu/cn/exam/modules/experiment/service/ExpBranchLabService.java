package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpBranchLab;

import java.util.Map;

/**
 * <p>
 * 实验分室 服务类
 * </p>
 *
 * @author loading
 * @since 2022-04-05
 */
public interface ExpBranchLabService extends IService<ExpBranchLab> {

    /**
     * 添加或修改实验分室
     *
     * @param expBranchLab 前端传值
     */
    void saveOrUpdateExpBranch(ExpBranchLab expBranchLab);

    /**
     * 获取分页信息
     *
     * @param params 前端参数
     * @return 返回分页数据
     */
    IPage<ExpBranchLab> getTableList(Map<String, String> params);
}
