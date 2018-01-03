package com.bass.oa.service;

import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.model.MyResult;

public interface IUserService {
	/*
	 * 根据Token获取用户详细
	 */
	public MyResult<UserModel> getUserByToken(String token);
	
	/*
	 * 根据User Id获取用户详细
	 */
	public UserModel getUserById(int id);	

	/*
	 * 用户登录
	 */
	public MyResult<UserModel> login(UserLoginModel model);

	/*
	 * 用户登出
	 */
	public void logout(int userId);
	
	/*
	 * 更新用户
	 */
	public boolean updateUser(UserModel user);
}
