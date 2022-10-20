package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrument;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpInstrumentMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpInstrumentServiceImpl extends ServiceImpl<ExpInstrumentMapper, ExpInstrument> implements ExpInstrumentService {

    @Override
    public void saveInstrument(ExpInstrument exp) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        exp.setAddTime(df.format(new Date()));
        this.save(exp);
    }
}
