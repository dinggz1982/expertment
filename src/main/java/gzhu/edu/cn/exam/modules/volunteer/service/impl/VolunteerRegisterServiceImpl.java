package gzhu.edu.cn.exam.modules.volunteer.service.impl;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.mapper.VolunteerRegisterMapper;
import gzhu.edu.cn.exam.modules.volunteer.service.VolunteerDiagnosisInfoService;
import gzhu.edu.cn.exam.modules.volunteer.service.VolunteerRegisterService;
import gzhu.edu.cn.exam.modules.volunteer.vo.RegisterListRequestVo;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class VolunteerRegisterServiceImpl extends ServiceImpl<VolunteerRegisterMapper, VolunteerRegister> implements VolunteerRegisterService {

    @Resource
    private VolunteerDiagnosisInfoService volunteerDiagnosisInfoService;


    @Override
    public void saveVolunteerRegister(VolunteerRegisterVo vo) {
        if (Objects.nonNull(vo)) {
            VolunteerRegister register = new VolunteerRegister();
            register.setRegisterType(vo.getRegisterType());
            register.setName(vo.getName());
            register.setBirth(vo.getBirth());
            register.setEmail(vo.getEmail());
            List<String> language = vo.getLanguage();
            if (Objects.nonNull(language) && !language.isEmpty()) {
                Set<String> set = new HashSet<>(language);
                register.setLanguage(JSONUtil.toJsonStr(set));
            }
            register.setMobile(vo.getMobile());
            register.setSex(vo.getSex());
            register.setNationality(vo.getNationality());
            register.setWechat(vo.getWechat());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            register.setRegisterDate(sdf.format(new Date()));
            this.save(register);
            volunteerDiagnosisInfoService.saveInfo(register, vo);
        }
    }

    @Override
    public IPage<VolunteerRegister> getRegisterDataList(RegisterListRequestVo vo) {
        IPage<VolunteerRegister> pageData = new Page<>(vo.getPage(), vo.getLimit());
        LambdaQueryWrapper<VolunteerRegister> q = new LambdaQueryWrapper<>();
        if (Objects.nonNull(vo.getName()) && !vo.getName().isEmpty()) {
            q.like(VolunteerRegister::getName, vo.getName());
        }
        this.baseMapper.selectPage(pageData, q);
        List<VolunteerRegister> records = pageData.getRecords();
        if (Objects.nonNull(records) && !records.isEmpty()) {
            records.forEach(item -> item.setInfo(volunteerDiagnosisInfoService.getListByRegisterId(item.getId())));
        }
        return pageData;
    }

    @Override
    public List<VolunteerRegister> getExportData() {
        List<VolunteerRegister> records = this.baseMapper.selectList(null);
        if (Objects.nonNull(records) && !records.isEmpty()) {
            records.forEach(item -> item.setInfo(volunteerDiagnosisInfoService.getListByRegisterId(item.getId())));
        }
        return records;
    }
}
