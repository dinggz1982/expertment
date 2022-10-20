package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowDto;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.SubmitApproveDto;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrumentRecord;
import gzhu.edu.cn.exam.modules.system.entity.User;

/**
 * <p>
 * 仪器申请记录表 服务类
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
public interface ExpInstrumentRecordService extends IService<ExpInstrumentRecord> {

    /**
     * 新建仪器借用
     *
     * @param dto         前端传值
     * @param currentUser 当前登录用户
     */
    void saveInstrumentRecord(InstrumentBorrowDto dto, User currentUser);

    /**
     * 获取当前用户申请的仪器列表
     *
     * @param page        page
     * @param limit       limit
     * @param currentUser 登录用户
     * @return 返回分页数据
     */
    IPage<InstrumentBorrowListDto> selectUserApplyInstrumentList(Integer page, Integer limit, User currentUser);

    /**
     * 导师审核仪器
     *
     * @param dto 前端传值
     */
    void teacherApproveInstrumentRecord(SubmitApproveDto dto);


    /**
     * 导师审核仪器(多选时)
     *
     * @param dto 前端传值
     */
    @Deprecated
    void teacherApproveInstrumentRecordList(SubmitApproveDto dto);

    /**
     * 实验员审核仪器
     *
     * @param dto 前端传值
     */
    void experimenterApproveInstrumentRecord(SubmitApproveDto dto);

    /**
     * 实验员审核仪器(多选时)
     *
     * @param dto 前端传值
     */
    @Deprecated
    void experimenterApproveInstrumentRecordList(SubmitApproveDto dto);

    /**
     * 修改仪器借用的归还时间
     *
     * @param id         id
     * @param returnTime 归还时间
     */
    void updateReturnTime(String id, String returnTime);

}
