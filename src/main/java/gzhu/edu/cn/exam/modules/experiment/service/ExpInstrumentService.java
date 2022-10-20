package gzhu.edu.cn.exam.modules.experiment.service;


import com.baomidou.mybatisplus.extension.service.IService;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrument;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author loading
 * @since 2021-12-11
 */
public interface ExpInstrumentService extends IService<ExpInstrument> {

    /**
     * 保存新仪器
     *
     * @param exp 前端传值
     */
    void saveInstrument(ExpInstrument exp);
}
