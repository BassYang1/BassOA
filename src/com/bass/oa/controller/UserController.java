package com.bass.oa.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.core.Constant;
import com.bass.oa.model.MyResult;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.model.vo.UserLoginModel;
import com.bass.oa.service.IUserService;

@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {	
	@Autowired
	private IUserService _userService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") @Validated UserLoginModel userLoginInfo, BindingResult result, Model model) {
		if(userLoginInfo == null || result.hasErrors()){
			_logger.debug(_context.getMessage("user.login.failed"));
			model.addAttribute("error", _context.getMessage("user.login.failed"));
			return "login";
		}
		
		UserModel user = _userService.login(userLoginInfo);
		
		if(user == null){
			String error = _context.getError();
			_logger.debug(error);
			model.addAttribute("error", error);
			return "login";
		}
		
		if(StringUtils.isEmpty(user.getToken())){
			_logger.debug(_context.getMessage("user.login.failed"));
			model.addAttribute("error", _context.getMessage("user.login.failed"));
			return "login";
		}

		//添加cookie
		if(userLoginInfo.isRememberme()){
			_context.addCookie(Constant.USER_TOKEN, user.getToken());
			_context.addCookie(Constant.USER_LOGIN_NAME, user.getUserName());
		}

		//存储到session中
		_context.getSession().setAttribute(Constant.USER_SESSION, user);

		//页面跳转
		String callback = _context.getRequest().getParameter(Constant.LOGIN_CALLBACK);
		
		if(StringUtils.isNotBlank(callback)){
			return String.format("redirect:%s", callback);
		}
		
		return "redirect:/index.do";
	}
	
	@RequestMapping(value = "/{userId}/detail")
	public ModelAndView showDetail(@PathVariable("userId") int id){
		UserModel user = _userService.getUserById(id);
		return new ModelAndView("user/detail", "user", user);
	}
	
	@RequestMapping(value = "/detail")
	public ModelAndView showDetail(@CookieValue (value = "userToken", required = false) String token){
		UserModel user = _userService.getUserByToken(token);
		return new ModelAndView("user/detail", "user", user);
	}
		
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ModelAndView edit(@RequestParam("userId") int id, @RequestParam("userName") String name){
		UserModel user = new UserModel();
		user.setUserId(id);
		user.setUserName(name);
		_userService.updateUser(user);
		return new ModelAndView("user/detail", "user", user);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam("userId") int id){
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
