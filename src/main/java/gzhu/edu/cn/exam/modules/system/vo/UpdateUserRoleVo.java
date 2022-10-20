package gzhu.edu.cn.exam.modules.system.vo;

import lombok.Data;

import java.util.List;

/**
 * @author Yinglei Jie on 2022/4/3
 */
@Data
public class UpdateUserRoleVo {

    /**
     * 操作类型
     */
    private String type;

    /**
     * 需要操作的用户列表
     */
    private List<Integer> userIds;

    /**
     * 需要操作的权限
     */
    private List<Integer> roleIds;

}
