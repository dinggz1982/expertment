package gzhu.edu.cn.exam.modules.experiment.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author loading
 * @since 2022-02-17
 */
@Data
public class ExperimentDescription {

    private static final long serialVersionUID = 1L;

    private String description;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;


}
