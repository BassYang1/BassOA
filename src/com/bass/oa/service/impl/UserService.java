package com.bass.oa.service.impl;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

public class UserService extends BaseService implements IUserService {	
	/*
	 * 获取当前登录用户
	 */
	@Override
	public UserModel getCurrentUser() {
		return (UserModel)getContext().getSession().getAttribute(LOGINED_USER);
	}

	/*
	 * 根据Token获取用户详细
	 */
	@Override
	public UserModel getUserByToken(String token) {
		if(token == null || token.isEmpty()){
			return null;
		}
		
		UserModel user = new UserModel();
		user.setUserId(1);
		user.setUserName("test user");
		user.setUserToken(token);
		return user;
	}

	/*
	 * 根据User Id获取用户详细
	 */
	@Override
	public UserModel getUserById(int id) {
		UserModel user = new UserModel();
		user.setUserId(id);
		user.setUserName("test user");
		return user;
	}

	/*
	 * 更新用户
	 */
	@Override
	public boolean updateUser(UserModel user) {
		return false;
	}
}
