package gzhu.edu.cn.exam.modules.organization.service;

import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.organization.entity.ClassStudent;

public interface IClassStudentService extends IService<ClassStudent> {

    /**
     * @param page:当前页面数
     * @param limit:每一页显示多少条数据
     * @param classStudent:要建设的班级-用户信息
     * @return
     */
    public PageData<ClassStudent> getPage(int page, int limit, ClassStudent classStudent);

    public void addClassStudent( int classId,  int userId);

}
