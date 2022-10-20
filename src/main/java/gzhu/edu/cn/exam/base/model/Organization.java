package gzhu.edu.cn.exam.base.model;

import lombok.Data;

/**
 * @program: mix-tech
 * @description:组织机构某些
 * @author: 丁国柱
 * @create: 2021-05-13 12:13
 */
@Data
public class Organization {
    private int id;
    private String type;
    private int pId;
}