package com.mng.photo;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import com.drew.imaging.jpeg.JpegProcessingException;
import com.mng.file.FileHandler;

public class PhotoManager {
	private final static String DIR_TO_CAMERA = "FromCamera";
	private final static String DIR_TO_OTHERS = "FromApp";
	private final static String DIR_FROM_SOURCE = "test";
	
	public static void main(String[] args) throws JpegProcessingException, IOException {
		//录入文件信息
		String prefix = "YWJ";
		String basePath = "G:\\photo";
		Scanner input = new Scanner(System.in);
		
		System.out.println("请输入文件前缀...");
		//prefix = input.nextLine();
		System.out.println(String.format("文件前缀:%s", prefix));
		
		System.out.println("请输入文件前缀...");

		String path = String.format("%s\\%s", basePath, DIR_FROM_SOURCE);
		System.out.println(String.format("文件路径:%s", path));
		
		if(path.isEmpty()){
			System.out.println("无效的文件路径.");
			System.exit(0);
		}
		
		FileHandler handler = new FileHandler();
		handler.mkdirs(String.format("%s\\%s", basePath, DIR_TO_CAMERA));
		handler.mkdirs(String.format("%s\\%s", basePath, DIR_TO_OTHERS));
		
		//更新文件名
		handler.setPrefix(prefix);
		handler.RenameFile(path);	
	}
}
