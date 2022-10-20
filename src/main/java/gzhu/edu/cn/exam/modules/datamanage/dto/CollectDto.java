package gzhu.edu.cn.exam.modules.datamanage.dto;

import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import lombok.Data;

import java.util.List;

/**
 * @author Yinglei Jie on 2021/12/7
 */
@Data
public class CollectDto {

    private Integer id;

    private String username;

    private String realName;

    private Integer majorId;

    private Integer classId;

    private String majorName;

    private String className;

    private List<RealHourGroupByTypeVo> groupByHour;

}
