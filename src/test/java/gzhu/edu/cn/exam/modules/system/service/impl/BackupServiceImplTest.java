package gzhu.edu.cn.exam.modules.system.service.impl;

import gzhu.edu.cn.exam.modules.system.service.BackupService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.SQLException;

@SpringBootTest
public class BackupServiceImplTest {
    @Resource
    private BackupService backupService;
    @Resource
    private DataSource dataSource;

    @Test
    public void test1() throws SQLException {
        backupService.backup();
    }

}
