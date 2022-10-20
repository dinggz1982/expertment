package gzhu.edu.cn.exam.modules.volunteer.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * <p>
 * 志愿者诊断信息
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
@Data
public class VolunteerDiagnosisInfo {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer volunteerRegisterId;

    /**
     * 诊断信息
     */
    private String diagnosisInfo;

    /**
     * 类型id
     */
    private Integer typeId;

}
