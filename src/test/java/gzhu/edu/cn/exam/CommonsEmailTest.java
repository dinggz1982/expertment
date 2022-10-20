package gzhu.edu.cn.exam;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;

import javax.mail.internet.MimeUtility;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * @author Yinglei Jie on 2021/12/23
 */

public class CommonsEmailTest {
    /**
     * 发送文本邮件
     *
     * @throws Exception
     */
    public static boolean sendTextMail(String strMail, String strTitle, String strText) throws Exception {
        boolean bret = false;
        HtmlEmail mail = new HtmlEmail();
        // 设置邮箱服务器信息
        mail.setSslSmtpPort("465");
        mail.setHostName("smtp.qq.com");
        // 设置密码验证器
        mail.setAuthentication("842712494@qq.com", "vhrsjrsxqzgjbdji");
        // 设置邮件发送者
        mail.setFrom("842712494@qq.com");
        // 设置邮件接收者
        mail.addTo(strMail);
        // 设置邮件编码
        mail.setCharset(StandardCharsets.UTF_8.name());
        // 设置邮件主题
        mail.setSubject(strTitle);
        // 设置邮件内容
        mail.setMsg(strText);
        EmailAttachment attachment = new EmailAttachment();
        // 也可以发送本地文件作为附件
        attachment.setPath("C:\\Users\\84271\\Desktop\\用户导入模板 (1).xlsx");
        // 附件名称
        String s = MimeUtility.encodeText("用户导入模板.xlsx");
        attachment.setName(s);
        // 添加附件
        mail.attach(attachment);
        // 设置邮件发送时间
        mail.setSentDate(new Date());
        // 发送邮件
        mail.send();
        return bret;
    }

    public static void main(String[] args) {
        try {
            if (sendTextMail("backExperiment@163.com", "测试QQ邮箱发送", "你们好吗???"))
                System.out.println("QQ邮件发送成功");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
