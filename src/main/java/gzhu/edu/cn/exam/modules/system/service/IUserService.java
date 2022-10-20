package gzhu.edu.cn.exam.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.vo.UpdateUserRoleVo;
import gzhu.edu.cn.exam.modules.system.vo.UserExportToExcelVo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @program: exam
 * @description:用户服务接口
 * @author: 丁国柱
 * @create: 2021-04-04 22:56
 */
public interface IUserService extends IService<User> {

    /**
     * 保存或更新用户
     *
     * @param user
     */
    int saveOrUpdateUser(User user);

    /**
     * 批量保存用户
     *
     * @param users
     * @return
     */
    int saveBatchUser(List<User> users);

    /**
     * getPage
     *
     * @param page  page
     * @param limit limit
     * @return 返回
     */
    @Deprecated
    PageData<User> getPage(int page, int limit);

    /**
     * 用户分页数据
     *
     * @param page   当前页面数
     * @param limit  每一页显示多少条数据
     * @param user   信息
     * @param params 请求参数
     * @return 返回分页数据
     */
    PageData<User> getPage(int page, int limit, User user, Map<String, String> params);


    /**
     * 重置用户密码
     *
     * @param user     user
     * @param password 新密码
     */
    void resetPassword(User user, String password);


    /**
     * 根据用户名获取用户信息
     *
     * @param username user name
     * @return 返回用户信息
     */
    User findByName(String username);

    /**
     * 根据真实姓名查找
     * @param realName
     * @return
     */
    User findByRealName(String realName);
    /**
     * 获取教师所有的主试学生名字
     *
     * @param username username
     * @return 返回用户列表
     */
    List<User> getStudentList(String username);

    /**
     * 注册用户
     *
     * @param user 用户信息
     * @return 返回执行信息
     */
    R registry(User user);

    /**
     * 根据id删除用户
     *
     * @param userId user id
     */
    void delUserById(Serializable userId);

    /**
     * 导出用户到excel文件
     *
     * @return 返回导出列表
     */
    List<UserExportToExcelVo> exportUserToExcel();


    /**
     * 更新老师前端显示的其他信息
     *
     * @param user 前端传值
     */
    void updateFrontTeacherInfo(User user);

    /**
     * 批量更新用户角色
     *
     * @param vo 前端传值
     */
    void updateUserRole(UpdateUserRoleVo vo);
}
