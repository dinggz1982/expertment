package gzhu.edu.cn.exam.modules.system.entity;

import gzhu.edu.cn.exam.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 *
 * </p>
 *
 * @author loading
 * @since 2022-02-22
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ItsFrontTeacher extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 年龄
     */
    private Integer userId;

    /**
     * 排序
     */
    private Integer sort;
}
