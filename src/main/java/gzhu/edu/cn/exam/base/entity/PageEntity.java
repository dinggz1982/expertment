package gzhu.edu.cn.exam.base.entity;

import lombok.Data;

/**
 * @author Yinglei Jie on 2022/2/17
 */
@Data
public class PageEntity {
    /**
     * 页大小
     */
    private int limit = 10;

    /**
     * 页数
     */
    private int page = 1;

}
