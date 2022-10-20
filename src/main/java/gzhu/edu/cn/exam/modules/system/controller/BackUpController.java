package gzhu.edu.cn.exam.modules.system.controller;

import gzhu.edu.cn.exam.modules.system.service.BackupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * @author Yinglei Jie on 2021/12/23
 */
@Slf4j
@Controller
@RequestMapping("/system/backup")
public class BackUpController {
    @Resource
    private BackupService backupService;

//    @GetMapping("/backup")
//    @ResponseBody
    public String backup() {
        backupService.backup();
        return "ok";
    }
}
