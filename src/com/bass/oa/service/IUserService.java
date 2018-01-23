package com.bass.oa.service;

import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;

public interface IUserService {

	/*
	 * 获取修改密码验证码
	 */
	public String getCaptcha4Pwd(String email);
	
	/*
	 * 根据Token获取用户详细
	 */
	public UserModel getUserByToken(String token);
	
	/*
	 * 根据User Id获取用户详细
	 */
	public UserModel getUserById(int id);	

	/*
	 * 根据User email获取用户详细
	 */
	public UserModel getUserByEmail(String email);	

	/*
	 * 用户登录
	 */
	public UserModel login(UserLoginModel model);

	/*
	 * 用户登出
	 */
	public void logout(int userId);
	
	/*
	 * 更新用户
	 */
	public void updateUser(UserModel user);
	
	/*
	 * 更新用户密码
	 */
	public void updatePassword(UserModel user, String newPassword);
}
