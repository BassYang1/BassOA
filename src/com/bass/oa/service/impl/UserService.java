package com.bass.oa.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.bass.oa.mapper.UserMapper;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.service.IUserService;

public class UserService extends BaseService implements IUserService {	
	@Value("${login.limit.count.enabled ?: false}")
	private boolean isEnabledLimitCount;	

	@Value("${login.limit.count ?: 0}")
	private int limitCount;
	
	@Autowired
	private UserMapper _userMapper;
	/*
	 * 获取当前登录用户
	 */
	@Override
	public UserModel getCurrentUser() {
		return (UserModel)_context.getSession().getAttribute(LOGINED_USER);
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
		//user.setUserToken(token);
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
	 * 用户登录
	 */
	public UserModel login(UserLoginModel model) {
		if (model == null || _app.isEmptyOrNull(model.getUserName())
				|| _app.isEmptyOrNull(model.getPassword())) {
			return null;
		}

		String password = model.getPassword();
		UserModel entity = model.convertToUserModel();
		entity = _userMapper.getUserByUserName(entity);
		
		if(entity == null){
			_context.setError(_context.getMessage("user.login.userName.invalid"));
			return null;
		}
		
		//更新登录次数
		entity.setLoginCount(entity.getLoginCount() + 1);
		entity.setLoginDate(new Date());
		
		if(!password.equals(entity.getPassword())){
			_context.setError(_context.getMessage("user.login.password.invalid"));
			_userMapper.updateLoginLimit(entity);
			return null;
		}

		
		
		return entity;
	}

	/*
	 * 更新用户
	 */
	@Override
	public boolean updateUser(UserModel user) {
		return false;
	}
	
	/*private boolean limitLoginCount(){
		PropertiesUtils.
	}*/
}
