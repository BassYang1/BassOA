package com.bass.oa.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private IUserService _userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		UserModel user = _userService.getCurrentUser();
		
		if(user == null){
			//String token = request.getCookies();
			//user = _userService.getUserByToken(token);
		}
		
		
		
		/*System.out.println(request.getRequestURI());
		System.out.println(request.getRequestURL());		
		System.out.println(request.getServletPath());*/
		
		if(user == null){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/user/login.do").forward(request, response);
			return false;
		}
		
		return true;
	}
}
