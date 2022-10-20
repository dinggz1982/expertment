package gzhu.edu.cn.exam.modules.system.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Set;

/**
 * <p>
 * 
 * </p>
 *
 * @author loading
 * @since 2021-04-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "its_role",resultMap = "baseResultMap")
public class Role extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 角色名称
     */
    private String name;

    private String description;

    @TableField(exist = false)
    private Set<Menu> menus;


}
