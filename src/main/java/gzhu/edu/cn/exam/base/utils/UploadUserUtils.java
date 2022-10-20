package gzhu.edu.cn.exam.base.utils;


import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 批量导入用户 处理excel标签信息
 * 
 * @author Administrator
 *
 */
public class UploadUserUtils {

	public static List<User> getUsers(String fileName, String defaultUrl) {
		List<User> users = new ArrayList<User>();
		try {
			if (fileName.indexOf(".xlsx") != -1) {
				// 1、获取文件输入流
				InputStream inputStream = new FileInputStream(fileName);
				// 2、获取Excel工作簿对象
				XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
				// 3、得到Excel工作表对象
				XSSFSheet sheetAt = workbook.getSheetAt(0);
				// 4、循环读取表格数据
				for (Row row : sheetAt) {
					// 首行（即表头）不读取
					if (row.getRowNum() == 0) {
						continue;
					}
					// 读取当前行中单元格数据，索引从0开始
					if(row.getCell(1)!=null){
						row.getCell(1).setCellType(CellType.STRING);
						String username = row.getCell(1).getStringCellValue();
						User user = new User();
						user.setUsername(username);
						if(row.getCell(2)!=null){
							row.getCell(2).setCellType(CellType.STRING);
							String realName = row.getCell(2).getStringCellValue();
							user.setRealName(realName);
						}
						if(row.getCell(3)!=null){
							row.getCell(3).setCellType(CellType.STRING);
							String sex = row.getCell(3).getStringCellValue();
							user.setGender(sex);
						}
						if(row.getCell(4)!=null){
							row.getCell(4).setCellType(CellType.STRING);
							String email = row.getCell(4).getStringCellValue();
							user.setEmail(email);
						}
						if(row.getCell(5)!=null){
							row.getCell(5).setCellType(CellType.STRING);
							String tel = row.getCell(5).getStringCellValue();
							user.setTel(tel);
						}
						if(row.getCell(6)!=null){
							row.getCell(6).setCellType(CellType.STRING);
							String weichat = row.getCell(6).getStringCellValue();
							user.setWeichat(weichat);
						}
						BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
						user.setPassword(bc.encode("123456"));

						//角色
						if(row.getCell(7)!=null){
							row.getCell(7).setCellType(CellType.STRING);
							String roleNames = row.getCell(7).getStringCellValue();
							if(roleNames!=null&&roleNames.length()>0){
								String userEditRoleSel="";
								String[] rs = roleNames.split(";");
								for (String r:rs){
									Role role = new Role();
									if (r.equals("超级管理员")){
										userEditRoleSel = userEditRoleSel+ "1,";
									}else if (r.equals("管理员")){
										userEditRoleSel = userEditRoleSel+ "2,";
									}
									else if (r.equals("教师")){
										userEditRoleSel = userEditRoleSel+ "3,";
									}
									else if (r.equals("主试")){
										userEditRoleSel = userEditRoleSel+ "4,";
									}
									else if (r.equals("被试")){
										userEditRoleSel = userEditRoleSel+ "5,";
									}else {
										userEditRoleSel = userEditRoleSel+ "6,";
									}
								}
								user.setUserEditRoleSel(userEditRoleSel);
							}
						}
						users.add(user);
					}
				}
				// 5、关闭流
				workbook.close();
			}

			else {
				// 1、获取文件输入流
				InputStream inputStream = new FileInputStream(fileName);
				// 2、获取Excel工作簿对象
				HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
				// 3、得到Excel工作表对象
				HSSFSheet sheetAt = workbook.getSheetAt(0);
				// 4、循环读取表格数据
				for (Row row : sheetAt) {
					// 首行（即表头）不读取
					if (row.getRowNum() == 0) {
						continue;
					}
					// 读取当前行中单元格数据，索引从0开始
					if(row.getCell(1)!=null){
						row.getCell(1).setCellType(CellType.STRING);
						String username = row.getCell(1).getStringCellValue();
						User user = new User();
						user.setUsername(username);
						if(row.getCell(2)!=null){
							row.getCell(2).setCellType(CellType.STRING);
							String realName = row.getCell(2).getStringCellValue();
							user.setRealName(realName);
						}
						if(row.getCell(3)!=null){
							row.getCell(3).setCellType(CellType.STRING);
							String sex = row.getCell(3).getStringCellValue();
							user.setGender(sex);
						}
						if(row.getCell(4)!=null){
							row.getCell(4).setCellType(CellType.STRING);
							String email = row.getCell(4).getStringCellValue();
							user.setEmail(email);
						}
						if(row.getCell(5)!=null){
							row.getCell(5).setCellType(CellType.STRING);
							String tel = row.getCell(5).getStringCellValue();
							user.setTel(tel);
						}
						if(row.getCell(6)!=null){
							row.getCell(6).setCellType(CellType.STRING);
							String weichat = row.getCell(6).getStringCellValue();
							user.setWeichat(weichat);
						}
						BCryptPasswordEncoder bc = new BCryptPasswordEncoder(4);
						user.setPassword(bc.encode("123456"));

						//角色
						if(row.getCell(7)!=null){
							row.getCell(7).setCellType(CellType.STRING);
							String roleNames = row.getCell(7).getStringCellValue();
							if(roleNames!=null&&roleNames.length()>0){
								String userEditRoleSel="";
								String[] rs = roleNames.split(";");
								for (String r:rs){
									Role role = new Role();
									if (r.equals("超级管理员")){
										userEditRoleSel = userEditRoleSel+ "1,";
									}else if (r.equals("管理员")){
										userEditRoleSel = userEditRoleSel+ "2,";
									}
									else if (r.equals("教师")){
										userEditRoleSel = userEditRoleSel+ "3,";
									}
									else if (r.equals("主试")){
										userEditRoleSel = userEditRoleSel+ "4,";
									}
									else if (r.equals("被试")){
										userEditRoleSel = userEditRoleSel+ "5,";
									}else {
										userEditRoleSel = userEditRoleSel+ "6,";
									}
								}
								user.setUserEditRoleSel(userEditRoleSel);
							}
						}
						users.add(user);
					}
				}
				// 5、关闭流
				workbook.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return users;
	}
}
