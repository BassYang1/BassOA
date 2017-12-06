package com.bass.oa.filter;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.core.ContextHelper;

public class CommonInterceptor extends HandlerInterceptorAdapter {
	private ContextHelper _contextHelper = ContextHelper.getInstance();
	public final static String SPRING_URL_PATTERN = "spring.url.pattern";
	
	
	/*
	 * @Override public boolean preHandle(HttpServletRequest request,
	 * HttpServletResponse response, Object handler) throws Exception { Cookie
	 * cookie = new Cookie("userToken", "test Cookie"); cookie.setMaxAge(30 *
	 * 60); //30分钟 cookie.setPath("/"); response.addCookie(cookie);
	 * 
	 * return true; }
	 */

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		String urlPattern = _contextHelper.getMessage(SPRING_URL_PATTERN);
		String url = request.getServletPath();
		request.getServletContext().get
	}
}
