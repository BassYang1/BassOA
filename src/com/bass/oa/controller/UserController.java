package com.bass.oa.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContext;

import com.bass.oa.model.Result;
import com.bass.oa.model.UserModel;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	@RequestMapping(value = "/test")
	public ModelAndView test(HttpServletRequest request) {
		RequestContext requestContext = new RequestContext(request);
		Result result = new Result(false);
		result.setMessage(requestContext.getMessage("app.name"));
		return new ModelAndView("login", "result", result);
	}
	
	@RequestMapping(value = "/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/loginSubmit")
	public ModelAndView loginSubmit(UserModel user) {
		Result<UserModel> result = new Result<UserModel>(false);
		result.setData(user);
		return new ModelAndView("login", "result", result);
	}
}
