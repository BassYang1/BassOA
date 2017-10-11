package com.bass.oa.service.impl;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

public class UserService extends BaseService implements IUserService {

	/*
	 * 获取当前登录用户
	 */
	@Override
	public UserModel getCurrentUser() {
		return (UserModel)getSession().getAttribute(LOGINED_USER);
	}

}
