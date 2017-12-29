package com.bass.oa.test;

import org.apache.log4j.Appender;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;

public class TestDemo {
	private static Logger LOGGER = LogManager.getLogger(TestDemo.class);
	
	public static void main(String[] args){
		/*Pattern pattern = Pattern.compile("Windows (?!95|98|NT|2000)");
		Matcher matcher = pattern.matcher("Windows XP");

		if(matcher.find()){
			System.out.println(matcher.group(0));
			System.out.println(matcher.group(1));
		}*/
		/*while(matcher.find()){
			System.out.println(matcher.group());
		}*/	
		
		/*System.out.println(StringUtils.isNotBlank("Windows XP"));
		System.out.println(StringUtils.isNoneBlank("Windows XP"));
		System.out.println(StringUtils.isAllBlank("Windows XP"));
		System.out.println(StringUtils.isNotEmpty("Windows XP"));
		System.out.println(StringUtils.isNotEmpty(null));
		System.out.println(StringUtils.isNotEmpty(""));
		System.out.println(StringUtils.isNotEmpty(" "));
		System.out.println(StringUtils.isNotBlank(null));
		System.out.println(StringUtils.isNotBlank(""));
		System.out.println(StringUtils.isNotBlank(" "));
		System.out.println(ObjectUtils.anyNotNull(null));
		System.out.println(ObjectUtils.anyNotNull(new UserModel()));
		System.out.println(ObjectUtils.anyNotNull(null));*/
		

		/*System.out.println(AppUtil.sha256Hex("admin"));
		System.out.println(AppUtil.sha256Hex("admin" + ""));
		
		System.out.println(AppUtil.sha256Hex("123456"));
		System.out.println(AppUtil.sha256Hex("123456").length());
		System.out.println(AppUtil.sha256Hex("aa"));
		System.out.println(AppUtil.sha256Hex("aa").length());
		System.out.println(AppUtil.sha1Hex("123456"));
		System.out.println(AppUtil.sha1Hex("123456").length());
		System.out.println(AppUtil.sha1Hex("aa"));
		System.out.println(AppUtil.sha1Hex("aa").length());
		System.out.println(AppUtil.md5Hex("123456"));
		System.out.println(AppUtil.md5Hex("123456").length());
		System.out.println(AppUtil.md5Hex("aa"));
		System.out.println(AppUtil.md5Hex("aa").length());*/
		

		/*System.out.println(AppUtil.sha256Hex("adminadmin"));*/

		String pattern = "[1]%-10p - [2]%10p - [3]%.3p  - [4]%-10.4p - [5]%10.3p 。 %n"; // 运行程序看看，是不是我们期待的日志输出样子
		pattern = "[%d{yyyy-MM-dd HH:mm:ss:SSS}] [%-5p] [method:%l]%n%m%n%n";
		Layout layout = new PatternLayout(pattern);
		Appender appender = new ConsoleAppender(layout);
		BasicConfigurator.configure(appender);
		LOGGER.info("test");
	}
}
