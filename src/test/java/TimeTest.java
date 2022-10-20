import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Yinglei Jie on 2022/3/12
 */
public class TimeTest {


    public static void getAlphalDate() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date bt = sdf.parse("2017-05-02 00:00:00");
        Date ot = sdf.parse("2017-05-04 00:00:00");
        Date st = sdf.parse("2017-05-03 00:00:00");
        Date ed = sdf.parse("2017-05-17 00:00:00");
        long btlong = Math.min(bt.getTime(), ot.getTime());// 开始时间
        long otlong = Math.max(bt.getTime(), ot.getTime());// 结束时间
        long stlong = Math.min(st.getTime(), ed.getTime());// 开始时间
        long edlong = Math.max(st.getTime(), ed.getTime());// 结束时间
        // 具体算法如下
        // 首先看是否有包含关系
        if ((stlong >= btlong && stlong <= otlong) || (edlong >= btlong && edlong <= otlong)) {
            // 一定有重叠部分
            long sblong = Math.max(stlong, btlong);
            long eblong = Math.min(otlong, edlong);
            System.out.println("包含的开始时间是：" + sdf.format(sblong) + "-结束时间是：" + sdf.format(eblong));
            return;
        }
        System.out.println("无重叠的时间段:{单身妹子看过来！}");
    }

    public static void main(String[] args) throws Exception {
        getAlphalDate();
    }
}
