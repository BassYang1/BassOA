package com.bass.oa.mapper;

import com.bass.oa.model.po.UserModel;

public interface UserMapper {
	public UserModel getUserByUserName(UserModel entity);
	public UserModel getUserByToken(String token);
	public void updateLoginLimit(UserModel entity);
	public void updateLoginUser(UserModel entity);
}
