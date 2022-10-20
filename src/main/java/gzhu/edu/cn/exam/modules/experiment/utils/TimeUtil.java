package gzhu.edu.cn.exam.modules.experiment.utils;

import gzhu.edu.cn.exam.modules.experiment.vo.TimeListVo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author Yinglei Jie on 2021/11/26
 */
public class TimeUtil {


    public static boolean checkList(List<TimeListVo> list) {
        for (int i = 0; i < list.size(); i++) {
            //检验时间有没有冲突
            for (int j = 0; j < list.size(); j++) {
                if (i != j) {
                    TimeListVo first = list.get(i);
                    TimeListVo second = list.get(j);
                    boolean match = TimeUtil.match(first.getStartTime(), first.getEndTime(), second.getStartTime(), second.getEndTime());
                    if (match) {
                        return true;
                    }
                }
            }
        }
        return false;
    }


    /**
     * 判断时间是否重叠
     */
    public static boolean match(String projectStartTime1, String projectEndTime1, String projectStartTime2, String projectEndTime2) {
        LocalDateTime startTime1 = formatDate(projectStartTime1);
        LocalDateTime endTime1 = formatDate(projectEndTime1);

        LocalDateTime startTime2 = formatDate(projectStartTime2);
        LocalDateTime endTime2 = formatDate(projectEndTime2);
        return !(startTime2.isAfter(endTime1) || startTime1.isAfter(endTime2));
    }


    private static LocalDateTime formatDate(String date) {
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return LocalDateTime.parse(date, df);
    }

    public static void main(String[] args) {
        boolean match = match("2020-01-12 12:00", "2020-01-12 13:00", "2020-01-13 12:00", "2020-01-13 13:00");
        System.out.println(match);
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime time = LocalDateTime.now();
        String localTime = df.format(time);
//        LocalDateTime ldt = LocalDateTime.parse("2018-01-12 17:07:05", df);
//        System.out.println("LocalDateTime转成String类型的时间：" + localTime);
//        System.out.println("String类型的时间转成LocalDateTime：" + ldt);
    }
}
