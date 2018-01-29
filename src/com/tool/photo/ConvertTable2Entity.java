package com.tool.photo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;

/*
 * 转换table到entity/model
 */
public class ConvertTable2Entity {
	// JDBC 驱动名及数据库 URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/oa";
	static final String USER = "root";
	static final String PASS = "111111";

	public static void main(String[] args) {
		String tableName = "tbDepartment";
		String modelName = "DepartmentModel";
		String pgName = "com.bass.oa.model.po";
		String basePg = "com.bass.oa.model";
		String baseCls = "BaseModel";
		String targetPath = "F:\\pros";
		Connection conn = null;
		Statement stmt = null;

		try {
			// 创建存储路径和Model文件 --Start
			File targetFile = new File(targetPath);
			if(targetFile.exists() == false){
				targetFile.mkdir();
			}
			
			String[] pgs = pgName.split("\\.");
			for(String pg : pgs){
				targetPath = targetPath + "\\" + pg;
				targetFile = new File(targetPath);
				
				if(targetFile.exists() == false){
					targetFile.mkdir();
				}
			}
			
			targetPath = targetPath + "\\" + modelName + ".java";
			targetFile = new File(targetPath);

			targetFile.delete();
			targetFile.createNewFile();
			// 创建存储路径和Model文件 --end

			// 生成文件内容 --Start
	        StringBuffer fileContent = new StringBuffer();
	        StringBuffer fileHeader = new StringBuffer();
	        StringBuffer fileFooter = new StringBuffer("}");

	        //包名和引用类名
	        fileHeader.append("package " + pgName + ";");
	        fileHeader.append("\n");
	        fileHeader.append("\n");
	        fileHeader.append("import " + basePg + "." + baseCls + ";");
	        fileHeader.append("\n");

	        //model字段
	        fileContent.append("\n");
	        fileContent.append("public class " + modelName + " extends " + baseCls);
	        fileContent.append("\n");
	        fileContent.append("{");
	        fileContent.append("\n");

			// 注册 JDBC 驱动
			Class.forName(JDBC_DRIVER);

			// 连接数据库
			conn = (Connection) DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = (Statement) conn.createStatement();
			ResultSet rs = (ResultSet) stmt.executeQuery("desc " + tableName + ";");

			// 展开结果集数据库
			while (rs.next()) {
				String type = rs.getString("Type");
				
				if(type.startsWith("int")){
					type = "int";
				}
				else if(type.startsWith("varchar")){
					type = "String";
				}
				else if(type.startsWith("text")){
					type = "String";
				}
				else if(type.startsWith("datetime")){
					type = "Date";
					
					if(fileHeader.indexOf("import java.util.Date;") < 0){
				        fileHeader.append("import java.util.Date;");
				        fileHeader.append("\n");
					}
				}
				
				String name = rs.getString("Field");
		        fileContent.append("\tprivate " + type + " " + name + ";");
		        fileContent.append("\n");
		        fileContent.append("\n");
		        fileContent.append("\tpublic void set" + name.substring(0, 1).toUpperCase() + name.substring(1) + "(" + type + " " + name + ")");
		        fileContent.append("\n");
		        fileContent.append("\t{");
		        fileContent.append("\n");
		        fileContent.append("\t\tthis." + name + " = " + name + ";");
		        fileContent.append("\n");
		        fileContent.append("\t}");
		        fileContent.append("\n");
		        fileContent.append("\n");

		        fileContent.append("\tpublic " + type + " get" + name.substring(0, 1).toUpperCase() + name.substring(1) + "()");
		        fileContent.append("\n");
		        fileContent.append("\t{");
		        fileContent.append("\n");
		        fileContent.append("\t\treturn this." + name + ";");
		        fileContent.append("\n");
		        fileContent.append("\t}");
		        fileContent.append("\n");
		        fileContent.append("\n");
		        
				// 输出数据
				System.out.print("字段名: " + rs.getString("Field"));
				System.out.print("\t");
				System.out.print("字段类型: " + rs.getString("Type"));
				System.out.println();
			}
			
            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
			// 生成文件内容 --End

			// 生成文件 --Start
	        FileWriter fw = new FileWriter(targetFile, true);
	        BufferedWriter bw = new BufferedWriter(fw);
	        bw.write(fileHeader.toString());
	        bw.write(fileContent.toString());
	        bw.write(fileFooter.toString());
	        bw.flush();
	        bw.close();
	        fw.close();	   
			// 生成文件 --End     
		} catch (Exception e) {
			// 处理 Class.forName 错误
			e.printStackTrace();
		} finally {
			// 关闭资源
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			}// 什么都不做

			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

		System.out.println("Goodbye!");
	}
}
