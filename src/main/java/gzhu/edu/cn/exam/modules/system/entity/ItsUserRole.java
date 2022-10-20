package gzhu.edu.cn.exam.modules.system.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author loading
 * @since 2021-11-22
 */
@Data
public class ItsUserRole {

    private static final long serialVersionUID = 1L;

    private Integer userId;

    private Integer roleId;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;


}
