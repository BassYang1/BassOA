package com.bass.oa.service;

import com.bass.oa.model.UserModel;

public interface IUserService {
	public final static String LOGINED_USER = "LOGINED_USER";

	/*
	 * 获取当前登录用户
	 */
	public UserModel getCurrentUser();
}
