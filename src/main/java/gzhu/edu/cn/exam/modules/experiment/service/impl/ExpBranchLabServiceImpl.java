package gzhu.edu.cn.exam.modules.experiment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpBranchLab;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpBranchLabMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpBranchLabService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Objects;

/**
 * <p>
 * 实验分室 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-04-05
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ExpBranchLabServiceImpl extends ServiceImpl<ExpBranchLabMapper, ExpBranchLab> implements ExpBranchLabService {

    @Override
    public void saveOrUpdateExpBranch(ExpBranchLab expBranchLab) {
        Assert.notNull(expBranchLab, "非法数据");
        if (Objects.isNull(expBranchLab.getId())) {
            //新增
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            expBranchLab.setCreateDate(sdf.format(new Date()));
            this.save(expBranchLab);
        } else {
            this.updateById(expBranchLab);
        }
    }

    @Override
    public IPage<ExpBranchLab> getTableList(Map<String, String> params) {
        int page = Objects.nonNull(params.get("page")) && !params.get("page").isEmpty() ? Integer.parseInt(params.get("page")) : 1;
        int limit = Objects.nonNull(params.get("limit")) && !params.get("limit").isEmpty() ? Integer.parseInt(params.get("limit")) : 10;
        IPage<ExpBranchLab> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<ExpBranchLab> q = new LambdaQueryWrapper<>();
        if (Objects.nonNull(params.get("name")) && !params.get("name").isEmpty()) {
            q.eq(ExpBranchLab::getName, params.get("name"));
        }
        return this.getBaseMapper().selectPage(pageInfo, q);
    }
}
