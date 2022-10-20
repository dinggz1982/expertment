package gzhu.edu.cn.exam.base.utils;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;

import javax.mail.internet.MimeUtility;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Objects;

/**
 * @author Yinglei Jie on 2021/12/23
 */

public class CommonsEmailTest {
    /**
     * 发送文本邮件
     *
     * @throws Exception
     */
    public static void sendTextMail(String strMail, String strTitle, String strText, String filePath) throws Exception {
        HtmlEmail mail = new HtmlEmail();
        // 设置邮箱服务器信息
        mail.setSSLOnConnect(true);
        mail.setSslSmtpPort("465");
        mail.setHostName("smtp.qq.com");
        // 设置密码验证器
        mail.setAuthentication("842712494@qq.com", "vhrsjrsxqzgjbdji");
        // 设置邮件发送者
        mail.setFrom("842712494@qq.com");
        // 设置邮件接收者
        mail.addTo(strMail);
        mail.addCc("backexperiment@163.com");
        // 设置邮件编码
        mail.setCharset(StandardCharsets.UTF_8.name());
        // 设置邮件主题
        mail.setSubject(strTitle);
        // 设置邮件内容
        mail.setMsg(strText);
        if (Objects.nonNull(filePath)) {
            EmailAttachment attachment = new EmailAttachment();
            // 也可以发送本地文件作为附件
            attachment.setPath(filePath);
            // 附件名称
            String s = MimeUtility.encodeText("back.sql");
            attachment.setName(s);
            // 添加附件
            mail.attach(attachment);
        }
        // 设置邮件发送时间
        mail.setSentDate(new Date());
        // 发送邮件
        mail.send();
    }
}
