package gzhu.edu.cn.exam.modules.system.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.system.entity.ItsFrontTeacher;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.mapper.ItsFrontTeacherMapper;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import gzhu.edu.cn.exam.modules.system.service.ItsFrontTeacherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2022-02-22
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ItsFrontTeacherServiceImpl extends ServiceImpl<ItsFrontTeacherMapper, ItsFrontTeacher> implements ItsFrontTeacherService {
    @Resource
    private IUserService userService;

    @Override
    public void addFrontTeacher(String userId) {
        User user = userService.getById(userId);
        Assert.notNull(user, "该教师不存在");
        Assert.isTrue("教师".equals(user.getIdentity()), "该用户不是教师身份");
        LambdaQueryWrapper<ItsFrontTeacher> q = new LambdaQueryWrapper<>();
        q.eq(ItsFrontTeacher::getUserId, userId);
        List<ItsFrontTeacher> list = this.baseMapper.selectList(q);
        Assert.isTrue(list.isEmpty(), "该教师已经存在展示列表");
        ItsFrontTeacher itsFrontTeacher = new ItsFrontTeacher();
        itsFrontTeacher.setUserId(Integer.valueOf(userId));
        this.save(itsFrontTeacher);
    }
}
