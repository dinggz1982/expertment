package gzhu.edu.cn.exam.modules.datamanage.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.datamanage.dto.CollectDto;
import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.experiment.vo.RealHourGroupByTypeVo;
import gzhu.edu.cn.exam.modules.system.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 汇总数据前端控制器
 *
 * @author Yinglei Jie on 2021/12/6
 */
@Slf4j
@Controller
@RequestMapping("/datamanage/collect/")
public class CollectController {

    @Resource
    private UserMapper userMapper;
    @Resource
    private ISignupService signupService;
    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;


    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/datamanage/collect";
    }

    @GetMapping("/getData")
    @ResponseBody
    public R getData(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
                     @RequestParam(value = "limit", defaultValue = "10", required = false) int limit,
                     String content,
                     @RequestParam Map<String, String> params) {
        IPage<CollectDto> pageInfo = new Page<>(page, limit);
        //获取被试列表
        pageInfo = userMapper.selectBeiShiStudentList(pageInfo, content, params);
        List<CollectDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setGroupByHour(expApplyHourStatisticsService.getHourGroupByType(item.getId())));
        }
        return R.ok().put("data", pageInfo);
    }


    @GetMapping("/exportToExcel")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        List<CollectDto> records = userMapper.selectBeiShiStudentExportList();
        List<Map<String, Object>> rows = new ArrayList<>();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setGroupByHour(expApplyHourStatisticsService.getHourGroupByType(item.getId())));
            records.forEach(item -> {
                Map<String, Object> row1 = new LinkedHashMap<>();
                row1.put("姓名", item.getRealName());
                row1.put("学号", item.getUsername());
                row1.put("年级", item.getMajorName());
                row1.put("班级", item.getClassName());
                List<RealHourGroupByTypeVo> vo = item.getGroupByHour();
                if (!vo.isEmpty()) {
                    vo.forEach(i -> row1.put(i.getName(), i.getRealHour()));
                }
                rows.add(row1);
            });
        }
        // 通过工具类创建writer，默认创建xls格式
        ExcelWriter writer = ExcelUtil.getWriter(true);
        // 一次性写出内容，使用默认样式，强制输出标题
        if (!rows.isEmpty()) {
            writer.write(rows, true);
        }
        //response为HttpServletResponse对象
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String filename = "汇总数据导出";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // 关闭writer，释放内存
        writer.close();
        //此处记得关闭输出Servlet流
        IoUtil.close(out);
    }
}
