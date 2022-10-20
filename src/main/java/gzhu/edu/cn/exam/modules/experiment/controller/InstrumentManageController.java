package gzhu.edu.cn.exam.modules.experiment.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpInstrument;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.enums.IdentityEnum;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpTypeMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentService;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.organization.dto.ClassAllInfoDto;
import gzhu.edu.cn.exam.modules.system.entity.ItsUserRole;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.exception.UserExistException;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Instrument;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 实验仪器管理前端控制器
 *
 * @author Yinglei Jie on 2021/12/11
 */
@Slf4j
@Controller
@RequestMapping("/experiment/instrument/")
public class InstrumentManageController {
    private static final String ID = "序号";
    private static final String NAME = "仪器名称";
    private static final String LAB = "所属实验室";
    private static final String ADDRESS = "存放地点";
    private static final String TEACHER1 = "负责教师1";
    private static final String TEACHER2 = "负责教师2";
    private static final String TEACHER3 = "负责教师3";
    private static final String DESCRIPTION = "仪器描述";
    private static final String EXCEL_CONTENT_TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8";
    @Resource
    private IUserService userService;
    @Resource
    private ExpInstrumentService expInstrumentService;
    @Resource
    private ILabService labService;
    @Resource
    private ExpTypeMapper expTypeMapper;

    /**
     * 设置某些列的值只能输入预制的数据,显示下拉框.
     *
     * @param sheet    要设置的sheet.
     * @param textlist 下拉框显示的内容
     * @param firstRow 开始行
     * @param endRow   结束行
     * @param firstCol 开始列
     * @param endCol   结束列
     * @return 设置好的sheet.
     */
    public static Sheet setValidationData(Sheet sheet,
                                          String[] textlist, int firstRow, int endRow, int firstCol,
                                          int endCol) {
        DataValidationHelper dataValidationHelper = sheet.getDataValidationHelper();
        // 加载下拉列表内容
        DataValidationConstraint explicitListConstraint = dataValidationHelper.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        DataValidation validation = dataValidationHelper.createValidation(explicitListConstraint, regions);
        validation.setSuppressDropDownArrow(true);
//        validation.createErrorBox("tip", "请从下拉列表选取");
        //错误警告框
        validation.setShowErrorBox(true);
        sheet.addValidationData(validation);
        return sheet;
    }

    @GetMapping({"/", "/index"})
    public String index() {
        return "modules/experiment/instrument";
    }

    @PostMapping("/updateInstrument")
    @ResponseBody
    public R updateInstrument(@RequestBody @Validated ExpInstrument exp) {
        if (Objects.isNull(exp.getId())) {
            throw new RuntimeException("非法参数");
        }
        expInstrumentService.updateById(exp);
        return R.ok("修改成功");
    }

    @PostMapping("/saveInstrument")
    @ResponseBody
    public R saveInstrument(@RequestBody @Validated ExpInstrument exp) {
        expInstrumentService.saveInstrument(exp);
        return R.ok("添加成功");
    }

    @GetMapping("/getInstrumentList")
    @ResponseBody
    public R getInstrumentList(@RequestParam(required = false) String name,
                               @RequestParam(defaultValue = "1", required = false) Integer page,
                               @RequestParam(defaultValue = "10", required = false) Integer limit) {
        IPage<ExpInstrument> pageInfo = new Page<>(page, limit);
        LambdaQueryWrapper<ExpInstrument> w = new LambdaQueryWrapper<>();
        if (Objects.nonNull(name) && !name.isEmpty()) {
            w.like(ExpInstrument::getName, name);
        }
        w.orderByDesc(ExpInstrument::getId);
        return R.ok().put("data", expInstrumentService.getBaseMapper().selectPage(pageInfo, w));
    }

    @GetMapping("/del/{id}")
    @ResponseBody
    public R del(@PathVariable String id) {
        expInstrumentService.getBaseMapper().deleteById(id);
        return R.ok("删除成功");
    }

    @PostMapping("/upload")
    @ResponseBody
    public R upload(@RequestParam("file") MultipartFile file) {
        try {
            InputStream inputStream = file.getInputStream();
            ExcelReader reader = ExcelUtil.getReader(inputStream);
            List<Map<String, Object>> readAll = reader.readAll();
            List<ExpInstrument> instruments = new ArrayList<>();
            if (!readAll.isEmpty()) {
                readAll.forEach(item -> {
                    ExpInstrument instrument = new ExpInstrument();
                    // 处理逻辑
                    String id = String.valueOf(item.get("序号"));
                    String name = String.valueOf(item.get("仪器名称"));
                    if (Objects.isNull(name) || name.isEmpty()) {
                        throw new RuntimeException("序号：" + id + "仪器名称不能为空!");
                    }
                    instrument.setName(name);
                    String t1 = String.valueOf(item.get("负责教师1"));
                    if (Objects.isNull(t1) || t1.isEmpty()) {
                        throw new RuntimeException("序号：" + id + "负责教师1不能为空!");
                    }
                    User findByUsername = userService.findByRealName(t1);
                    if (findByUsername == null) {
                        throw new RuntimeException("序号：" + id + "负责教师1还未录入到用户系统中!");
                    }
                    instrument.setTeacher1(t1);
                    String labName = String.valueOf(item.get("所属实验室"));
                    if (Objects.isNull(labName) || labName.isEmpty()) {
                        throw new RuntimeException("序号：" + id + "所属实验室不能为空!");
                    }

                    Lab lab = labService.getByName(labName);
                    if (lab == null) {
                        throw new RuntimeException("序号：" + id + "，实验室名字：" + labName + "还未录入到系统中!");
                    }
                    instrument.setLabId(String.valueOf(lab.getId()));
                    instrument.setLabName(labName);
                    String t2 = String.valueOf(item.get("负责教师2"));
                    if (t2 == null) {
                        instrument.setTeacher2("");
                    } else {
                        instrument.setTeacher2(t2);
                    }
                    String t3 = String.valueOf(item.get("负责教师3"));
                    if (t3 == null) {
                        instrument.setTeacher3("");
                    } else {
                        instrument.setTeacher3(t3);
                    }
                    String address = String.valueOf(item.get("存放地点"));
                    if (Objects.isNull(address) || address.isEmpty()) {
                        throw new RuntimeException("序号：" + id + "存放地点不能为空!");
                    }
                    instrument.setAddress(address);
                    String description = String.valueOf(item.get("仪器描述"));
                    instrument.setDescription(description);
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    instrument.setAddTime(df.format(new Date()));
                    instruments.add(instrument);
                });
                this.expInstrumentService.saveBatch(instruments);
                return R.ok("导入成功");
            } else {
                return R.error("请忽导入空的excel文件");
            }
        } catch (Exception e) {
            log.error("仪器导入发生异常，异常信息为：{}", e.getMessage(), e);
            throw new RuntimeException("系统发生异常,请联系技术人员");
        }
    }

    @GetMapping("/getFile")
    public void getFile(HttpServletResponse response) throws Exception {
        //response为HttpServletResponse对象
        ExcelWriter writer = ExcelUtil.getWriter(true);
        List<String> row = new ArrayList<>(Arrays.asList(ID, NAME, LAB, ADDRESS, TEACHER1, TEACHER2, TEACHER3, DESCRIPTION));
        //row.addAll(expTypeMapper.getTypeNameList());
        writer.writeRow(row);
        Sheet sheet = writer.getSheet();
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "实验仪器导入模板";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // 关闭writer，释放内存
        writer.close();
        //此处记得关闭输出Servlet流
        IoUtil.close(out);
    }
}
