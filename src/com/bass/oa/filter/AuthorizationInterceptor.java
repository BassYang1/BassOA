package com.bass.oa.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.core.ContextInstance;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	private ContextInstance _context = ContextInstance.getInstance();
	
	@Autowired
	private IUserService _userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//获取session
		UserModel user = (UserModel)_context.getSession().getAttribute(Constant.USER_SESSION);
		
		if(user == null){
			String token = _context.getCookieValue(Constant.USER_TOKEN);
			
			if(StringUtils.isNotBlank(token)){
				String userName = AppUtil.base64Decode(token).split(Constant.USER_TOKEN_SEPARATE)[0];
				user = _userService.getUserByToken(token);
				user = user == null || user.getUserName().equals(userName) ? null : user;
			}
			
			//添加session
			_context.getSession().setAttribute(Constant.USER_SESSION, user);
		}
		
		if(user == null){
			String callback = request.getRequestURL().toString();
			String dispatcherUrl = String.format("/login.do?%s=%s", Constant.LOGIN_CALLBACK, callback);
			System.out.println(request.getRequestURL().toString());
			System.out.println(request.getRequestURI());
			request.getRequestDispatcher(dispatcherUrl).forward(request, response);
			
			return false;
		}
		
		if(request.getRequestURI().endsWith("/login.do")){
			request.getRequestDispatcher("/index.do").forward(request, response);
		}
		
		return true;
	}
}
