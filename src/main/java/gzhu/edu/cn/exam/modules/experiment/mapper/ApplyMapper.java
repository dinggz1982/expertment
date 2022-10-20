package gzhu.edu.cn.exam.modules.experiment.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.datamanage.dto.ItemDataExportDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.vo.ApplySignUpCollectDto;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.io.Serializable;
import java.util.List;

/**
 * @program: mix-tech
 * @description:实验申请
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface ApplyMapper extends BaseMapper<Apply> {

    @Update("update exp_apply set status = ${status} where id=${id}")
    public void updateApply(@Param("id") int id, @Param("status") int status);

    /**
     * 查询分项数据页面 导出数据
     *
     * @param applyId   apply id
     * @param expTypeId exp type id
     * @param status    status
     * @return 返回查询数据
     */
    List<ItemDataExportDto> getExportToExcelData(@Param("applyId") String applyId, @Param("expTypeId") String expTypeId, @Param("status") int status);

    /**
     * 根据附加条件，获取管理员审批列表
     *
     * @param pageInfo 分页信息
     * @param type     实验状态
     * @param search   搜索内容
     * @return 返回分页内容
     */
    IPage<Apply> listAdminApproveListBySearchContent(@Param("pageInfo") IPage<Apply> pageInfo, @Param("type") Integer type, @Param("search") String search);

    /**
     * 根据user id获取用户需要审核的实验id列表
     *
     * @param userId user id
     * @return 返回id列表
     */
    List<Integer> getUserApproveApplyIdList(@Param("userId") Serializable userId);

    /**
     * 获取用户的实验报名汇总情况
     *
     * @param page   分页数据
     * @param userId user id
     * @return 返回分页数据
     */
    IPage<ApplySignUpCollectDto> getUserApplyCollectPageData(IPage<ApplySignUpCollectDto> page, @Param("userId") Serializable userId);

    /**
     * 前端获取最新实验列表
     *
     * @param pageData 分页信息数据
     * @param status   status字段
     * @return 返回分页数据
     */
    IPage<Apply> getNewExperimentApply(@Param("pageData") IPage<Apply> pageData, @Param("status") Serializable status);


//    /**
//     * 获取所有学期信息
//     *
//     * @param userId user id
//     * @return 返回学期信息
//     */
//    List<String> getTeamInfo(@Param("userId") Integer userId);
//

}
