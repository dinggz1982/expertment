package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.datamanage.dto.ItemDataExportDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.vo.LockExperimentVo;

import java.io.Serializable;
import java.util.List;

/**
 * @program: mix-tech
 * @description:实验申请
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface IApplyService extends IService<Apply> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param apply:检索的学校信息
     * @return
     */
    PageData<Apply> getPage(int page, int limit, Apply apply);

    /**
     * 更新实验审批状态
     *
     * @param id     实验id
     * @param status 状态
     */
    void updateApply(int id, int status);

    /**
     * 实验审核(导师用)
     *
     * @param applyId apply id 需要审核的实验
     * @param approve 审核意见
     * @param reason  理由
     */
    void teacherApprove(String applyId, Integer approve, String reason);

    /**
     * 实验审核(管理员用)
     *
     * @param applyId apply id 需要审核的实验
     * @param approve 审核意见
     * @param reason  理由
     */
    void adminApprove(String applyId, Integer approve, String reason);

    /**
     * 更新申请数和完成数
     *
     * @param applyId apply id
     */
    void updateStatisticsById(String applyId);

    /**
     * 查询导出到excel的数据
     *
     * @param applyId   apply id
     * @param expTypeId exp type id
     * @return 返回查询数据
     */
    List<ItemDataExportDto> getExportToExcelData(String applyId, String expTypeId);

    /**
     * 锁定实验
     *
     * @param vo 前端传值
     */
    void lockExperiment(LockExperimentVo vo);

    /**
     * 解锁实验
     *
     * @param id apply id
     */
    void unlockExperiment(String id);

    /**
     * 根据附加条件，获取管理员审批列表
     *
     * @param pageInfo 分页信息
     * @param type     实验状态
     * @param search   搜索内容
     * @return 返回分页内容
     */
    IPage<Apply> listAdminApproveListBySearchContent(IPage<Apply> pageInfo, Integer type, String search);


    /**
     * 根据user id获取用户需要审核的实验id列表
     *
     * @param userId user id
     * @return 返回id列表
     */
    List<Integer> getUserApproveApplyIdList(Serializable userId);


    /**
     * 前端获取最新实验列表
     *
     * @param pageData 分页信息数据
     * @return 返回分页数据
     */
    IPage<Apply> getNewExperimentApply(IPage<Apply> pageData);


//    /**
//     * 获取数据库中所有学期信息
//     *
//     * @param userId user id
//     * @return 返回数据
//     */
//    List<String> getTeamInfo(Integer userId);


}
