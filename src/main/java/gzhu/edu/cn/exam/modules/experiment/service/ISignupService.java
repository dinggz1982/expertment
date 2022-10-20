package gzhu.edu.cn.exam.modules.experiment.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.vo.AdminApplyApproveVo;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import gzhu.edu.cn.exam.modules.system.entity.User;

import java.util.List;
import java.util.Map;

/**
 * @author 84271
 */
public interface ISignupService extends IService<Signup> {
    /**
     * 被试报名
     *
     * @param signup
     */
    void saveSignup(Signup signup);

    /**
     * 返回分页数据
     *
     * @param page        page
     * @param limit       limit
     * @param applyId     apply id
     * @param currentUser user
     * @return 返回分页数据
     */
    @Deprecated
    PageData<Signup> getPage(int page, int limit, Integer applyId, User currentUser);

    /**
     * 返回分页数据
     *
     * @param page         page
     * @param limit        limit
     * @param applyId      apply id
     * @param user         user
     * @param prop         prop
     * @param order        order
     * @param filterStatus statusList
     * @return 返回分页数据
     */
    IPage<Signup> getPage(int page, int limit, Integer applyId, User user, String prop, String order, String filterStatus);


    /**
     * 返回自己的实验数据分页数据
     *
     * @param page   page
     * @param limit  limit
     * @param userId user id
     * @param status 实验申请状态
     * @return 返回自己的实验数据分页数据
     */
    PageData<Signup> getMyExperimentPage(int page, int limit, Integer userId, String status);

    /**
     * 学生报名实验 具体实现
     *
     * @param currentUser 当前用户
     * @param applyId     实验id
     * @param labRecordId 实验时间记录id
     * @return 返回执行信息
     */
    R signUp(User currentUser, Integer applyId, Integer labRecordId);

    /**
     * 主试确认实验
     *
     * @param signUpId sign up id
     * @param confirm  confirm type
     * @param hour     实际获得学时
     */
    void confirmSignUp(String signUpId, String confirm, String hour);

    /**
     * 初始化数据 防止包含脏数据
     *
     * @param signUpId sign up id
     */
    void initRealHourAndConfirmTypeById(String signUpId);

    /**
     * 不同实验类型的实验已获得的实验时总和
     *
     * @param userId user id
     * @return 返回统计结果
     */
    @Deprecated
    List<RealHourGroupByTypeVo> getHourGroupByType(Integer userId);

    /**
     * 管理员审核实验结果
     *
     * @param vo 前端传值
     */
    void approveSignUp(AdminApplyApproveVo vo);

    /**
     * 获取用户可以报名的列表
     *
     * @param pageInfo 分页信息
     * @param id       user id
     * @param name     实验名称
     * @return 返回分页数据
     */
    IPage<Signup> selectUserCanSignUp(IPage<Signup> pageInfo, Integer id, String name, String startTime, String endTime, String type);

    /**
     * 根据查询条件获取分项数据信息
     *
     * @param pageInfo  分页信息
     * @param applyId   apply id
     * @param expTypeId exp type  id
     * @param search    search 内容
     * @param params    参数
     * @return 返回分页数据
     */
    IPage<Signup> selectItemDataByOtherInfo(IPage<Signup> pageInfo, String applyId, String expTypeId, String search, Map<String, String> params);

    /**
     * 获取管理员审核实验时数据分页
     *
     * @param iPage   分页信息
     * @param applyId 实验id
     * @param status  查询状态
     * @return 返回分页列表
     */
    IPage<Signup> getAdminApplyResultSignUpPage(IPage<Signup> iPage, Integer applyId, Integer status);
}
