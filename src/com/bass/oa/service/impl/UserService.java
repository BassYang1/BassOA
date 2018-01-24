package com.bass.oa.service.impl;

import java.util.Date;
import java.util.UUID;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.exception.enums.AuthorizationExEnum;
import com.bass.oa.mapper.UserMapper;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.service.IUserService;

@Scope("prototype")
@Service
public class UserService extends BaseService implements IUserService {	
	@Value("${enabled.login.count.limit ?: false}")
	private boolean _enabledCountLimit;	

	@Value("${login.count.limit ?: 0}")
	private int _countLimit;	

	@Value("${login.token.days ?: 1}")
	private int _tokenDays;

	@Value("${encrypt.salt ?: }")
	private String _encryptSalt;
	
	@Autowired
	private UserMapper _userMapper;

	/*
	 * 获取修改密码验证码
	 */
	/*@Cacheable(value="userCache", key="'getCaptcha4Pwd:' + #user.getUserName()")
	public String getCaptcha4Pwd(UserModel user){
		return AppUtil.getRandomNum(4);
	}*/
	@Override
	public String getCaptcha4Pwd(String email){
		String captcha = null;
		String key = String.format("getCaptcha4Pwd:%s", email);
		CacheManager cacheManager = CacheManager.newInstance();
		Cache cache = cacheManager.getCache("oaCache");
		
		Element cacheItem = cache.get(key);
		if(cacheItem != null && cacheItem.getObjectValue() != null){
			captcha = (String)cacheItem.getObjectValue();
		}
		
		if(StringUtils.isEmpty(captcha)){
			captcha = AppUtil.getRandomNum(4);
			cacheItem = new Element(key, captcha, 1200, 1200);
			cache.put(cacheItem);
		}
		
		return captcha;
	}
	
	/*
	 * 根据Token获取用户详细
	 */
	@Override
	public UserModel getUserByToken(String token) {
		if (StringUtils.isBlank(token)) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_TOKEN);
		}

		UserModel user = _userMapper.getUserByToken(token);

		if (user == null) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_TOKEN);
		}

		if (user.isEnabled() == false) {
			throw new AuthorizationException(AuthorizationExEnum.DISABLED_USER);
		}

		//用户密文
		String series = encryptSeries(user.getUserName(), user.getExpiredDate());

		if (StringUtils.isEmpty(user.getSeries()) || !user.getSeries().equals(series)) {
			throw new AuthorizationException(AuthorizationExEnum.EXPIRED_TOKEN);
		}

		return user;
	}

	/*
	 * 根据User email获取用户详细
	 */
	@Override
	public UserModel getUserByEmail(String email) {
		if (StringUtils.isBlank(email)) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_EMAIL);
		}

		UserModel user = _userMapper.getUserByEmail(email);

		if (user == null) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_EMAIL);
		}

		if (user.isEnabled() == false) {
			throw new AuthorizationException(AuthorizationExEnum.DISABLED_USER);
		}

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
	@Override
	public UserModel login(UserLoginModel model) {		
		if (model == null || StringUtils.isEmpty(model.getUserName())
				|| StringUtils.isEmpty(model.getPassword())) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_INFO);
		}

		UserModel user = model.convertToUserModel();
		user = _userMapper.getUserByUserName(user);

		// 验证用户名是否有效
		if (user == null) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_USERNAME);
		}

		if (user.isEnabled() == false) {
			throw new AuthorizationException(AuthorizationExEnum.DISABLED_USER);
		}

		// 验证是否超过登录次数限制
		if (_enabledCountLimit
				&& isOverCountLimit(user.getLoginDate(), user.getLoginCount())) {
			throw new AuthorizationException(AuthorizationExEnum.OVER_LOGIN_LIMIT);
		}

		// 验证登录密码是否有效
		String password = encryptPassword(model.getUserName(),
				model.getPassword());
		if (!password.equals(user.getPassword())) {
			// 更新登录次数
			user.setLoginCount(user.getLoginCount() + 1);
			user.setLoginDate(new Date());
			_userMapper.updateLoginLimit(user);

			throw new AuthorizationException(AuthorizationExEnum.INVALID_PASSWORD);
		}

		// 过期时间
		Date expiredDate = DateUtils.addDays(new Date(), _tokenDays);
		// 登录token
		String token = makeToken(model.getUserName());
		// 登录有效密文
		String series = encryptSeries(model.getUserName(), expiredDate);

		// 更新用户
		user.setExpiredDate(expiredDate);
		user.setToken(token);
		user.setSeries(series);
		user.setLoginDate(new Date());
		_userMapper.updateLoginUser(user);

		return user;
	}

	/*
	 * 用户登出
	 */
	@Override
	public void logout(int userId){
		_userMapper.updateLogoutUser(userId);
	}
	/*
	 * 更新用户
	 */
	@Override
	public void updateUser(UserModel user) {
	}


	/*
	 * 更新用户密码
	 */
	@Override
	public void updatePassword(UserModel user, String newPassword) {
		if (user == null || StringUtils.isEmpty(newPassword)) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_INFO);
		}

		_userMapper.updatePassword(user.getUserId(), encryptPassword(user.getUserName(), newPassword));
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
	
	/*
	 * 加密用户密码
	 */
	private String encryptPassword(String userName, String password){
		if(StringUtils.isEmpty(userName)){
			throw new AuthorizationException(AuthorizationExEnum.INVALID_USERNAME);
		}
		
		return AppUtil.sha256Hex(String.format("%s%s", userName, password));
	}
	
	/*
	 * 加密用户密文序列
	 */
	private String encryptSeries(String userName, Date expiredDate){
		if(StringUtils.isEmpty(userName)){
			throw new AuthorizationException(AuthorizationExEnum.INVALID_USERNAME);
		}
		
		return AppUtil.sha256Hex(String.format("%s%s%s", userName, AppUtil.formatDateTime(expiredDate), _encryptSalt));
	}

	/*
	 * 生成授权令牌
	 */
	private String makeToken(String userName){
		if(StringUtils.isEmpty(userName)){
			throw new AuthorizationException(AuthorizationExEnum.INVALID_USERNAME);
		}
		
		return AppUtil.base64Encode(String.format("%s%s%s", userName, Constant.SEPARATE_USER_TOKEN, UUID.randomUUID().toString()));
	}
}
