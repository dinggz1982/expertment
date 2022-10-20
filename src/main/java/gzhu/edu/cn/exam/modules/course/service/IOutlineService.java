package gzhu.edu.cn.exam.modules.course.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.course.entity.Outline;

import java.util.List;

/**
 * @program: exam
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-02 08:14
 */
public interface IOutlineService extends IService<Outline> {

    /**
     * 通过教材获取大纲
     * @param textbookId
     * @return
     */
    List<Outline> getOutlineByTextbookId(Integer textbookId);
}