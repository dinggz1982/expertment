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
 * ?????????????????????????????????
 *
 * @author Yinglei Jie on 2021/12/11
 */
@Slf4j
@Controller
@RequestMapping("/experiment/instrument/")
public class InstrumentManageController {
    private static final String ID = "??????";
    private static final String NAME = "????????????";
    private static final String LAB = "???????????????";
    private static final String ADDRESS = "????????????";
    private static final String TEACHER1 = "????????????1";
    private static final String TEACHER2 = "????????????2";
    private static final String TEACHER3 = "????????????3";
    private static final String DESCRIPTION = "????????????";
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
     * ????????????????????????????????????????????????,???????????????.
     *
     * @param sheet    ????????????sheet.
     * @param textlist ????????????????????????
     * @param firstRow ?????????
     * @param endRow   ?????????
     * @param firstCol ?????????
     * @param endCol   ?????????
     * @return ????????????sheet.
     */
    public static Sheet setValidationData(Sheet sheet,
                                          String[] textlist, int firstRow, int endRow, int firstCol,
                                          int endCol) {
        DataValidationHelper dataValidationHelper = sheet.getDataValidationHelper();
        // ????????????????????????
        DataValidationConstraint explicitListConstraint = dataValidationHelper.createExplicitListConstraint(textlist);
        // ????????????????????????????????????????????????,?????????????????????????????????????????????????????????????????????
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // ?????????????????????
        DataValidation validation = dataValidationHelper.createValidation(explicitListConstraint, regions);
        validation.setSuppressDropDownArrow(true);
//        validation.createErrorBox("tip", "????????????????????????");
        //???????????????
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
            throw new RuntimeException("????????????");
        }
        expInstrumentService.updateById(exp);
        return R.ok("????????????");
    }

    @PostMapping("/saveInstrument")
    @ResponseBody
    public R saveInstrument(@RequestBody @Validated ExpInstrument exp) {
        expInstrumentService.saveInstrument(exp);
        return R.ok("????????????");
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
        return R.ok("????????????");
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
                    // ????????????
                    String id = String.valueOf(item.get("??????"));
                    String name = String.valueOf(item.get("????????????"));
                    if (Objects.isNull(name) || name.isEmpty()) {
                        throw new RuntimeException("?????????" + id + "????????????????????????!");
                    }
                    instrument.setName(name);
                    String t1 = String.valueOf(item.get("????????????1"));
                    if (Objects.isNull(t1) || t1.isEmpty()) {
                        throw new RuntimeException("?????????" + id + "????????????1????????????!");
                    }
                    User findByUsername = userService.findByRealName(t1);
                    if (findByUsername == null) {
                        throw new RuntimeException("?????????" + id + "????????????1??????????????????????????????!");
                    }
                    instrument.setTeacher1(t1);
                    String labName = String.valueOf(item.get("???????????????"));
                    if (Objects.isNull(labName) || labName.isEmpty()) {
                        throw new RuntimeException("?????????" + id + "???????????????????????????!");
                    }

                    Lab lab = labService.getByName(labName);
                    if (lab == null) {
                        throw new RuntimeException("?????????" + id + "?????????????????????" + labName + "????????????????????????!");
                    }
                    instrument.setLabId(String.valueOf(lab.getId()));
                    instrument.setLabName(labName);
                    String t2 = String.valueOf(item.get("????????????2"));
                    if (t2 == null) {
                        instrument.setTeacher2("");
                    } else {
                        instrument.setTeacher2(t2);
                    }
                    String t3 = String.valueOf(item.get("????????????3"));
                    if (t3 == null) {
                        instrument.setTeacher3("");
                    } else {
                        instrument.setTeacher3(t3);
                    }
                    String address = String.valueOf(item.get("????????????"));
                    if (Objects.isNull(address) || address.isEmpty()) {
                        throw new RuntimeException("?????????" + id + "????????????????????????!");
                    }
                    instrument.setAddress(address);
                    String description = String.valueOf(item.get("????????????"));
                    instrument.setDescription(description);
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    instrument.setAddTime(df.format(new Date()));
                    instruments.add(instrument);
                });
                this.expInstrumentService.saveBatch(instruments);
                return R.ok("????????????");
            } else {
                return R.error("??????????????????excel??????");
            }
        } catch (Exception e) {
            log.error("?????????????????????????????????????????????{}", e.getMessage(), e);
            throw new RuntimeException("??????????????????,?????????????????????");
        }
    }

    @GetMapping("/getFile")
    public void getFile(HttpServletResponse response) throws Exception {
        //response???HttpServletResponse??????
        ExcelWriter writer = ExcelUtil.getWriter(true);
        List<String> row = new ArrayList<>(Arrays.asList(ID, NAME, LAB, ADDRESS, TEACHER1, TEACHER2, TEACHER3, DESCRIPTION));
        //row.addAll(expTypeMapper.getTypeNameList());
        writer.writeRow(row);
        Sheet sheet = writer.getSheet();
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "????????????????????????";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // ??????writer???????????????
        writer.close();
        //????????????????????????Servlet???
        IoUtil.close(out);
    }
}
