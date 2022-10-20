package gzhu.edu.cn.exam.modules.volunteer.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.vo.RegisterListRequestVo;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterVo;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
public interface VolunteerRegisterService extends IService<VolunteerRegister> {
    /**
     * 保存
     *
     * @param vo 前端传值
     */
    void saveVolunteerRegister(VolunteerRegisterVo vo);

    /**
     * 获取申请列表
     *
     * @param vo 前端传值
     * @return 返回分页列表
     */
    IPage<VolunteerRegister> getRegisterDataList(RegisterListRequestVo vo);

    /**
     * 导出数据
     *
     * @return 返回导出列表
     */
    List<VolunteerRegister> getExportData();
}
