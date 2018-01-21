package com.mng.file;

import java.util.ArrayList;
import java.util.List; 
import java.io.File;
import java.util.Iterator;
import java.io.IOException;
import java.text.SimpleDateFormat;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Metadata;
import com.drew.metadata.Directory;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifSubIFDDirectory;

//https://www.cnblogs.com/haha12/p/4679644.html
//https://github.com/drewnoakes/metadata-extractor
//http://files.cnblogs.com/files/haha12/readPic.rar

public class FileHandler {
	private int count;
	private String date;
	private SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
	private String prefix;
	private List renamedFiles = new ArrayList();

	public FileHandler(){
	}
	
	public FileHandler(String prefix){
		this.prefix = prefix;
	}
	
	public void setPrefix(String prefix){
		this.prefix = prefix;
	}

	public void mkdirs(String dirName){
		File dir = new File(dirName);
		
        if (dir.exists() == false) {  
        	dir.mkdirs();
        }    
	}
	
	public void RenameFile(String path) throws JpegProcessingException, IOException{
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
					date = getOriginalDate(srcFile);
					date = date == null || date == "" ? tmpDate : date;
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

	private String getOriginalDate(File file) {
        Metadata metadata;
        try {
            metadata = JpegMetadataReader.readMetadata(file);
            Iterator<Directory> it = metadata.getDirectories().iterator();
            while (it.hasNext()) {
                Directory exif = it.next();
                
                if("ExifSubIFDDirectory".equalsIgnoreCase(exif.getClass().getSimpleName() )){
                	String time2 = null;
                	String time1 = exif.getString(ExifSubIFDDirectory.TAG_DATETIME);
                	
                	if(time1 != null && time1 != ""){
	                    time2 = time1.replace( ":","");  
	                    return time2.substring(0, 7);
                	}
                	
                	time1 = exif.getString(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL); 
                	if(time1 != null && time1 != ""){
	                    time2 = time1.replace( ":","");  
	                    return time2.substring(0, 7);
                	}
                }
            }
        } catch (JpegProcessingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    } 
}
