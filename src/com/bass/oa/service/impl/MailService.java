package com.bass.oa.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.bass.oa.model.MyResult;
import com.bass.oa.service.IMailService;

public class MailService extends BaseService implements IMailService {
	private final static Logger _log = Logger.getLogger(MailService.class);
	
	@Value("${mail.from ?: yjdhmm@sina.com}")
	private String _from;	
	
	@Autowired
	private JavaMailSender _mailSender;
	
	
	@Override
	public MyResult<Boolean> sendSimpleText(String[] recipients, String subject, String content) {
		MyResult<Boolean> myResult = new MyResult<Boolean>(false, false);
		
		if(StringUtils.isBlank(_from)){
			myResult.setMessage("发送人不能为空");
			return myResult;
		}		

		if(recipients == null || recipients.length <= 0){
			myResult.setMessage("接收人不能为空");
			return myResult;
		}
		
		try{
			SimpleMailMessage message = new SimpleMailMessage ();
			message.setFrom(_from);
			message.setTo(recipients);
			message.setSubject(subject);
			message.setText(content);
			_mailSender.send(message);
		}
		catch(MailException ex){
			_log.error(ex);
			myResult.setMessage(ex.getMessage());
			return myResult;
		}
				
		myResult = new MyResult<Boolean>(true, true);
		return myResult;
	}

}
