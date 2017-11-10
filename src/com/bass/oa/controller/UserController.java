package com.bass.oa.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import org.springframework.web.servlet.support.RequestContext;

import com.bass.oa.model.MyResult;
import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	@Autowired
	private IUserService _userService;

	@RequestMapping(value = "/login")
	public String login() {
		return "login";
	}

	@RequestMapping(value = "/loginSubmit", method = RequestMethod.POST)
	public String loginSubmit(@ModelAttribute("user") @Validated UserModel user, BindingResult result, Model model) {
		if(result.hasErrors()){
			model.addAttribute("error", getText("user.login.validation.error"));
			return "login";
		}
		
		return "redirect:dashboard";
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
		RequestContext requestContext = new RequestContext(request);
		MyResult myResult = new MyResult(false);
		myResult.setMessage(requestContext.getMessage("app.name"));
		return new ModelAndView("login", "result", myResult);
	}
	
}
