package gzhu.edu.cn.exam.modules.system.mapper;

import gzhu.edu.cn.exam.modules.system.entity.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2021-04-07
 */
public interface MenuMapper extends BaseMapper<Menu> {

    @Select("SELECT id FROM its_menu where id in (SELECT menu_id from its_role_menu where role_id=#{roleId})")
    List<Integer> selectByMenuIdByRoleId(@Param("roleId") int roleId);

    @Select("SELECT id,url,icon FROM its_menu where id in (SELECT menu_id from its_role_menu where role_id=#{roleId})")
    List<Menu> getMenuByRoleId(@Param("roleId") int roleId);

    /**
     * 根据角色id删除权限菜单对应表
     *
     * @param roleId
     */
    @Delete("delete from its_role_menu where role_id=#{roleId}")
    void deleteMenuIdByRoleId(@Param("roleId") int roleId);

    @Insert("insert into its_role_menu (role_id,menu_id) values ${sql}")
    void saveMenuIdAndRoleId(@Param("sql") String sql);

    //@Select("select distinct(m.id),m.url,m.name,m.icon,m.type,m.open,m.order_number,m.parent_id from its_menu m,its_role_menu rm where rm.role_id in(#{roleIds}) and rm.menu_id = m.id and m.parent_id =0 and m.type=0 order by m.order_number asc")
    List<Menu> getParentMenuByRoleIds(@Param("roleIds") String roleIds);

    //    @Select("select distinct(m.id),m.url,m.name,m.icon,m.type,m.open,m.order_number,m.parent_id from its_menu m,its_role_menu rm where rm.role_id in(${roleIds}) and  rm.menu_id = m.id and  m.parent_id =#{pId} and m.type=0 order by m.order_number asc")
    List<Menu> getChildMenuByRoleIdsAndParentId(@Param("roleIds") String roleIds, @Param("pId") Integer pId);

}
