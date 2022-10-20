package gzhu.edu.cn.exam.modules.experiment.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowListDto;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpLabRecord;
import gzhu.edu.cn.exam.modules.system.entity.User;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 实验室申请记录表 Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2021-11-20
 */
public interface ExpLabRecordMapper extends BaseMapper<ExpLabRecord> {

    /**
     * 查看实验室某个时间段是否已经占用(新增用)
     *
     * @param labId lab id
     * @param start 开始时间
     * @param end   结果时间
     * @return 返回数据库条数 0没有占用 1占用
     */
    int checkLab(@Param("labId") Integer labId, @Param("start") String start, @Param("end") String end);

    /**
     * 查看实验室某个时间段是否已经占用(更新用)
     *
     * @param id    lab record id
     * @param labId lab id
     * @param start 开始时间
     * @param end   结果时间
     * @return 返回数据库条数 0没有占用 1占用
     */
    int updateCheckLab(@Param("id") Integer id, @Param("labId") Integer labId, @Param("start") String start, @Param("end") String end);

    /**
     * 获取实验室已经占用的记录
     *
     * @param id    lab record id
     * @param labId lab id
     * @param start 开始时间
     * @param end   结果时间
     * @return 返回数据库中实验室占用的记录
     */
    List<ExpLabRecord> getUpdateCheckLab(@Param("id") Integer id, @Param("labId") Integer labId, @Param("start") String start, @Param("end") String end);

    /**
     * 查看实验室某个时间段占用人信息列表
     *
     * @param id    lab record id
     * @param labId lab id
     * @param start 开始时间
     * @param end   结果时间
     * @return 返回数据库条数 0没有占用 1占用
     */
    List<User> getLabTakeUpList(@Param("id") Integer id, @Param("labId") Integer labId, @Param("start") String start, @Param("end") String end);


    /**
     * 更新已报名人数
     *
     * @param labRecordId lab record id
     */
    void updateRecordAlreadyNum(@Param("labRecordId") Integer labRecordId);


    /**
     * 获取用户的实验室申请记录
     *
     * @param pageInfo 分页信息
     * @param userId   user id
     * @return 返回分页数据
     */
    IPage<LabBorrowListDto> selectUserApplyLabList(@Param("pageInfo") IPage<LabBorrowListDto> pageInfo, @Param("userId") Integer userId);

    /**
     * 按照 status 获取借用分页数据
     *
     * @param pageInfo  分页信息
     * @param teacherId teacher user id
     * @param status    状态码
     * @return 返回分页数据
     */
    IPage<LabBorrowListDto> getApproveList(@Param("pageInfo") IPage<LabBorrowListDto> pageInfo, @Param("teacherId") Integer teacherId, @Param("status") Integer status);

    /**
     * 获取可用的实验室记录
     *
     * @param applyId apply id
     * @return 返回列表
     */
    List<ExpLabRecord> getAvailableExpLabRecordList(@Param("applyId") Serializable applyId);


}
