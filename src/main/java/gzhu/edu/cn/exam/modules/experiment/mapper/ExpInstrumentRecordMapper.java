package gzhu.edu.cn.exam.modules.experiment.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowListDto;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrumentRecord;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;

/**
 * <p>
 * 仪器申请记录表 Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
public interface ExpInstrumentRecordMapper extends BaseMapper<ExpInstrumentRecord> {

    /**
     * 查询当前登录用户的仪器申请列表
     *
     * @param pageInfo 分页信息
     * @param userId   user id
     * @return 返回分页信息
     */
    IPage<InstrumentBorrowListDto> selectUserApplyInstrumentList(@Param("pageInfo") IPage<InstrumentBorrowListDto> pageInfo, @Param("userId") Integer userId);

    /**
     * 根据 status 获取列表
     *
     * @param pageInfo  分页信息
     * @param teacherId teacher user id
     * @param status    status
     * @return 返回分页数据
     */
    IPage<InstrumentBorrowListDto> getInstrumentApproveList(@Param("pageInfo") IPage<InstrumentBorrowListDto> pageInfo, @Param("teacherId") Integer teacherId, @Param("status") int status);

    /**
     * 实验员查看仪器借用情况
     *
     * @param pageInfo 分页信息
     * @param status   status
     * @return 返回分页数据
     */
    IPage<InstrumentBorrowListDto> getInstrumentList(@Param("pageInfo") IPage<InstrumentBorrowListDto> pageInfo, @Param("status") Integer status);

    /**
     * 检测仪器在某个时间段是否被借出
     *
     * @param id           主键id
     * @param instrumentId 仪器id
     * @param start        开始时间
     * @param end          结束时间
     * @return 返回数据库条数
     */
    int checkInstrument(@Param("id") Serializable id, @Param("instrumentId") Serializable instrumentId, @Param("start") String start, @Param("end") String end);
}
