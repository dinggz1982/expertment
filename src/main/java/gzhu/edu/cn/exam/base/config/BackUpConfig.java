package gzhu.edu.cn.exam.base.config;

import gzhu.edu.cn.exam.modules.system.service.BackupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2022/1/6
 */
@Slf4j
//@Configuration
@EnableScheduling
@Component
public class BackUpConfig {

    @Resource
    private BackupService backupService;

    @Scheduled(cron = "0 0 2 1/14 * ?")
    private void backupTasks() {
        log.info("开始备份");
        backupService.backup();
        log.info("结束备份");
    }
}
