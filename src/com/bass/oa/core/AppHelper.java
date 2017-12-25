package com.bass.oa.core;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AppHelper {
	
	private final static class AppHelperInstanceHolder {
		public static AppHelper _instance = null;
		
		static {
			_instance = new AppHelper();
		}
	}
	
	public static AppHelper getInstance(){
		return AppHelperInstanceHolder._instance;
	}
	
	private AppHelper(){
		
	}
	
	/*
	 * 日期时间格式
	 */
	public final static String FORMAT_DATE_TIME = "yyyy-MM-dd HH:mm:ss";

	/*
	 * 日期格式
	 */
	public final static String FORMAT_DATE = "yyyy-MM-dd";

	/*
	 * 时间格式
	 */
	public final static String FORMAT_TIME = "HH:mm:ss";

	/*
	 * 日期时间格式化
	 */
	public String formatDateTime(Date dateTime, String format){
		SimpleDateFormat fmt = new SimpleDateFormat(format);
		
		if(dateTime == null){
			return "";
		}
		
		try{
			return fmt.format(dateTime);
		}
		catch(Exception e){
			System.out.println(e);
			return "";
		}
	}
	
	/*
	 * 日期时间格式化
	 */
	public String formatDateTime(Date dateTime){
		return formatDateTime(dateTime, FORMAT_DATE_TIME);
	}

	/*
	 * 日期格式化
	 */
	public String formatDate(Date dateTime){
		return formatDateTime(dateTime, FORMAT_DATE);
	}

	/*
	 * 时间格式化
	 */
	public String formatTime(Date dateTime){
		return formatDateTime(dateTime, FORMAT_TIME);
	}

	/*
	 * 系统日期时间
	 */
	public String sysDateTime(){
		return formatDateTime(new Date());		
	}

	/*
	 * 系统日期
	 */
	public String sysDate(){
		return formatDate(new Date());		
	}
	
	/*
	 * 系统时间
	 */
	public String sysTime(){
		return formatTime(new Date());		
	}
	
	/*
	 * 字符串是否为空
	 */
	public boolean isEmptyOrNull(String value){
		return value == "" || value == null;
	}
}
