package com.bass.oa.service.impl;

import java.util.Date;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.mapper.UserMapper;
import com.bass.oa.model.MyResult;
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

	@Value("${encrypt.salt ?: }")
	private String _encryptSalt;
	
	private final static Logger _logger = Logger.getLogger(UserService.class);
	
	@Autowired
	private UserMapper _userMapper;

	/*
	 * 根据Token获取用户详细
	 */
	@Override
	public MyResult<UserModel> getUserByToken(String token) {
		MyResult<UserModel> result = new MyResult<UserModel>();
		
		if(StringUtils.isBlank(token)){
			return result;
		}
		
		UserModel user = _userMapper.getUserByToken(token);
		
		if(user == null){
			result.setMessage(_context.getMessage("oa.login.token.invalid"));
			return result;
		}
		
		if(user.isEnabled() == false){
			result.setMessage(_context.getMessage("Invalid.user.account"));
			return result;
		}
		
		String series = String.format("%s%s%s", user.getUserName(), AppUtil.formatDateTime(user.getExpiredDate()), _encryptSalt);
		series = AppUtil.sha256Hex(series); //编码
		
		if(StringUtils.isEmpty(user.getSeries()) || !user.getSeries().equals(series)){
			result.setMessage(_context.getMessage("oa.login.token.expired"));
			return result;
		}
		
		result = new MyResult<UserModel>(true, user);		
		return result;
	}

	/*
	 * 根据User email获取用户详细
	 */
	@Override
	public MyResult<UserModel> getUserByEmail(String email) {
		MyResult<UserModel> result = new MyResult<UserModel>();
		
		if(StringUtils.isBlank(email)){
			return result;
		}
		
		UserModel user = _userMapper.getUserByEmail(email);
		
		if(user == null){
			result.setMessage(_context.getMessage("Email.user.email"));
			return result;
		}
		
		if(user.isEnabled() == false){
			result.setMessage(_context.getMessage("Invalid.user.account"));
			return result;
		}

		result = new MyResult<UserModel>(true, user);		
		return result;
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
	public MyResult<UserModel> login(UserLoginModel model) {
		MyResult<UserModel> result = new MyResult<UserModel>();
		
		if (model == null || StringUtils.isEmpty(model.getUserName())
				|| StringUtils.isEmpty(model.getPassword())) {
			return result;
		}

		try {
			UserModel user = model.convertToUserModel();
			user = _userMapper.getUserByUserName(user);

			// 验证用户名是否有效
			if (user == null) {
				result.setMessage(_context.getMessage("user.login.userName.invalid"));
				return result;
			}

			if(user.isEnabled() == false){
				result.setMessage(_context.getMessage("oa.login.user.invalid"));
				return result;
			}
			
			// 验证是否超过登录次数限制
			if (_enabledCountLimit && isOverCountLimit(user.getLoginDate(), user.getLoginCount())) {
				result.setMessage(_context.getMessage("user.login.count.limit"));
				return result;
			}

			// 验证登录密码是否有效
			String password = AppUtil.sha256Hex(String.format("%s%s",
					model.getUserName(), model.getPassword()));
			if (!password.equals(user.getPassword())) {
				// 更新登录次数
				user.setLoginCount(user.getLoginCount() + 1);
				user.setLoginDate(new Date());
				_userMapper.updateLoginLimit(user);

				result.setMessage(_context.getMessage("user.login.password.invalid"));
				return result;
			}

			// 过期时间
			Date expiredDate = DateUtils.addDays(new Date(), _tokenDays);
			// 登录token
			String token = String.format("%s%s%s", model.getUserName(), Constant.SEPARATE_USER_TOKEN, UUID.randomUUID().toString());
			// 登录有效密文
			String series = String.format("%s%s%s", model.getUserName(), AppUtil.formatDateTime(expiredDate), _encryptSalt);

			// 更新用户
			user.setExpiredDate(expiredDate);
			user.setToken(AppUtil.base64Encode(token));
			user.setSeries(AppUtil.sha256Hex(series));
			user.setLoginDate(new Date());
			_userMapper.updateLoginUser(user);
			
			result = new MyResult<UserModel>(true, user);			
			return result;
		} catch (Exception ex) {
			_logger.error(ex);
			result.setMessage(ex.getMessage());
			return result;
		}
	}

	/*
	 * 用户登出
	 */
	public void logout(int userId){
		_userMapper.updateLogoutUser(userId);
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
