package gzhu.edu.cn.exam.modules.experiment.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;

import java.util.List;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:35
 */
public interface ExpTypeMapper extends BaseMapper<ExpType> {


    /**
     * 获取所有类型名称，用于excel表格
     *
     * @return 返回所有
     */
    List<String> getTypeNameList();

}
