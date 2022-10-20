package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowDto;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.SubmitApproveDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpLabRecord;
import gzhu.edu.cn.exam.modules.experiment.vo.TimeListVo;
import gzhu.edu.cn.exam.modules.system.entity.User;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 实验室申请记录表 服务类
 * </p>
 *
 * @author loading
 * @since 2021-11-20
 */
public interface IExpLabRecordService extends IService<ExpLabRecord> {

    /**
     * 根据 apply id 删除
     *
     * @param applyId apply id
     */
    void delByApplyId(Integer applyId);

    /**
     * 保存实验室时间申请记录
     *
     * @param apply apply
     */
    void saveRecord(Apply apply);

    /**
     * 根据 apply id 获取 record list
     *
     * @param id apply id
     * @return 返回list
     */
    List<ExpLabRecord> getByApplyId(String id);

    /**
     * 撤回某个实验，取消占用实验室
     *
     * @param id apply id
     */
    void reCallApply(String id);


    /**
     * 查看实验室某个时间段是否已经占用
     *
     * @param id    lab id
     * @param start 开始时间
     * @param end   结果时间
     * @return 返回数据库条数 0没有占用 1占用
     */
    int checkLab(Integer id, String start, String end);

    /**
     * 获取已经报名人数
     *
     * @param item item
     * @return 返回已经报名人数
     */
    int getAlreadyNum(ExpLabRecord item);

    /**
     * 更新已报名人数
     *
     * @param labRecordId lab recored id
     */
    void updateRecordAlreadyNum(Integer labRecordId);

    /**
     * 更新实验时间段记录数据
     *
     * @param applyId apply id
     * @param labId   lab id
     * @param vo      前端传值
     */
    void updateLabRecordList(String applyId, String labId, List<TimeListVo> vo);

    /**
     * 校验某个实验的时间段是否被占用
     *
     * @param applyId apply id
     * @param labId   lab id
     */
    void checkApplyLabTime(Integer applyId, Integer labId);

    /**
     * 更新实验室记录状态
     *
     * @param applyId apply id
     * @param s       状态标志
     */
    void updateLabPassStatus(Integer applyId, String s);

    /**
     * 根据 apply id 更新 lab 报名人数记录
     *
     * @param applyId apply id
     */
    void updateByApplyId(String applyId);


    /**
     * 保存实验室申请记录
     *
     * @param dto         前端传值
     * @param currentUser 当前登录用户
     */
    void saveLabRecord(LabBorrowDto dto, User currentUser) throws Exception;

    /**
     * 获取用户的实验室申请记录
     *
     * @param page        分页
     * @param limit       页大小
     * @param currentUser 用户
     * @return 返回分页数据
     */
    IPage<LabBorrowListDto> selectUserApplyLabList(Integer page, Integer limit, User currentUser);


    /**
     * 导师审核实验室申请
     *
     * @param dto 前端传值
     */
    void teacherApproveLabRecord(SubmitApproveDto dto);

    /**
     * 导师审核实验室申请(多选时)
     *
     * @param dto 前端传值
     */
    @Deprecated
    void teacherApproveLabRecordList(SubmitApproveDto dto);

    /**
     * 实验员审核实验室申请
     *
     * @param dto 前端传值
     */
    void experimenterApproveLabRecord(SubmitApproveDto dto);

    /**
     * 实验员审核实验室申请(多选时)
     *
     * @param dto 前端传值
     */
    @Deprecated
    void experimenterApproveLabRecordList(SubmitApproveDto dto);

    /**
     * 获取可用的实验室记录
     *
     * @param applyId apply id
     * @return 返回列表
     */
    List<ExpLabRecord> getAvailableExpLabRecordList(Serializable applyId);

}
