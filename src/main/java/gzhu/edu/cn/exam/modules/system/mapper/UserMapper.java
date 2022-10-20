package gzhu.edu.cn.exam.modules.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.datamanage.dto.CollectDto;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.vo.UserExportToExcelVo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * User的Mapper
 *
 * @author 84271
 */
public interface UserMapper extends BaseMapper<User> {

    @Insert("insert into its_user_role (role_id,user_id) values (${roleId},${userId})")
    void insertUserRole(@Param("roleId") Integer roleId, @Param("userId") Integer userId);

    @Delete("delete from its_user_role where user_id = (select id from its_user where username=#{username})")
    void deleteUserRoleByUserName(@Param("username") String username);


    /**
     * 获取被试列表
     *
     * @param pageInfo 分页信息
     * @param content  搜索内容
     * @param map      参数
     * @return 返回分页数据
     */
    IPage<CollectDto> selectBeiShiStudentList(@Param("pageInfo") IPage<CollectDto> pageInfo, @Param("content") String content, @Param("map") Map<String, String> map);

    /**
     * 导出汇总数据 excel专用sql
     *
     * @return 返回导出列表
     */
    List<CollectDto> selectBeiShiStudentExportList();

    /**
     * 根据id删除用户
     *
     * @param userId user id
     */
    void delUserById(@Param("userId") Serializable userId);

    /**
     * 导出用户到excel文件
     *
     * @return 返回导出列表
     */
    List<UserExportToExcelVo> exportUserToExcel();

    /**
     * 查询当前用户列表中，需要添加的用户角色的id
     *
     * @param roleId  role id
     * @param userIds 用户id列表
     * @return 返回用户id列表
     */
    List<Integer> getUpdateUserRoleList(@Param("roleId") Integer roleId, @Param("userIds") List<Integer> userIds);
}
