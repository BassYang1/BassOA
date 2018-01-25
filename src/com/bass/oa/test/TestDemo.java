package com.bass.oa.test;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.apache.log4j.Appender;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;

import com.bass.oa.enums.UserGender;
import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.exception.enums.AuthorizationExEnum;

public class TestDemo {
	private static Logger LOGGER = LogManager.getLogger(TestDemo.class);

	public static void main(String[] args) throws MessagingException{
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

		/*String pattern = "[1]%-10p - [2]%10p - [3]%.3p  - [4]%-10.4p - [5]%10.3p 。 %n"; // 运行程序看看，是不是我们期待的日志输出样子
		pattern = "[%d{yyyy-MM-dd HH:mm:ss:SSS}] [%-5p] [method:%l]%n%m%n%n";
		Layout layout = new PatternLayout(pattern);
		Appender appender = new ConsoleAppender(layout);
		BasicConfigurator.configure(appender);
		LOGGER.info("test");*/
		

        /*Random rand = new Random(1111111111);
        
        for(int i = 0; i < 5; i++){
            System.out.print(rand.nextInt(10));
        }
        
        System.out.println();

        rand = new Random(System.currentTimeMillis());
        for(int i = 0; i < 4; i++){
            System.out.print(rand.nextInt(9));
        }
        
        System.out.println();*/

		/*Properties props = new Properties();
		
	    // 邮件发送协议 
        props.setProperty("mail.transport.protocol", "smtp"); 
        // SMTP邮件服务器 
        props.setProperty("mail.smtp.host", "smtp.sina.com"); 
        // SMTP邮件服务器默认端口 
        props.setProperty("mail.smtp.port", "25"); 
        // 是否要求身份认证 
        props.setProperty("mail.smtp.auth", "true"); 
        // 是否启用调试模式（启用调试模式可打印客户端与服务器交互过程时一问一答的响应消息） 
        props.setProperty("mail.debug", "true"); 
        
        // 创建Session实例对象 
		Session session = Session.getDefaultInstance(props);		

        // 创建MimeMessage实例对象 
        MimeMessage message = new MimeMessage(session); 
        
        // 设置发件人 
        message.setFrom(new InternetAddress("xxxxxxx@sina.com")); 
        // 设置邮件主题 
        message.setSubject("使用javamail发送简单文本邮件"); 
        // 设置收件人 
        message.setRecipient(RecipientType.TO, new InternetAddress("xxxxx@163.com")); 
        // 设置发送时间 
        message.setSentDate(new Date()); 
        // 设置纯文本内容为邮件正文 
        message.setText("使用POP3协议发送文本邮件测试!!!"); 
        // 保存并生成最终的邮件内容 
        message.saveChanges(); 
        
        // 获得Transport实例对象 
        Transport transport = session.getTransport(); 
        // 打开连接 
        transport.connect("xxxxxxx@sina.com", "password");  
        // 将message对象传递给transport对象，将邮件发送出去 
        transport.sendMessage(message, message.getAllRecipients()); 
        // 关闭连接 
        transport.close(); */
		
		 //System.out.println(new AuthorizationException(AuthorizationExEnum.EXPIRED_TOKEN));
		
		int gender = UserGender.MALE.ordinal();
		System.out.println(gender);
		System.out.println(UserGender.MALE);
		System.out.println(UserGender.MALE.name());
		System.out.println(UserGender.MALE.toString());
		

		UserGender userGender = UserGender.values()[0];
		System.out.println(userGender);
		System.out.println(UserGender.valueOf("MALE"));
	}
}
