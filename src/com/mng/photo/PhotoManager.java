package com.mng.photo;

import java.io.File;
import java.util.Scanner;

import com.mng.file.FileHandler;

public class PhotoManager {

	public static void main(String[] args) {
		//录入文件信息
		String prefix = "WYJ";
		String path = "G:\\photo\\test";
		Scanner input = new Scanner(System.in);
		
		System.out.println("请输入文件前缀...");
		//prefix = input.nextLine();
		System.out.println(String.format("文件前缀:%s", prefix));
		
		System.out.println("请输入文件前缀...");
		//path = input.nextLine();
		//path = "";
		System.out.println(String.format("文件路径:%s", path));
		
		if(path.isEmpty()){
			System.out.println("无效的文件路径.");
			System.exit(0);
		}
		
		FileHandler handler = new FileHandler(prefix);
		handler.RenameFile(path);		
	}

}
