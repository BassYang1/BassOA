package com.bass.oa.service.impl;

import java.util.Date;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.mapper.UserMapper;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.service.IUserService;

public class UserService extends BaseService implements IUserService {	
	@Value("${enabled.login.count.limit ?: false}")
	private boolean _enabledCountLimit;	

	@Value("${login.count.limit ?: 0}")
	private int _countLimit;	

	@Value("${login.token.days ?: 1}")
	private int _tokenDays;

	@Value("${encrypt.salt ?: ''}")
	private String _encryptSalt;
	
	@Autowired
	private UserMapper _userMapper;

	/*
	 * 根据Token获取用户详细
	 */
	@Override
	public UserModel getUserByToken(String token) {
		if(StringUtils.isBlank(token)){
			return null;
		}
		
		return _userMapper.getUserByToken(token);
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
		if (model == null || StringUtils.isEmpty(model.getUserName())
				|| StringUtils.isEmpty(model.getPassword())) {
			return null;
		}

		try {
			UserModel user = model.convertToUserModel();
			user = _userMapper.getUserByUserName(user);

			// 验证用户名是否有效
			if (user == null) {
				_context.setI18nError("user.login.userName.invalid");
				return null;
			}

			// 验证是否超过登录次数限制
			if (_enabledCountLimit && isOverCountLimit(user.getLoginDate(), user.getLoginCount())) {
				_context.setI18nError("user.login.count.limit");
				return null;
			}

			// 验证登录密码是否有效
			String password = AppUtil.sha256Hex(String.format("%s%s",
					model.getUserName(), model.getPassword()));
			if (!password.equals(user.getPassword())) {
				_context.setI18nError("user.login.password.invalid");

				// 更新登录次数
				user.setLoginCount(user.getLoginCount() + 1);
				user.setLoginDate(new Date());
				_userMapper.updateLoginLimit(user);

				return null;
			}

			// 过期时间
			Date expiredDate = DateUtils.addDays(new Date(), _tokenDays);
			// 登录token
			String token = String.format("%s%s%s", model.getUserName(), Constant.USER_TOKEN_SEPARATE, UUID.randomUUID().toString());
			// 登录有效密文
			String series = String.format("%s%s%s%s", model.getUserName(), model.getPassword(), AppUtil.formatDateTime(expiredDate), _encryptSalt);

			// 更新用户
			user.setExpiredDate(expiredDate);
			user.setToken(AppUtil.base64Encode(token));
			user.setSeries(AppUtil.sha256Hex(series));
			user.setLoginDate(new Date());
			_userMapper.updateLoginUser(user);
			
			return user;
		} catch (Exception ex) {
			_context.setError(ex.getMessage());
			return null;
		}
	}

	/*
	 * 更新用户
	 */
	@Override
	public boolean updateUser(UserModel user) {
		return false;
	}
	
	/*
	 * 检查登录失败次数
	 */
	private boolean isOverCountLimit(Date loginDate, int loginCount) {
		if (loginDate == null) {
			return false;
		}

		return _enabledCountLimit && _countLimit > 0
				&& DateUtils.isSameDay(loginDate, new Date())
				&& loginCount >= _countLimit;
	}
}
