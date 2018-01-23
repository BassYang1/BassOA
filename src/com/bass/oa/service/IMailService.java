package com.bass.oa.service;

public interface IMailService {
	public void sendSimpleText(String[] recipients, String project, String content) throws Exception;
}
