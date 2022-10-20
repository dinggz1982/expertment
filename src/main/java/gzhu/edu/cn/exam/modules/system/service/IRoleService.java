package gzhu.edu.cn.exam.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.system.entity.Role;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author loading
 * @since 2021-04-06
 */
public interface IRoleService extends IService<Role> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param role:检索的角色信息
     * @return
     */
    PageData<Role> getPage(int page, int limit, Role role);

    /**
     * 用于excel数据验证
     *
     * @return 返回所有可选角色列表
     */
    String[] getNameList();

    /**
     * 根据名字获取角色
     *
     * @param role 角色名字
     * @return 返回角色实体信息
     */
    Role getRoleByName(String role);
}
