package gzhu.edu.cn.exam.modules.system.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.system.entity.SystemSetting;
import gzhu.edu.cn.exam.modules.system.mapper.SystemSettingMapper;
import gzhu.edu.cn.exam.modules.system.service.SystemSettingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-03-05
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class SystemSettingServiceImpl extends ServiceImpl<SystemSettingMapper, SystemSetting> implements SystemSettingService {

}
