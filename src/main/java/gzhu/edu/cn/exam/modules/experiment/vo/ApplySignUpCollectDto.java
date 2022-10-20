package gzhu.edu.cn.exam.modules.experiment.vo;

import lombok.Data;

import java.util.List;

/**
 * 实验报名汇总数据
 *
 * @author Yinglei Jie on 2021/12/29
 */
@Data
public class ApplySignUpCollectDto {

    private String id;

    private String name;

    private String hours;

    private String number;

    private String applyNumber;

    private String finishNumber;

    private List<CollectRecordListDto> recordList;
}
