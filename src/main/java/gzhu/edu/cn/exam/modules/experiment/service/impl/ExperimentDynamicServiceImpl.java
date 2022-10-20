package gzhu.edu.cn.exam.modules.experiment.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.ExperimentDynamic;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExperimentDynamicMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IExperimentDynamicService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-02-17
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExperimentDynamicServiceImpl extends ServiceImpl<ExperimentDynamicMapper, ExperimentDynamic> implements IExperimentDynamicService {

}
