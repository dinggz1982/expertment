package gzhu.edu.cn.exam.base.entity;

import com.baomidou.mybatisplus.annotation.TableLogic;

import java.io.Serializable;

/**
 * @program: exam
 * @description:实体类的父类
 * @author: 丁国柱
 * @create: 2021-04-06 00:25
 */
public abstract class BaseEntity implements Serializable {

    @TableLogic
    private Integer deleted;

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }
}