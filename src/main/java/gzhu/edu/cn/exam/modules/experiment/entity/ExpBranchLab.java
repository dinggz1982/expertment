package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 实验分室
 * </p>
 *
 * @author loading
 * @since 2022-04-05
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ExpBranchLab extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    private String name;

    private String address;

    private String description;

    /**
     * 创建时间
     */
    private String createDate;

}
