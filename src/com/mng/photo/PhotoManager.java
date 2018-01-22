package com.mng.photo;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributeView;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileOwnerAttributeView;

import org.apache.commons.io.FileUtils;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;

public class PhotoManager {
	private final SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");

	private String sourcePath;
	private String cameraPath ;
	private String otherPath;
	private String prefix;
	private String suffix;
	private int count;
	private String date;
	private List<String> renamedFiles = new ArrayList<String>();
	
	public PhotoManager(String sourcePath, String cameraPath, String otherPath, String prefix, String suffix, boolean createdFolder){
		this.sourcePath = sourcePath;
		this.cameraPath = cameraPath;
		this.otherPath = otherPath;
		this.prefix = prefix;
		this.suffix = suffix;

		//创建保存路径
		mkdirs(cameraPath, createdFolder);
		mkdirs(otherPath, createdFolder);
	}
	
	public static void main(String[] args) throws JpegProcessingException, IOException {
		String basePath = "G:\\Photo";
		String prefix = "YWJ";
		String suffix = "";
		
		//录入文件信息
		/*Scanner input = new Scanner(System.in);
		
		System.out.println("请输入文件前缀...");
		prefix = input.nextLine();
		System.out.println(String.format("文件前缀:%s", prefix));		
		System.out.println("请输入文件后缀...");
		suffix = input.nextLine();
		System.out.println(String.format("文件后缀:%s", suffix));*/	

		
		//照片路径
		String sourcePath = String.format("%s\\test", basePath);
		System.out.println(String.format("文件路径:%s", sourcePath));
		
		if(sourcePath.isEmpty()){
			System.out.println("无效的文件路径.");
			System.exit(0);
		}

		String cameraPath = String.format("%s\\FromCamera", basePath);
		String otherPath = String.format("%s\\FromOther", basePath);
		
		PhotoManager handler = new PhotoManager(sourcePath, cameraPath, otherPath, prefix, suffix, true);
		
		//更新图片
		handler.updatePhotos();
		//handler.printFileMeta("G:\\photo\\test\\IMG_20171007_190942 (3).jpg");
		//handler.printFileNio("G:\\photo\\test\\IMG_20171007_190942 (3).jpg");
	}
	
	/*
	 * 更新图片
	 */
	public void updatePhotos() throws JpegProcessingException, IOException{
		rename(this.sourcePath);
	}
	
	/*
	 * 创建目录
	 * @dirName:目录名
	 * @deleted:若已存在，是否强制删除
	 */
	public void mkdirs(String dirName, boolean deleted) {
		File dir = new File(dirName);

		if (deleted || dir.exists() == false) {
				dir.delete();
				dir.mkdir();
		} 
	}

	public void rename(String path) throws JpegProcessingException, IOException {
		if (path == null || path == "") {
			System.out.println("无效的文件路径.");
			return;
		}

		// 遍历文件
		File file = new File(path);

		if (!file.exists()) {
			System.out.println("文件路径不存在.");
			return;
		}

		File[] list = file.listFiles();
		
		for (File srcFile : list) {
			if (srcFile.isDirectory()) {
				rename(srcFile.getPath());
			} else {
				String idxNum;
				String newName;
				// 原始文件名
				String oldName = srcFile.getName();
				// 文件扩展名
				String extName = oldName.substring(oldName.lastIndexOf(".") + 1);
				//图片拍摄时间
				String oriDate = getOriginalDate(srcFile);
				//图片来自相机拍摄
				boolean fromCamera = oriDate != null && oriDate.length() >= 8;				
				//取图片最后修改时间
				oriDate = fromCamera ? oriDate : fmt.format(srcFile.lastModified());
				//图片年份
				String year = oriDate != null && oriDate.length() >= 4? oriDate.substring(0, 4) : null;
				//图片保存位置
				String storePath = fromCamera ? cameraPath : otherPath;
				
				if(year != null && year != ""){
					storePath = String.format("%s\\%s", storePath, year);
				}
				
				//创建存储目录
				mkdirs(storePath, false);
				
				File descFile;

				if (!oriDate.equals(date)) {
					date = oriDate;
					count = 0;
				}

				do {
					idxNum = "00000" + String.valueOf(++count);
					idxNum = idxNum.substring(idxNum.length() - 3);
					newName = String.format("%s\\%s%s%s%s.%s", storePath, prefix, date, idxNum, suffix, extName);
					descFile = new File(newName);
				} while (descFile.exists() || renamedFiles.contains(newName));

				renamedFiles.add(newName);
				FileUtils.copyFile(srcFile, descFile);
				//srcFile.renameTo(descFile);
				System.out.println(newName);
				// break;
			}
		}
	}

	public String getOriginalDate(File file) {
		Metadata metadata;
		
		try {
			metadata = JpegMetadataReader.readMetadata(file);

			Iterator<Directory> it = metadata.getDirectories().iterator();
			while (it.hasNext()) {
				Directory exif = it.next();
				
				if ("ExifSubIFDDirectory".equalsIgnoreCase(exif.getClass()
						.getSimpleName())) {
					String time2 = null;
					String time1 = null;

					time1 = exif.getString(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);
					if (time1 != null && time1 != "") {
						time2 = time1.replace(":", "");
						return time2.substring(0, 8);
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
	
	public void printFileMeta(String path) {
		if(path == null || path == ""){
			return;
		}
		
		File file = new File(path);
		
		if(file.exists() == false){
			return;
		}
				
		try {
			Metadata metadata = JpegMetadataReader.readMetadata(file);
			Iterator<Directory> it = metadata.getDirectories().iterator();
			
			while (it.hasNext()) {
				Directory meta = it.next();

				if ("ExifSubIFDDirectory".equalsIgnoreCase(meta.getClass().getSimpleName())) {
					System.out.println(String.format("DateTime:%s", meta.getString(ExifSubIFDDirectory.TAG_DATETIME)));
					System.out.println(String.format("Original DateTime:%s", meta.getString(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL)));

					String time1 = meta.getString(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);
					if (time1 != null && time1 != "") {
						System.out.println(String.format("Original Date:%s",  time1.replace(":", "").substring(0, 8)));
					}
					
					System.out.println(String.format("Digitized DateTime:%s", meta.getString(ExifSubIFDDirectory.TAG_DATETIME_DIGITIZED)));
				}
			}
			
		} catch (JpegProcessingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	
	
	public void printFileNio(String filePath) throws IOException {
		if(filePath == null || filePath == ""){
			return;
		}
		

        Path path = Paths.get(filePath);		

        BasicFileAttributeView basicView = Files.getFileAttributeView(path, BasicFileAttributeView.class);
        BasicFileAttributes basicFileAttributes = basicView.readAttributes();

        System.out.println("创建时间：" + new Date(basicFileAttributes.creationTime()
                .toMillis()));

        System.out.println("最后访问时间：" + new Date(basicFileAttributes.
                lastAccessTime().toMillis()));

        System.out.println("最后修改时间：" + new Date(basicFileAttributes.
                lastModifiedTime().toMillis()));

        System.out.println("文件大小：" + basicFileAttributes.size());

        FileOwnerAttributeView ownerView = Files.getFileAttributeView(path, 
                FileOwnerAttributeView.class);

        System.out.println("文件所有者：" + ownerView.getOwner());

	}	
}
