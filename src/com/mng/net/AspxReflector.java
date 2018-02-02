package com.mng.net;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class AspxReflector {
	public static void main(String[] args) throws IOException {
		bindBehindFile4Aspx("G:\\Projects\\ff\\Iphone");
	}

	public static void bindBehindFile4Aspx(String basePath) throws IOException {
		if (basePath == null || basePath == "") {
			System.out.println("无效的文件路径.");
			return;
		}

		// 遍历文件
		File file = new File(basePath);

		if (!file.exists()) {
			System.out.println("文件路径不存在.");
			return;
		}

		File[] list = file.listFiles();

		for (File srcFile : list) {
			if (srcFile.isDirectory()) {
				bindBehindFile4Aspx(srcFile.getPath());
			} else {
				String filePath = srcFile.getPath();
				String fileName = srcFile.getName();

				if (fileName.endsWith(".aspx") == false) {
					continue;
				}

				System.out.println("页面文件: " + filePath);

				String parClass = getInherits(filePath).trim();
				
				if(parClass == ""){
					continue;
				}
				
				String[] paths = parClass.split("\\.");
				String csPath = "";
				
				if(paths.length == 3){
					csPath = "G:\\Projects\\ff\\Iphone\\Lottery.IPhone\\" + paths[1] + "\\" + paths[2] + ".cs";
				}
				else if(paths.length == 2){
						csPath = "G:\\Projects\\ff\\Iphone\\Lottery.IPhone\\" + paths[0] + "\\" + paths[1] + ".cs";
					}
				else if(paths.length == 4){
					csPath = "G:\\Projects\\ff\\Iphone\\Lottery.IPhone\\" + paths[1] + "\\" + paths[2] + "\\" + paths[3] + ".cs";
				}

				File csFile = new File(csPath);
				if (csPath == "" || !csFile.exists()) {
					continue;
				}

				System.out.println("查找到文件: " + csPath);
				
				filePath = filePath.replace(fileName, "");
				String tarPath = filePath + fileName + ".cs";
				
				makeFile(csPath, tarPath, fileName.replace(".aspx", ""));				
				System.out.println("生成文件" + tarPath);
			}

			continue;
		}
	}

	@SuppressWarnings("resource")
	public static String getInherits(String aspxPath) {
		try {
			InputStream is = new FileInputStream(aspxPath);
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(is));

			String str = null;
			while (true) {
				str = reader.readLine();

				if (str == null)
					break;

				if (str.contains("Inherits=")) {
					is.close();
					int start = str.indexOf("Inherits=\"") + "Inherits=\"".length();
					int end = str.indexOf("\"", start);
					return str.substring(start, end);
				}
			}

			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}
	
	public static void makeFile(String srcPath, String tarPath, String fileName) {

		try {
			String target = "public class " + fileName;
			String newContent = "public partial class " + fileName;

			File srcFile = new File(srcPath);
			
			InputStream is = new FileInputStream(srcPath);
			BufferedReader reader = new BufferedReader(new InputStreamReader(is));

			BufferedWriter writer = new BufferedWriter(new FileWriter(tarPath));

			String str = null;
			while (true) {
				str = reader.readLine();

				if (str == null)
					break;

				if (str.contains(target)) {
					writer.write(str.replace(target,newContent) + "\n");
				} else
					writer.write(str + "\n");
			}

			is.close();

			writer.flush();
			writer.close();
			srcFile.delete();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
