package gzhu.edu.cn.exam.modules.system.controller;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootTest
public class UserControllerTest {

    @Test
    public void test1() {
        String pass = "123456";
        BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
        System.out.println(bc.encode(pass));
        System.out.println(bc.encode(pass));
        System.out.println(bc.encode(pass));
        System.out.println(bc.encode(pass));
        System.out.println(bc.encode(pass));

        boolean f = bc.matches("123456", "$2a$04$2VxeXp5fi.n3wMdkPQnqOePpMjh9G9ZsvV2MM.2ge.IOwCheUniZW");
        System.out.println(f);
    }
}
