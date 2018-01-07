package com.bass.oa.core;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

public class AppUtil {
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
	public static String formatDateTime(Date dateTime, String format){
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
	public static String formatDateTime(Date dateTime){
		return formatDateTime(dateTime, FORMAT_DATE_TIME);
	}

	/*
	 * 日期格式化
	 */
	public static String formatDate(Date dateTime){
		return formatDateTime(dateTime, FORMAT_DATE);
	}

	/*
	 * 时间格式化
	 */
	public static String formatTime(Date dateTime){
		return formatDateTime(dateTime, FORMAT_TIME);
	}

	/*
	 * 系统日期时间
	 */
	public static String sysDateTime(){
		return formatDateTime(new Date());		
	}

	/*
	 * 系统日期
	 */
	public static String sysDate(){
		return formatDate(new Date());		
	}
	
	/*
	 * 系统时间
	 */
	public static String sysTime(){
		return formatTime(new Date());		
	}
	
	/*
	 * 字符串是否为空
	 */
	public static boolean isEmptyOrNull(String value){
		return value == "" || value == null;
	}
	
	/**
     * Base64 encode
     * */
    public static String base64Encode(String data){
        return Base64.encodeBase64String(data.getBytes());
    }
     
    /**
     * Base64 decode
     * @throws UnsupportedEncodingException 
     * */
    public static String base64Decode(String data) throws UnsupportedEncodingException{
        return new String(Base64.decodeBase64(data.getBytes()),"utf-8");
    }
    
	/**
     * md5
     * */
    public static String md5Hex(String data){
        return DigestUtils.md5Hex(data);
    }
     
    /**
     * sha1
     * */
    public static String sha1Hex(String data){
        return DigestUtils.sha1Hex(data);
    }
     
    /**
     * sha256
     * */
    public static String sha256Hex(String data){
        return DigestUtils.sha256Hex(data);
    }
    
    /*
     * 验证邮箱
     */
    public static boolean checkEmail(String val){
    	if(StringUtils.isEmpty(val)){
    		return false;
    	}
    	
    	Pattern pattern = Pattern.compile("^\\w|\\.+@\\w+\\.\\w+$");
    	Matcher matcher = pattern.matcher(val);
    	
    	return matcher.find();    	
    }
}
