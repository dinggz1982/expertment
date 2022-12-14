package gzhu.edu.cn.exam.modules.system.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpApplyHourStatistics;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.enums.IdentityEnum;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpTypeMapper;
import gzhu.edu.cn.exam.modules.experiment.service.IExpApplyHourStatisticsService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import gzhu.edu.cn.exam.modules.organization.dto.ClassAllInfoDto;
import gzhu.edu.cn.exam.modules.organization.mapper.SchoolMapper;
import gzhu.edu.cn.exam.modules.system.entity.ItsUserRole;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.exception.UserExistException;
import gzhu.edu.cn.exam.modules.system.service.IItsUserRoleService;
import gzhu.edu.cn.exam.modules.system.service.IRoleService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import gzhu.edu.cn.exam.modules.system.vo.UserExportToExcelVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.*;

/**
 * ???????????????????????????????????????
 *
 * @author Yinglei Jie on 2021/12/16
 */
@Slf4j
@Controller
@RequestMapping("/index/user/")
@Transactional(rollbackFor = Exception.class)
public class UserExportController {

    private static final String USER_NAME = "??????/??????";

    private static final String PASSWORD = "??????";

    private static final String REAL_NAME = "????????????";

    private static final String IDENTITY = "??????";

    private static final String ROLE = "??????";

    private static final String SCHOOL = "??????";

    private static final String COLLEGE = "??????";

    private static final String MAJOR = "??????";

    private static final String CLASS = "??????";


    private static final BCryptPasswordEncoder BC = new BCryptPasswordEncoder(4);

    private static final String EXCEL_CONTENT_TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8";
    @Resource
    private IUserService userService;

    @Resource
    private ExpTypeMapper expTypeMapper;

    @Resource
    private IExpTypeService expTypeService;

    @Resource
    private IExpApplyHourStatisticsService expApplyHourStatisticsService;

    @Resource
    private IRoleService roleService;

    @Resource
    private IItsUserRoleService itsUserRoleService;

    @GetMapping("/getDemo")
    public void getDemo(HttpServletResponse response) throws Exception {
        //response???HttpServletResponse??????
        ExcelWriter writer = ExcelUtil.getWriter(true);
        List<String> row = new ArrayList<>(Arrays.asList(USER_NAME, PASSWORD, REAL_NAME, IDENTITY, ROLE, SCHOOL, COLLEGE, MAJOR, CLASS));
        row.addAll(expTypeMapper.getTypeNameList());
        writer.writeRow(row);
        Sheet sheet = writer.getSheet();
        setValidationData(sheet, IdentityEnum.getNameList(), 1, 500, 3, 3);
        setValidationData(sheet, roleService.getNameList(), 1, 500, 4, 4);
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "??????????????????";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // ??????writer???????????????
        writer.close();
        //????????????????????????Servlet???
        IoUtil.close(out);
    }


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

    @Resource
    private SchoolMapper schoolMapper;

    @PostMapping("/importUserFromExcel")
    @ResponseBody
    public R importUserFromExcel(@RequestParam("file") MultipartFile file) {
        try {
            InputStream inputStream = file.getInputStream();
            ExcelReader reader = ExcelUtil.getReader(inputStream);
            List<Map<String, Object>> readAll = reader.readAll();
            if (!readAll.isEmpty()) {
                List<ExpType> expTypes = expTypeMapper.selectList(null);
                //??????????????????????????????
                List<String> existList = new ArrayList<>();
                readAll.forEach(item -> {
                    // ????????????
                    // ??????????????????
                    User user = new User();
                    String username = String.valueOf(item.get(USER_NAME));
                    if (Objects.isNull(username) || username.isEmpty()) {
                        throw new RuntimeException(USER_NAME + "????????????!");
                    }
                    User findByUsername = userService.findByName(username);
                    if (Objects.nonNull(findByUsername)) {
                        //?????????????????????
                        existList.add(username);
                        return;
                    }
                    user.setUsername(username);
                    String password = String.valueOf(item.get(PASSWORD));
                    if (Objects.isNull(password) || password.isEmpty()) {
                        throw new RuntimeException(PASSWORD + "????????????!");
                    }
                    user.setPassword(BC.encode(password));
                    user.setRealName(String.valueOf(item.get(REAL_NAME)));
                    String identity = String.valueOf(item.get(IDENTITY));
                    if (Objects.nonNull(identity) && !identity.isEmpty()) {
                        boolean b = IdentityEnum.checkName(identity);
                        if (!b) {
                            throw new RuntimeException("??????????????????????????????");
                        }
                        user.setIdentity(identity);
                    }
                    //??????????????????
                    String schoolName = (String) item.get(SCHOOL);
                    String collegeName = (String) item.get(COLLEGE);
                    String majorName = (String) item.get(MAJOR);
                    String className = (String) item.get(CLASS);
                    ClassAllInfoDto dto = schoolMapper.getClassAllInfoByName(schoolName, collegeName, majorName, className);
                    if (Objects.nonNull(dto)) {
                        //???????????????
                        user.setSchoolId(dto.getSchoolId());
                        user.setCollegeId(dto.getCollegeId());
                        user.setMajorId(dto.getMajorId());
                        user.setClassId(dto.getClassId());
                    }
                    userService.save(user);
                    // ??????????????????
                    String roleName = String.valueOf(item.get(ROLE));
                    if (Objects.nonNull(roleName) && !roleName.isEmpty()) {
                        Role role = roleService.getRoleByName(roleName);
                        if (Objects.isNull(role)) {
                            throw new RuntimeException("??????????????????");
                        }
                        ItsUserRole userRole = new ItsUserRole();
                        userRole.setUserId(user.getId());
                        userRole.setRoleId(role.getId());
                        itsUserRoleService.save(userRole);
                    }
                    if (!expTypes.isEmpty()) {
                        expTypes.forEach(type -> {
                            Object num = item.get(type.getName());
                            if (Objects.nonNull(num)) {
                                ExpApplyHourStatistics statistics = new ExpApplyHourStatistics();
                                statistics.setUserId(user.getId());
                                statistics.setApplyTypeId(type.getId());
                                statistics.setIsBase("1");
                                statistics.setTotalHour(new BigDecimal(String.valueOf(num)));
                                expApplyHourStatisticsService.save(statistics);
                            }
                        });
                    }
                });
                if (!existList.isEmpty()) {
                    UserExistException e = new UserExistException("excel??????????????????????????????");
                    e.setExistList(existList);
                    throw e;
                }
                return R.ok("????????????");
            } else {
                return R.error("??????????????????excel??????");
            }
        } catch (DuplicateKeyException e) {
            log.error("?????????????????????????????????????????????{}", e.getMessage(), e);
            throw new RuntimeException("?????????????????????");
        } catch (NumberFormatException e) {
            log.error("?????????????????????????????????????????????{}", e.getMessage(), e);
            throw new RuntimeException("?????????????????????");
        } catch (UserExistException e) {
            throw e;
        } catch (Exception e) {
            log.error("?????????????????????????????????????????????{}", e.getMessage(), e);
            throw new RuntimeException("??????????????????,?????????????????????");
        }
    }

    @GetMapping("/exportToExcel")
    public void exportToExcel(HttpServletResponse response) throws Exception {
        List<UserExportToExcelVo> list = userService.exportUserToExcel();
        ExcelWriter writer = ExcelUtil.getWriter(true);
        writer.write(list, true);
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "????????????";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // ??????writer???????????????
        writer.close();
        //????????????????????????Servlet???
        IoUtil.close(out);
    }
}
