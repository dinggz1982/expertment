package gzhu.edu.cn.exam.base.model;

import lombok.Data;

import java.util.List;

/**
 * @program: mix-tech
 * @description:树
 * @author: 丁国柱
 * @create: 2021-05-02 13:50
 */
@Data
public class TreeData<T> {
    private int count;
    private String msg;
    private int code;
    private List<T> data;
}