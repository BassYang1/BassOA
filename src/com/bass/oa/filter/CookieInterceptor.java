package com.bass.oa.filter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CookieInterceptor extends HandlerInterceptorAdapter {	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		Cookie cookie = new Cookie("userToken", "test Cookie");
		cookie.setMaxAge(30 * 60); //30分钟
		cookie.setPath("/");
		response.addCookie(cookie);
		
		return true;
	}
}
