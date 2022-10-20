package gzhu.edu.cn.exam.modules.volunteer.controller;

import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.service.VolunteerRegisterService;
import gzhu.edu.cn.exam.modules.volunteer.vo.RegisterListRequestVo;
import gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterExportVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.List;

import static gzhu.edu.cn.exam.modules.volunteer.vo.VolunteerRegisterExportVo.toExcelDataList;

/**
 * @author Yinglei Jie on 2022/2/28
 */
@Slf4j
@Controller
@RequestMapping("/volunteer/admin")
public class VolunteerRegisterAdminController {
    @Resource
    private VolunteerRegisterService volunteerRegisterService;

    @GetMapping({"/", "index"})
    public String index() {
        return "volunteer/volunteer-register-admin";
    }


    @PostMapping("/getRegisterDataList")
    @ResponseBody
    public R getRegisterDataList(@RequestBody RegisterListRequestVo vo) {
        return R.ok().put("data", volunteerRegisterService.getRegisterDataList(vo));
    }


    @RequestMapping("/exportExcel")
    public void exportExcel(HttpServletResponse response) throws Exception {
        List<VolunteerRegister> data = volunteerRegisterService.getExportData();
        List<VolunteerRegisterExportVo> res = toExcelDataList(data);
        ExcelWriter writer = ExcelUtil.getWriter(true);
        writer.setOnlyAlias(true);
        writer.write(res, true);
        //response为HttpServletResponse对象
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
//test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
        String name = URLEncoder.encode("注册数据.xlsx", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + name);
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out);
// 关闭writer，释放内存
        writer.close();
    }
}
