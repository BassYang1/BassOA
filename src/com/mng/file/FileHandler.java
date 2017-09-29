package com.mng.file;

import java.util.ArrayList;
import java.util.List; 
import java.io.File;
import java.text.SimpleDateFormat;

public class FileHandler {
	private int count;
	private String date;
	private SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
	private String prefix;
	private List renamedFiles = new ArrayList();
	
	public FileHandler(String prefix){
		this.prefix = prefix;
	}
	
	public void setPrefix(String prefix){
		this.prefix = prefix;
	}
	
	public void RenameFile(String path){
		if(path.isEmpty()){
			System.out.println("无效的文件路径.");
			return;
		}
		
		//遍历文件
		File file = new File(path);
		
		if(!file.exists()){
			System.out.println("文件路径不存在.");
			return;
		}
		
		File[] list = file.listFiles();
		for(File srcFile : list){
			if(srcFile.isDirectory()){
				RenameFile(srcFile.getPath());
			}
			else{
				String idxNum;
				String newName;
				String oldName = srcFile.getName();
				String extName = oldName.substring(oldName.lastIndexOf(".") + 1); //文件扩展名
				String tmpDate = fmt.format(srcFile.lastModified());
				File descFile;
				
				if(!tmpDate.equals(date)){
					date = tmpDate;
					count = 0;
				}
				
				do{
					idxNum = "00000" + String.valueOf(++count);
					idxNum = idxNum.substring(idxNum.length() - 3);
					newName = String.format("%s\\%s%s%s.%s",path, prefix, date, idxNum, extName);
					descFile = new File(newName);
				} while(descFile.exists() || renamedFiles.contains(newName));
				
				renamedFiles.add(newName);
				
				srcFile.renameTo(descFile);
				System.out.println(newName);
				//break;
			}
		}
	}
}
