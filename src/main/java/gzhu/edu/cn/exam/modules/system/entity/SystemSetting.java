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
 * @since 2022-03-05
 */
@Data
public class SystemSetting {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 键
     */
    private String settingKey;

    /**
     * 值
     */
    private String value;


}
