package gzhu.edu.cn.exam.modules.system.service;

import gzhu.edu.cn.exam.modules.system.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.vo.TreeVo;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author loading
 * @since 2021-04-07
 */
public interface IMenuService extends IService<Menu> {

    public List<Menu> getAll();

    /**
     * 根据id删除菜单，同时删除父id为当前id的节点
     *
     * @param id
     */
    public void deleteByMenuId(int id);

    /**
     * 根据角色id获取权限菜单
     *
     * @param roleId
     * @return
     */
    public List<TreeVo> getAuthTreeByRoleId(int roleId);

    /**
     * 更新角色对应的权限菜单
     *
     * @param roleId
     * @param ids
     */
    public void updateAuth(int roleId, String ids);


    /**
     * 根据用户获取权限菜单
     *
     * @param user 当前用户
     * @return 返回用户菜单列表
     */
    Set<Menu> getMenusByUser(User user);

    /**
     * 根据用户获取权限url
     *
     * @param user
     * @return
     */
    Set<Menu> getResourceByUser(User user);


}
