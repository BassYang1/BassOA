package com.bass.oa.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.exception.enums.AuthorizationExEnum;
import com.bass.oa.model.MyResult;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.PasswordResetModel;
import com.bass.oa.model.vo.UserEditModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.service.IMailService;
import com.bass.oa.service.IUserService;

@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {
	private IUserService _userService;
	
	@Autowired
	private IMailService _mailService;
	
	@Autowired
	public UserController(IUserService userService){
		this._userService = userService;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@RequestParam(value = "error", required = false) String error, Model model) {
		model.addAttribute(Constant.ATTR_ERROR_MSG, error);
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") @Validated UserLoginModel userLoginInfo, BindingResult result, Model model) {
		try {
			if (userLoginInfo == null || result.hasErrors()) {
				throw new AuthorizationException(AuthorizationExEnum.INVALID_LOGIN);
			}

			UserModel user = _userService.login(userLoginInfo);

			if (user == null) {
				throw new AuthorizationException(AuthorizationExEnum.INVALID_LOGIN);
			}

			if (StringUtils.isEmpty(user.getToken())) {
				throw new AuthorizationException(AuthorizationExEnum.UNKNOWN);
			}

			// 添加cookie
			if (userLoginInfo.isRememberme()) {
				_context.addCookie(Constant.COOKIE_USER_TOKEN, user.getToken());
				_context.addCookie(Constant.COOKIE_USER_LOGIN_NAME, user.getUserName());
			}

			// 存储到session中
			_context.getSession().setAttribute(Constant.SESSION_USER, user);

			// 页面跳转
			String callback = _context.getRequest().getParameter(
					Constant.PARAM_LOGIN_CALLBACK);

			if (StringUtils.isNotBlank(callback)) {
				return String.format("redirect:%s", callback);
			}
		} catch (AuthorizationException ex) {
			_logger.error(ex);
			model.addAttribute(Constant.ATTR_ERROR_MSG, ex.getMessage());
			return "login";
		}

		return "redirect:/index.do";
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout() throws UnsupportedEncodingException {
		try {
			UserModel user = (UserModel) _context.getSession().getAttribute(Constant.SESSION_USER);
			int userId = user == null ? 0 : user.getUserId();

			if (userId <= 0) {
				String token = _context.getCookieValue(Constant.COOKIE_USER_TOKEN);

				if (StringUtils.isNotBlank(token)) {
					String userName = AppUtil.base64Decode(token).split(Constant.SEPARATE_USER_TOKEN)[0];
					user = _userService.getUserByToken(token);
					userId = user == null || user.getUserName().equals(userName) ? 0 : user.getUserId();
				}
			}

			if (userId > 0) {
				_userService.logout(userId);
			}

			_context.removeCookie(Constant.COOKIE_USER_TOKEN);
			_context.removeCookie(Constant.COOKIE_USER_LOGIN_NAME);
			_context.getSession().removeAttribute(Constant.SESSION_USER);
			
		} catch (AuthorizationException ex) {
			_logger.error(ex);
		}

		return "redirect:/user/login.do";
	}

	@RequestMapping(value="forgetPwd", method = RequestMethod.GET)
	public ModelAndView forgetPassword(){
		return new ModelAndView("/user/forgetPwd", "password", new PasswordResetModel());
	}

	@RequestMapping(value="forgetPwd", method=RequestMethod.POST)
	public ModelAndView forgetPassword(@ModelAttribute("password") @Validated PasswordResetModel password, BindingResult result, Model model){
		try {
			if (result.hasErrors()) {
				throw new AuthorizationException("验证码验证失败");
			}

			UserModel user = _userService.getUserByEmail(password.getEmail());

			if (user == null) {
				throw new AuthorizationException(AuthorizationExEnum.INVALID_EMAIL);
			}

			if (password.getCaptcha().equals(
					_userService.getCaptcha4Pwd(password.getEmail())) == false) {
				throw new AuthorizationException("验证码已过期");
			}

			if (password.getPassword().equals(password.getCfmPassword()) == false) {
				throw new AuthorizationException("新密码和确认密码不一致");
			}

			_userService.updatePassword(user, password.getPassword());

		} catch (AuthorizationException ex) {
			_logger.error(ex);
			model.addAttribute(Constant.ATTR_ERROR_MSG, ex.getMessage());
			return new ModelAndView("/user/forgetPwd", "password", password);
		}
		
		return new ModelAndView("redirect:/user/login.do");
	}
	
	@RequestMapping(value="sendCaptcha4Pwd", method = RequestMethod.POST)
	public @ResponseBody String sendCaptcha4Pwd(String email){
		try {
			if (StringUtils.isEmpty(email) || !AppUtil.checkEmail(email)) {
				throw new AuthorizationException(AuthorizationExEnum.INVALID_EMAIL);
			}

			// 查找用户
			UserModel user = _userService.getUserByEmail(email);

			if (user == null) {
				throw new AuthorizationException(AuthorizationExEnum.INVALID_EMAIL);
			}

			// 生成验证码
			String captcha = _userService.getCaptcha4Pwd(email);
			_mailService.sendSimpleText(new String[] { email }, "修改密码验证码", String.format("你的验证码是%s", captcha));

		} catch (AuthorizationException ex) {
			_logger.debug(ex);
			return ex.getMessage();
		} catch (Exception ex) {
			_logger.debug(ex);
			return ex.getMessage();
		}

		return "";
	}

	@RequestMapping(value = "/{userId}/detail")
	public ModelAndView showDetail(@PathVariable("userId") int id){
		UserModel user = _userService.getUserById(id);
		return new ModelAndView("user/detail", "user", user);
	}
	
	@RequestMapping(value = "/detail")
	public ModelAndView showDetail(@CookieValue (value = "userToken", required = false) String token){
		try {
			UserModel user = _userService.getUserByToken(token);
			return new ModelAndView("user/detail", "user", user);
		} catch (AuthorizationException ex) {
			_logger.error(ex);
			return new ModelAndView(String.format("redirect:/user/login.do?error=%s", ex.getMessage()));
		}
	}
		
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ModelAndView edit(@ModelAttribute("user") UserEditModel user){
		/*user.setUserId(id);
		user.setUserName(name);
		_userService.updateUser(user);*/
		return new ModelAndView("user/detail", "user", user);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam(value = "userId", required = false) int id){
		UserModel user = _userService.getUserById(id);
		user = user == null ? new UserModel() : user;
		return new ModelAndView("user/edit", "user", user);
	}
	
	@RequestMapping(value = "/test")
	public ModelAndView test(HttpServletRequest request) {
		MyResult<String> myResult = new MyResult<String>(false);
		myResult.setMessage(_context.getMessage("app.name"));
		return new ModelAndView("login", "result", myResult);
	}
	
}
