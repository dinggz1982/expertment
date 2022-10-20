package gzhu.edu.cn.exam.modules.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.mapper.RoleMapper;
import gzhu.edu.cn.exam.modules.system.service.IRoleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-04-06
 */
@Service
@Transactional
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Override
    public PageData<Role> getPage(int page, int limit, Role role) {
        PageData<Role> rolePage = new PageData<Role>();
        Page pageInfo = new Page(page, limit);
        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();

        if (role.getName() != null && role.getName().length() > 0) {
            queryWrapper.like("name", role.getName());
        }
        IPage ipage = this.page(pageInfo, queryWrapper);
        rolePage.setCount(ipage.getTotal());//总记录数
        rolePage.setData(ipage.getRecords());//当前分页的记录
        rolePage.setCode(0);//正确的分页响应code为0
        rolePage.setMsg("用户分页");
        return rolePage;
    }


    @Override
    public String[] getNameList() {
        List<Role> list = this.getBaseMapper().selectList(null);
        List<String> collect = list.stream().filter(item -> item.getId() != 1 && item.getId() != 2).map(Role::getName).collect(Collectors.toList());
        String[] res = new String[collect.size()];
        for (int i = 0; i < collect.size(); i++) {
            res[i] = collect.get(i);
        }
        return res;
    }

    @Override
    public Role getRoleByName(String role) {
        LambdaQueryWrapper<Role> w = new LambdaQueryWrapper<>();
        w.eq(Role::getName, role);
        List<Role> roles = this.baseMapper.selectList(w);
        if (Objects.nonNull(roles) && !role.isEmpty()) {
            return roles.get(0);
        }
        return null;
    }
}
