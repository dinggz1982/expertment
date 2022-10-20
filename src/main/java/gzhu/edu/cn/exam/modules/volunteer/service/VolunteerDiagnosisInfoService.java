package gzhu.edu.cn.exam.modules.volunteer.service;


import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerDiagnosisInfo;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterVo;

import java.util.List;

/**
 * <p>
 * 志愿者诊断信息 服务类
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
public interface VolunteerDiagnosisInfoService extends IService<VolunteerDiagnosisInfo> {

    void saveInfo(VolunteerRegister register, VolunteerRegisterVo info);

    List<VolunteerDiagnosisInfo> getListByRegisterId(Integer id);
}
