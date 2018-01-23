package com.bass.oa.service;

import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.model.MyResult;

public interface IUserService {

	/*
	 * 获取修改密码验证码
	 */
	public String getCaptcha4Pwd(String email);
	
	/*
	 * 根据Token获取用户详细
	 */
	public MyResult<UserModel> getUserByToken(String token);
	
	/*
	 * 根据User Id获取用户详细
	 */
	public UserModel getUserById(int id);	

	/*
	 * 根据User email获取用户详细
	 */
	public MyResult<UserModel> getUserByEmail(String email);	

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
	
	/*
	 * 更新用户密码
	 */
	public MyResult<Boolean> updatePassword(UserModel user, String newPassword);
}
