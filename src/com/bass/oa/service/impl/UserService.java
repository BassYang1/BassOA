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

	/*
	 * 根据User Id获取用户详细
	 */
	@Override
	public UserModel getUserById(int id) {		
		return null;
	}

	/*
	 * 更新用户
	 */
	@Override
	public boolean updateUser(UserModel user) {
		return false;
	}

}
