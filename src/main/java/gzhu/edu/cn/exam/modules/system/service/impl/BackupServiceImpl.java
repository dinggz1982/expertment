package gzhu.edu.cn.exam.modules.system.service.impl;

import cn.hutool.core.io.FileUtil;
import gzhu.edu.cn.exam.base.utils.CommonsEmailTest;
import gzhu.edu.cn.exam.modules.system.service.BackupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.InputStream;
import java.util.UUID;

/**
 * @author Yinglei Jie on 2021/12/22
 */
@Slf4j
@Service
public class BackupServiceImpl implements BackupService {

    @Value("${spring.datasource.back.command}")
    private String command;

    @Value("${spring.datasource.back.mail}")
    private String backMail;

    @Override
    public void backup() {
        try {
            String path = "/tmp/" + UUID.randomUUID();
            log.error("文件路径为：{}", path);
            Runtime r = Runtime.getRuntime();
            // 在单独的进程中执行指定的字符串命令
            Process p = r.exec(command);
//            p.
            // 获得连接到进程正常输出的输入流，该输入流从该Process对象表示的进程的标准输出中获取数据
            InputStream is = p.getInputStream();
            File targetFile = new File(path);
            FileUtil.writeFromStream(is, targetFile);
            CommonsEmailTest.sendTextMail(backMail, "备份数据", "备份数据", path);
        } catch (Exception e) {
            log.error("备份失败，原因为：{}", e.getMessage(), e);
        }
    }
}
