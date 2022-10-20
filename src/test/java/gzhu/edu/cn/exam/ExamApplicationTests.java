package gzhu.edu.cn.exam;

import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.mapper.MenuMapper;
import gzhu.edu.cn.exam.modules.system.mapper.RoleMapper;
import gzhu.edu.cn.exam.modules.system.mapper.UserMapper;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class ExamApplicationTests {
    //通过依赖注入
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private MenuMapper menuMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private IUserService userService;

    @Test
    void contextLoads() {
    }

    @Test
    public void addUser() {
        List<User> users = new ArrayList<>();
        for (int i = 1; i <= 1000; i++) {
            User user = new User();
            user.setUsername("张三" + i);
            user.setPassword("1234");
            user.setRealName("张三" + i);
            //user.setEmail("abc@163.com");
            user.setGender("男");
            //user.setStudentNo("123");
            users.add(user);
        }
        userService.saveBatch(users);

    }

    @Test
    public void delete() {
        this.userMapper.deleteById(1);
    }

    /**
     * 查找用户
     */
    @Test
    public void getUser() {
        User user = this.userMapper.selectById(1);
        System.out.println(user);
    }

    @Test
    public void editUser() {
        User user = this.userMapper.selectById(4);
        //	user.setStudentNo("202001111");
        user.setUsername("小花");
        user.setGender("女");
        this.userMapper.updateById(user);
    }

    @Test
    public void getRole() {
        Role role = roleMapper.selectById(1);
        System.out.println(role);
    }


}
