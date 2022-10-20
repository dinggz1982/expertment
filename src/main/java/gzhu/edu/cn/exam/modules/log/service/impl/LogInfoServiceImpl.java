package gzhu.edu.cn.exam.modules.log.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.log.entity.LogInfo;
import gzhu.edu.cn.exam.modules.log.mapper.LogInfoMapper;
import gzhu.edu.cn.exam.modules.log.service.ILogInfoService;
import org.springframework.stereotype.Service;

@Service
public class LogInfoServiceImpl extends ServiceImpl<LogInfoMapper, LogInfo> implements ILogInfoService {

}
