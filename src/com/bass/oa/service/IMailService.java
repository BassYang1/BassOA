package com.bass.oa.service;

import com.bass.oa.model.MyResult;

public interface IMailService {
	public MyResult<Boolean> sendSimpleText(String[] recipients, String project, String content);
}
