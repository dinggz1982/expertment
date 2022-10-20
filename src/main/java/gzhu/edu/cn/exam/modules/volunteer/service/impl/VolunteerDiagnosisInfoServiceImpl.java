package gzhu.edu.cn.exam.modules.volunteer.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerDiagnosisInfo;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.enums.DiagnosisType;
import gzhu.edu.cn.exam.modules.volunteer.mapper.VolunteerDiagnosisInfoMapper;
import gzhu.edu.cn.exam.modules.volunteer.service.VolunteerDiagnosisInfoService;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 志愿者诊断信息 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class VolunteerDiagnosisInfoServiceImpl extends ServiceImpl<VolunteerDiagnosisInfoMapper, VolunteerDiagnosisInfo> implements VolunteerDiagnosisInfoService {

    @Override
    public void saveInfo(VolunteerRegister register, VolunteerRegisterVo info) {
//        if(Objects.no)
        Assert.notNull(info, "");
        List<String> list = info.getInfo();
        if (Objects.nonNull(list) && !list.isEmpty()) {
            list.forEach(item -> {
                int integer = Integer.parseInt(item);
                VolunteerDiagnosisInfo diagnosisInfo = new VolunteerDiagnosisInfo();
                diagnosisInfo.setTypeId(integer);
                diagnosisInfo.setVolunteerRegisterId(register.getId());
                if ("-1".equals(item)) {
                    diagnosisInfo.setDiagnosisInfo(info.getInfoOther());
                    this.save(diagnosisInfo);
                } else {
                    diagnosisInfo.setDiagnosisInfo(DiagnosisType.getDescByCode(integer));
                    this.save(diagnosisInfo);
                }
            });
        }
    }

    @Override
    public List<VolunteerDiagnosisInfo> getListByRegisterId(Integer id) {
        LambdaQueryWrapper<VolunteerDiagnosisInfo> q = new LambdaQueryWrapper<>();
        q.eq(VolunteerDiagnosisInfo::getVolunteerRegisterId, id).orderByAsc(VolunteerDiagnosisInfo::getId);
        return this.baseMapper.selectList(q);
    }
}
