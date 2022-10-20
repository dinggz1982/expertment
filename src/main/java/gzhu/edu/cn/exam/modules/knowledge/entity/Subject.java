package gzhu.edu.cn.exam.modules.knowledge.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

/**
 * @program: mix-tech
 * @description:学科
 * @author: 丁国柱
 * @create: 2021-05-02 08:08
 */
@TableName("knowledge_subject")
@Data
public class Subject extends BaseEntity {

    //主键
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    //学科名称
    private String name;

    //学段
    private String studyPeriod;
}