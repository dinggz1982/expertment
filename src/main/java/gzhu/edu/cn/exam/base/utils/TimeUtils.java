package gzhu.edu.cn.exam.base.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Yinglei Jie on 2022/3/12
 */
public class TimeUtils {
    /**
     * 获取两个时间段中，重合的时间段
     *
     * @return
     * @throws Exception
     */

    /**
     * 获取两个时间段中，重合的时间段
     *
     * @param bt bt
     * @param ot ot
     * @param st st
     * @param ed ed
     * @return 返回重合时间段
     * @throws Exception 异常
     */
    public static String getAlphalDate(Date bt, Date ot, Date st, Date ed) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//        Date bt = sdf.parse("2017-05-02 00:00:00");
//        Date ot = sdf.parse("2017-05-04 00:00:00");
//        Date st = sdf.parse("2017-05-03 00:00:00");
//        Date ed = sdf.parse("2017-05-17 00:00:00");
        // 开始时间
        long btlong = Math.min(bt.getTime(), ot.getTime());
        // 结束时间
        long otlong = Math.max(bt.getTime(), ot.getTime());
        // 开始时间
        long stlong = Math.min(st.getTime(), ed.getTime());
        // 结束时间
        long edlong = Math.max(st.getTime(), ed.getTime());
        // 具体算法如下
        // 首先看是否有包含关系
        if (!((stlong > otlong) || (btlong > edlong))) {
            // 一定有重叠部分
            long sblong = Math.max(stlong, btlong);
            long eblong = Math.min(otlong, edlong);
//            System.out.println("包含的开始时间是：" + sdf.format(sblong) + "-结束时间是：" + sdf.format(eblong));
            return sdf.format(sblong) + " - " + sdf.format(eblong);
        }
//        System.out.println("无重叠的时间段:{单身妹子看过来！}");
        return "";
    }
}
