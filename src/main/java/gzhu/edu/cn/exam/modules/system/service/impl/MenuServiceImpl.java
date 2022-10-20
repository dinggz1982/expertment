package gzhu.edu.cn.exam.modules.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import gzhu.edu.cn.exam.modules.system.entity.Menu;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.mapper.MenuMapper;
import gzhu.edu.cn.exam.modules.system.mapper.UserMapper;
import gzhu.edu.cn.exam.modules.system.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.system.vo.TreeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-04-07
 */
@Service
@Transactional
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    @Autowired
    private MenuMapper menuMapper;
    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Menu> getAll() {
        QueryWrapper<Menu> wrapper = new QueryWrapper<>();
        wrapper.orderByAsc("order_number");
        return this.list(wrapper);
    }

    @Override
    public void deleteByMenuId(int id) {
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", id).or().eq("parent_id", id);
        this.baseMapper.delete(queryWrapper);
    }

    @Override
    public List<TreeVo> getAuthTreeByRoleId(int roleId) {
        List<Menu> menus = this.list();
        List<Integer> menuIds = menuMapper.selectByMenuIdByRoleId(roleId);
        List<TreeVo> treeVos = new ArrayList<>();
        for (Menu menu : menus
        ) {
            TreeVo vo = new TreeVo();
            vo.setId(menu.getId());
            vo.setName(menu.getName());
            vo.setpId(menu.getParentId());
            vo.setOpen(true);
            if (menuIds.contains(menu.getId())) {
                vo.setChecked(true);
            }
            treeVos.add(vo);

        }
        return treeVos;
    }

    @Override
    @Transactional
    public void updateAuth(int roleId, String ids) {
        this.menuMapper.deleteMenuIdByRoleId(roleId);
        String sql = "";
        if (ids != null && ids.length() > 0) {
            ids = ids.replace("[", "").replace("]", "");
            String[] authIds = ids.split(",");
            for (int i = 0; i < authIds.length; i++) {
                sql += "(" + roleId + "," + authIds[i] + "),";
            }
            sql = sql.substring(0, sql.length() - 1);
            this.menuMapper.saveMenuIdAndRoleId(sql);
        }
    }

    @Override
    @Transactional
    public Set<Menu> getMenusByUser(User user) {
        if (user != null) {
            Set<Role> roles = user.getRoles();
            List<Menu> parentMenu = null;
            if (roles != null && roles.size() > 0) {
                String ids = "";
                for (Iterator iterator = roles.iterator(); iterator.hasNext(); ) {
                    Role role = (Role) iterator.next();
                    int roleId = role.getId();
                    ids += roleId + ",";
                }
                ids = ids.substring(0, ids.length() - 1);

                parentMenu = this.menuMapper.getParentMenuByRoleIds(ids);
                for (Menu menu : parentMenu) {
                    List<Menu> childrenMenu = this.menuMapper.getChildMenuByRoleIdsAndParentId(ids, menu.getId());
                    Set<Menu> set = new TreeSet<>(childrenMenu);
                    menu.setSubMenus(set);
                }

                Set<Menu> userMenus = new TreeSet<>(parentMenu);
                return userMenus;
            } else {
                return null;
            }
        } else {
            return null;
        }

    }

    @Override
    public Set<Menu> getResourceByUser(User user) {
        Set<Role> roles = user.getRoles();
        Set<Menu> menus = new HashSet<>();
        if (roles != null) {
            for (Role role : roles
            ) {
                List<Menu> menuList = this.menuMapper.getMenuByRoleId(role.getId());
                for (Menu menu : menuList
                ) {
                    if (menu.getUrl() != null && menu.getUrl().length() > 0) {
                        menus.add(menu);
                    }
                }
            }
        }
        return menus;
    }
}
