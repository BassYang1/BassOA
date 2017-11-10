package com.bass.oa.service;

import com.bass.oa.model.UserModel;

public interface IUserService {
	public final static String LOGINED_USER = "LOGINED_USER";

	/*
	 * 获取当前登录用户
	 */
	public UserModel getCurrentUser();
	
	/*
	 * 根据Token获取用户详细
	 */
	public UserModel getUserByToken(String token);
	
	/*
	 * 根据User Id获取用户详细
	 */
	public UserModel getUserById(int id);	

	/*
	 * 更新用户
	 */
	public boolean updateUser(UserModel user);
}
