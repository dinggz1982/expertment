package gzhu.edu.cn.exam.modules.experiment.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 84271
 */
public interface SignupMapper extends BaseMapper<Signup> {

    /**
     * 初始化数据 防止包含脏数据
     *
     * @param signUpId sign up id
     */
    void initRealHourAndConfirmTypeById(@Param("signUpId") String signUpId);

    /**
     * 不同实验类型的实验已获得的实验时总和
     *
     * @param userId user id
     * @param status status
     * @return 返回统计结果
     */
    List<RealHourGroupByTypeVo> getHourGroupByType(@Param("userId") Integer userId, @Param("status") int status);

    /**
     * 获取用户可以报名的列表
     *
     * @param pageInfo 分页信息
     * @param id       user id
     * @param name     实验名称
     * @return 返回分页数据
     */
    IPage<Signup> selectUserCanSignUp(@Param("pageInfo") IPage<Signup> pageInfo, @Param("id") Integer id, @Param("name") String name, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("type") String type);


    /**
     * 根据查询条件获取分项数据信息
     *
     * @param pageInfo  分页信息
     * @param applyId   apply id
     * @param expTypeId exp type  id
     * @param search    search 内容
     * @param map       参数
     * @return 返回分页数据
     */
    IPage<Signup> selectItemDataByOtherInfo(@Param("pageInfo") IPage<Signup> pageInfo, @Param("applyId") String applyId, @Param("expTypeId") String expTypeId, @Param("search") String search, @Param("map") Map<String, String> map);

    /**
     * 获取被试报名实验列表
     *
     * @param pageInfo     分页信息
     * @param applyId      apply id
     * @param id           current user id
     * @param type         type
     * @param prop         prop
     * @param order        order
     * @param filterStatus status
     * @return 返回分页信息
     */
    IPage<Signup> getTeacherApproveStudentSignUpPage(@Param("pageInfo") IPage<Signup> pageInfo, @Param("applyId") Integer applyId, @Param("id") Integer id, @Param("type") Integer type, @Param("prop") String prop, @Param("order") String order, @Param("filterStatus") String filterStatus);


    /**
     * 获取管理员审核实验时数据分页
     *
     * @param iPage   分页信息
     * @param applyId 实验id
     * @param status  sign up status
     * @return 返回分页列表
     */
    IPage<Signup> getAdminApplyResultSignUpPage(@Param("iPage") IPage<Signup> iPage, @Param("applyId") Integer applyId, @Param("status") Integer status);

}
