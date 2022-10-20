package gzhu.edu.cn.exam.modules.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.system.entity.ItsUserRole;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.mapper.UserMapper;
import gzhu.edu.cn.exam.modules.system.service.IItsUserRoleService;
import gzhu.edu.cn.exam.modules.system.service.IRoleService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import gzhu.edu.cn.exam.modules.system.vo.UpdateUserRoleVo;
import gzhu.edu.cn.exam.modules.system.vo.UserExportToExcelVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @program: exam
 * @description:用户服务实现类
 * @author: 丁国柱
 * @create: 2021-04-04 23:01
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private IRoleService roleService;

    @Resource
    private IItsUserRoleService iItsUserRoleService;

    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    @Override
    public int saveOrUpdateUser(User user) {
        String roles = user.getUserEditRoleSel();
        int result = 0;
        BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
        if (user.getId() != null && user.getId() > 0) {
            User dbUser = this.getById(user.getId());
//            if (IdentityEnum.TEACHER.getName().equals(user.getIdentity())) {
//                LambdaUpdateWrapper<User> w = new LambdaUpdateWrapper<>();
//                w.eq(User::getId, user.getId())
//                        .set(User::getSchoolId, null)
//                        .set(User::getCollegeId, null)
//                        .set(User::getMajorId, null)
//                        .set(User::getClassId, null);
//                this.update(w);
//                user.setSchoolId(null);
//                user.setCollegeId(null);
//                user.setMajorId(null);
//                user.setClassId(null);
//            }
            user.setPassword(dbUser.getPassword());
            this.updateById(user);
            expApplyHourStatisticsService.updateUserHour(user.getId(), user.getHour());
            //更新
            result = 2;
        } else {
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("username", user.getUsername());
            if (this.userMapper.selectOne(queryWrapper) == null) {
                String password = user.getPassword();
                if (password == null) {
                    password = "123456";
                }
//                if (IdentityEnum.TEACHER.getName().equals(user.getIdentity())) {
//                    user.setSchoolId(null);
//                    user.setCollegeId(null);
//                    user.setMajorId(null);
//                    user.setClassId(null);
//                }
                user.setPassword(bc.encode(password));
                this.save(user);
                //保存
                result = 1;
                expApplyHourStatisticsService.updateUserHour(user.getId(), user.getHour());
            } else {
                //用户已经存在！
                result = 0;
            }
        }
        this.userMapper.deleteUserRoleByUserName(user.getUsername());
        user = this.findByName(user.getUsername());
        if (roles != null && roles.length() > 0) {
            String[] ids = roles.split(",");
            for (int i = 0; i < ids.length; i++) {
                int roleId = Integer.parseInt(ids[i]);
                this.userMapper.insertUserRole(roleId, user.getId());
            }
        }
        return result;
    }

    @Override
    public int saveBatchUser(List<User> users) {
        int result = 0;
        this.saveBatch(users);
        for (User user : users) {
            String roles = user.getUserEditRoleSel();
            this.userMapper.deleteUserRoleByUserName(user.getUsername());
            //保存用户角色
            if (roles != null && roles.length() > 0) {
                String[] ids = roles.split(",");
                for (int i = 0; i < ids.length; i++) {
                    int roleId = Integer.parseInt(ids[i]);
                    this.userMapper.insertUserRole(roleId, user.getId());
                }
            }
        }
        return result;
    }

    @Override
    public PageData<User> getPage(int page, int limit) {
        PageData<User> userPage = new PageData<>();
        Page pageInfo = new Page(page, limit);
        IPage ipage = this.page(pageInfo);
        userPage.setCount(ipage.getTotal());//总记录数
        userPage.setData(ipage.getRecords());//当前分页的记录
        userPage.setCode(0);//正确的分页响应code为0
        userPage.setMsg("用户分页");
        return userPage;
    }

    @Override
    public PageData<User> getPage(int page, int limit, User user, Map<String, String> params) {
        PageData<User> userPage = new PageData<>();
        Page<User> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        if (user.getUsername() != null && user.getUsername().length() > 0) {
            queryWrapper.like(User::getUsername, user.getUsername());
        }
        if (user.getRealName() != null && user.getRealName().length() > 0) {
            queryWrapper.like(User::getRealName, user.getRealName());
        }
        if (user.getGender() != null && user.getGender().length() > 0) {
            queryWrapper.eq(User::getGender, user.getGender());
        }
        String schoolId = params.get("schoolId");
        if (Objects.nonNull(schoolId) && !schoolId.isEmpty()) {
            queryWrapper.eq(User::getSchoolId, schoolId);
            String collegeId = params.get("collegeId");
            if (Objects.nonNull(collegeId) && !collegeId.isEmpty()) {
                queryWrapper.eq(User::getCollegeId, collegeId);
                String majorId = params.get("majorId");
                if (Objects.nonNull(majorId) && !majorId.isEmpty()) {
                    queryWrapper.eq(User::getMajorId, majorId);
                    String classId = params.get("classId");
                    if (Objects.nonNull(classId) && !classId.isEmpty()) {
                        queryWrapper.eq(User::getClassId, classId);
                    }
                }
            }
        }
        this.page(pageInfo, queryWrapper);
        userPage.setCount(pageInfo.getTotal());
        userPage.setData(pageInfo.getRecords());
        userPage.setCode(0);
        userPage.setMsg("用户分页");
        return userPage;
    }

    @Override
    public void resetPassword(User user, String password) {
        BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
        user.setPassword(bc.encode(password));
        this.updateById(user);
    }

    @Override
    public User findByName(String username) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        User user = this.getOne(queryWrapper);
        return user;
    }

    @Override
    public User findByRealName(String realName) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("real_name", realName);
        User user = this.getOne(queryWrapper);
        return user;
    }

    @Override
    public List<User> getStudentList(String username) {
        QueryWrapper<User> wp = new QueryWrapper<>();
        wp.eq("teacher_no", username);
        return this.list(wp);
    }

    @Override
    public R registry(User user) {
        String key = user.getUsername().intern();
        synchronized (key) {
            User dbUser = this.findByName(user.getUsername());
            if (Objects.nonNull(dbUser)) {
                return R.error("用户名已存在!");
            }
            user.setRealName(user.getUsername());
            BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
            user.setPassword(bc.encode(user.getPassword()));
            this.save(user);
            //刚保存的用户
            ItsUserRole role = new ItsUserRole();
            role.setUserId(user.getId());
            //普通用户权限
            role.setRoleId(6);
            iItsUserRoleService.save(role);
            return R.ok("注册成功");
        }
    }


    @Override
    public void delUserById(Serializable userId) {
        this.baseMapper.delUserById(userId);
    }

    @Override
    public List<UserExportToExcelVo> exportUserToExcel() {
        return this.baseMapper.exportUserToExcel();
    }

    @Override
    public void updateFrontTeacherInfo(User user) {
        Assert.notNull(user.getId(), "id不能为空");
        LambdaUpdateWrapper<User> w = new LambdaUpdateWrapper<>();
        w.eq(User::getId, user.getId());
        if (Objects.nonNull(user.getPositionName())) {
            w.set(User::getPositionName, user.getPositionName());
        }
        if (Objects.nonNull(user.getAvatarPath())) {
            w.set(User::getAvatarPath, user.getAvatarPath());
        }
        if (Objects.nonNull(user.getFrontSort())) {
            w.set(User::getFrontSort, user.getFrontSort());
        }
        this.update(w);
    }

    @Override
    public void updateUserRole(UpdateUserRoleVo vo) {
        String type = vo.getType();
        List<Integer> userIds = vo.getUserIds();
        Assert.isTrue(Objects.nonNull(userIds) && !userIds.isEmpty(), "非法数据");
        List<Integer> roleIds = vo.getRoleIds();
        Assert.isTrue(Objects.nonNull(roleIds) && !roleIds.isEmpty(), "非法数据");
        if (Objects.equals(type, "add")) {
            //添加新权限
            List<ItsUserRole> res = new ArrayList<>();
            roleIds.forEach(item -> {
                List<Integer> updateIdList = this.baseMapper.getUpdateUserRoleList(item, userIds);
                if (Objects.nonNull(updateIdList) && !updateIdList.isEmpty()) {
                    //更新列表不为空
                    updateIdList.forEach(i -> {
                        ItsUserRole userRole = new ItsUserRole();
                        userRole.setRoleId(item);
                        userRole.setUserId(i);
                        res.add(userRole);
                    });
                }
            });
            if (!res.isEmpty()) {
                //不为空，批量添加
                iItsUserRoleService.saveBatch(res);
            }
        } else if (Objects.equals(type, "delete")) {
            LambdaUpdateWrapper<ItsUserRole> u = new LambdaUpdateWrapper<>();
            u.in(ItsUserRole::getUserId, userIds).in(ItsUserRole::getRoleId, roleIds);
            iItsUserRoleService.getBaseMapper().delete(u);
        }

    }
}
