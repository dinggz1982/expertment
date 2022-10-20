package gzhu.edu.cn.exam.modules.datamanage.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.datamanage.dto.ItemDataExportDto;
import gzhu.edu.cn.exam.modules.experiment.entity.Apply;
import gzhu.edu.cn.exam.modules.experiment.entity.Signup;
import gzhu.edu.cn.exam.modules.experiment.enums.SignUpType;
import gzhu.edu.cn.exam.modules.experiment.service.IApplyService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import gzhu.edu.cn.exam.modules.experiment.service.ISignupService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

/**
 * 分项数据页面控制器
 *
 * @author Yinglei Jie on 2021/12/6
 */
@Slf4j
@Controller
@RequestMapping("/datamanage/itemdata/")
public class ItemDataController {
    @Resource
    private IApplyService applyService;
    @Resource
    private ISignupService signupService;
    @Resource
    private IUserService userService;
    @Resource
    private IExpLabRecordService expLabRecordService;
    @Resource
    private IExpTypeService expTypeService;

    @GetMapping({"/", "index"})
    public String index() {
        return "modules/datamanage/itemdata";
    }

    @GetMapping("/getApplyList")
    @ResponseBody
    public R getApplyList() {
        //管理员查看所有实验
        List<Apply> applies = applyService.getBaseMapper().selectList(null);
        return R.ok().put("data", applies);
    }

    @GetMapping("/getDataListByApplyId/{id}")
    @ResponseBody
    public R getDataListByApplyId(@PathVariable String id,
                                  @RequestParam Map<String, String> params,
                                  String search,
                                  @RequestParam(value = "expTypeId", defaultValue = "-1", required = false) String expTypeId,
                                  @RequestParam(value = "page", defaultValue = "1", required = false) Integer page,
                                  @RequestParam(value = "limit", defaultValue = "10", required = false) Integer limit) {
        R r = R.ok();
        IPage<Signup> pageInfo = new Page<>(page, limit);
//        if (Objects.isNull(search) || search.isEmpty()) {
//            //搜索内容为空
//            LambdaQueryWrapper<Signup> w = new LambdaQueryWrapper<>();
//            w.eq(Signup::getStatus, SignUpType.ADMIN_PASS.getCode());
//            if (!"-1".equals(id)) {
//                w.eq(Signup::getApplyId, id);
//            }
//            if (!"-1".equals(expTypeId)) {
//                LambdaQueryWrapper<Apply> wrapper = new LambdaQueryWrapper<>();
//                wrapper.eq(Apply::getTypeId, expTypeId).select(Apply::getId);
//                List<Apply> applies = applyService.getBaseMapper().selectList(wrapper);
//                if (!applies.isEmpty()) {
//                    List<Integer> collect = applies.stream().map(Apply::getId).collect(Collectors.toList());
//                    w.in(Signup::getApplyId, collect);
//                }
//            }
//            signupService.getBaseMapper().selectPage(pageInfo, w);
//            List<Signup> records = pageInfo.getRecords();
//            if (!records.isEmpty()) {
//                pageInfo.getRecords().forEach(item -> {
//                    if (Objects.nonNull(item.getApply())) {
//                        item.getApply().setApplyUser(userService.getById(item.getApply().getApplyUserId()));
//                    }
//                    item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId()));
//                });
//            }
//        } else {
        signupService.selectItemDataByOtherInfo(pageInfo, id, expTypeId, search, params);
        List<Signup> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setExpLabRecord(expLabRecordService.getById(item.getLabRecordId())));
        }
//        }
        return r.put("data", pageInfo);
    }


    @GetMapping("/getExpType")
    @ResponseBody
    public R getApplyType() {
        return R.ok().put("data", expTypeService.list());
    }


    @GetMapping("/exportToExcel")
    public void exportToExcel(@RequestParam(value = "applyId", defaultValue = "-1", required = false) String applyId,
                              @RequestParam(value = "expTypeId", defaultValue = "-1", required = false) String expTypeId,
                              HttpServletResponse response) throws IOException {
        if ("-1".equals(applyId)) {
            applyId = null;
        }
        if ("-1".equals(expTypeId)) {
            expTypeId = null;
        }
        List<ItemDataExportDto> rows = applyService.getExportToExcelData(applyId, expTypeId);
        // 通过工具类创建writer，默认创建xls格式
        ExcelWriter writer = ExcelUtil.getWriter(true);
        // 一次性写出内容，使用默认样式，强制输出标题
        if (!rows.isEmpty()) {
            rows.forEach(item -> item.setStatus(SignUpType.ADMIN_PASS.getDesc()));
            writer.write(rows, true);
        }
        //response为HttpServletResponse对象
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String filename = "分项数据导出";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // 关闭writer，释放内存
        writer.close();
        //此处记得关闭输出Servlet流
        IoUtil.close(out);
    }
}
