package gzhu.edu.cn.exam.modules.datamanage.dto;

import cn.hutool.core.annotation.Alias;
import lombok.Data;

/**
 * 分项数据导出dto
 *
 * @author Yinglei Jie on 2021/12/7
 */
@Data
public class ItemDataExportDto {

    @Alias("实验名称")
    private String applyName;

    @Alias("实验类型")
    private String typeName;

    @Alias("设定实验时")
    private String hours;

    @Alias("主试姓名")
    private String teacherName;

    @Alias("被试姓名")
    private String studentName;

    @Alias("学号")
    private String studentUsername;

    @Alias("年级")
    private String majorName;

    @Alias("班级")
    private String className;

    @Alias("参加实验时间")
    private String startTime;

    @Alias("获得实验时")
    private String realHour;

    @Alias("状态")
    private String status;

}

