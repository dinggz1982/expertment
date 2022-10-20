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
 * 主页导入模板与批量上传用户
 *
 * @author Yinglei Jie on 2021/12/16
 */
@Slf4j
@Controller
@RequestMapping("/index/user/")
@Transactional(rollbackFor = Exception.class)
public class UserExportController {

    private static final String USER_NAME = "学号/工号";

    private static final String PASSWORD = "密码";

    private static final String REAL_NAME = "真实姓名";

    private static final String IDENTITY = "身份";

    private static final String ROLE = "角色";

    private static final String SCHOOL = "学校";

    private static final String COLLEGE = "学院";

    private static final String MAJOR = "专业";

    private static final String CLASS = "班级";


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
        //response为HttpServletResponse对象
        ExcelWriter writer = ExcelUtil.getWriter(true);
        List<String> row = new ArrayList<>(Arrays.asList(USER_NAME, PASSWORD, REAL_NAME, IDENTITY, ROLE, SCHOOL, COLLEGE, MAJOR, CLASS));
        row.addAll(expTypeMapper.getTypeNameList());
        writer.writeRow(row);
        Sheet sheet = writer.getSheet();
        setValidationData(sheet, IdentityEnum.getNameList(), 1, 500, 3, 3);
        setValidationData(sheet, roleService.getNameList(), 1, 500, 4, 4);
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "用户导入模板";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // 关闭writer，释放内存
        writer.close();
        //此处记得关闭输出Servlet流
        IoUtil.close(out);
    }


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
                //已经存在用户名的列表
                List<String> existList = new ArrayList<>();
                readAll.forEach(item -> {
                    // 处理逻辑
                    // 保存基础用户
                    User user = new User();
                    String username = String.valueOf(item.get(USER_NAME));
                    if (Objects.isNull(username) || username.isEmpty()) {
                        throw new RuntimeException(USER_NAME + "不能为空!");
                    }
                    User findByUsername = userService.findByName(username);
                    if (Objects.nonNull(findByUsername)) {
                        //用户名已存在，
                        existList.add(username);
                        return;
                    }
                    user.setUsername(username);
                    String password = String.valueOf(item.get(PASSWORD));
                    if (Objects.isNull(password) || password.isEmpty()) {
                        throw new RuntimeException(PASSWORD + "不能为空!");
                    }
                    user.setPassword(BC.encode(password));
                    user.setRealName(String.valueOf(item.get(REAL_NAME)));
                    String identity = String.valueOf(item.get(IDENTITY));
                    if (Objects.nonNull(identity) && !identity.isEmpty()) {
                        boolean b = IdentityEnum.checkName(identity);
                        if (!b) {
                            throw new RuntimeException("表格包含非法身份信息");
                        }
                        user.setIdentity(identity);
                    }
                    //保存学校信息
                    String schoolName = (String) item.get(SCHOOL);
                    String collegeName = (String) item.get(COLLEGE);
                    String majorName = (String) item.get(MAJOR);
                    String className = (String) item.get(CLASS);
                    ClassAllInfoDto dto = schoolMapper.getClassAllInfoByName(schoolName, collegeName, majorName, className);
                    if (Objects.nonNull(dto)) {
                        //信息不为空
                        user.setSchoolId(dto.getSchoolId());
                        user.setCollegeId(dto.getCollegeId());
                        user.setMajorId(dto.getMajorId());
                        user.setClassId(dto.getClassId());
                    }
                    userService.save(user);
                    // 保存用户角色
                    String roleName = String.valueOf(item.get(ROLE));
                    if (Objects.nonNull(roleName) && !roleName.isEmpty()) {
                        Role role = roleService.getRoleByName(roleName);
                        if (Objects.isNull(role)) {
                            throw new RuntimeException("角色数据有误");
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
                    UserExistException e = new UserExistException("excel文件存在重复的用户名");
                    e.setExistList(existList);
                    throw e;
                }
                return R.ok("导入成功");
            } else {
                return R.error("请忽导入空的excel文件");
            }
        } catch (DuplicateKeyException e) {
            log.error("用户导入发生异常，异常信息为：{}", e.getMessage(), e);
            throw new RuntimeException("存在重复用户名");
        } catch (NumberFormatException e) {
            log.error("用户导入发生异常，异常信息为：{}", e.getMessage(), e);
            throw new RuntimeException("学分格式不正确");
        } catch (UserExistException e) {
            throw e;
        } catch (Exception e) {
            log.error("用户导入发生异常，异常信息为：{}", e.getMessage(), e);
            throw new RuntimeException("系统发生异常,请联系技术人员");
        }
    }

    @GetMapping("/exportToExcel")
    public void exportToExcel(HttpServletResponse response) throws Exception {
        List<UserExportToExcelVo> list = userService.exportUserToExcel();
        ExcelWriter writer = ExcelUtil.getWriter(true);
        writer.write(list, true);
        response.setContentType(EXCEL_CONTENT_TYPE);
        String filename = "用户数据";
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8") + ".xlsx");
        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        // 关闭writer，释放内存
        writer.close();
        //此处记得关闭输出Servlet流
        IoUtil.close(out);
    }
}
