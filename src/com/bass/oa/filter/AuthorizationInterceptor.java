package com.bass.oa.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	private IUserService userService;
	
	public void setUserService(IUserService userService){
		this.userService = userService;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		UserModel user = this.userService.getCurrentUser();
		
		if(user == null){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/login.do").forward(request, response);
			return false;
		}
		
		return true;
	}
}
