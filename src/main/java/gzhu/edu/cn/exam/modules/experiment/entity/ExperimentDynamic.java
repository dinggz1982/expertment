package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotEmpty;

/**
 * <p>
 * 实验室动态
 * </p>
 *
 * @author loading
 * @since 2022-02-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ExperimentDynamic extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 动态标题
     */
    @NotEmpty(message = "动态标题不能为空")
    private String title;

    /**
     * 动态内容
     */
    @NotEmpty(message = "动态内容不能为空")
    private String content;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 是否发布（0未发布，1已发布）
     */
    private Integer isPublish = 0;


}
