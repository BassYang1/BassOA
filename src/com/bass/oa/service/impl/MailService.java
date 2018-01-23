package com.bass.oa.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.bass.oa.service.IMailService;

public class MailService extends BaseService implements IMailService {	
	@Value("${mail.from ?: yjdhmm@sina.com}")
	private String _from;	
	
	@Autowired
	private JavaMailSender _mailSender;
	
	@Override
	public void sendSimpleText(String[] recipients, String subject, String content) throws Exception {
		if (StringUtils.isBlank(_from)) {
			throw new Exception("发送人不能为空");
		}

		if (recipients == null || recipients.length <= 0) {
			throw new Exception("收件人不能为空");
		}

		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(_from);
		message.setTo(recipients);
		message.setSubject(subject);
		message.setText(content);
		_mailSender.send(message);
	}
}
