package com.bass.oa.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.core.AppUtil;
import com.bass.oa.core.Constant;
import com.bass.oa.core.ContextInstance;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	private ContextInstance _context = ContextInstance.getInstance();
	private final static Logger _logger = Logger.getLogger(AuthorizationInterceptor.class);
	
	@Autowired
	private IUserService _userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//获取session
		UserModel user = (UserModel)_context.getSessionValue(Constant.SESSION_USER);
				
		if(user == null){
			String token = _context.getCookieValue(Constant.COOKIE_USER_TOKEN);
			
			if(StringUtils.isNotBlank(token)){
				String userName = AppUtil.base64Decode(token).split(Constant.SEPARATE_USER_TOKEN)[0];
				user = _userService.getUserByToken(token);				
				user = user == null || user.getUserName().equals(userName) ? null : user;
			}
			
			//添加session
			_context.setSessionValue(Constant.SESSION_USER, user);
		}

		//重新登录
		if(!request.getRequestURI().endsWith("/login.do") && user == null){
			String callback = request.getRequestURL().toString();
			String dispatcherUrl = String.format("%s/user/login.do?%s=%s", request.getContextPath(), Constant.PARAM_LOGIN_CALLBACK, callback);
			_logger.debug(request.getRequestURL().toString());
			_logger.debug(request.getRequestURI());
			//request.getRequestDispatcher(dispatcherUrl).forward(request, response);
			response.sendRedirect(dispatcherUrl);
			
			return false;
		}
		
		//转到首页
		if(request.getRequestURI().endsWith("/login.do") && user != null){
			//request.getRequestDispatcher("/index.do").forward(request, response);
			response.sendRedirect(String.format("%s/index.do", request.getContextPath()));
		}
		
		return true;
	}
}
