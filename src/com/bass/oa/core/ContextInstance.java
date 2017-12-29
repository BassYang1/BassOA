package com.bass.oa.core;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

public class ContextInstance {
	private final static class ContextInstanceHolder{
		public static ContextInstance _instance = null;
		
		static{
			//System.out.println("创建ContextHelper单例");
			_instance = new ContextInstance();
		}
	}
	
	public static ContextInstance getInstance(){
		return ContextInstanceHolder._instance;
	}
	
	private ContextInstance(){
		
	}
	
	private final static String SESSION_ERROR = "session_error";
	private final static int COOKIE_MAX_AGE = 24 * 60 * 60; //小时 * 分 * 秒
	
	/*
	 * 获取当前请求
	 */
	public HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
	}

	/*
	 * 获取当前请求
	 */
	public HttpServletResponse getResponse(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();  
	}
	
	/*
	 * 获取当前session
	 */
	public HttpSession getSession(){
		return getRequest().getSession();
	}
	
	/*
	 * 获取session value
	 */
	public Object getSessionValue(String attributeName){
		return getSession().getAttribute(attributeName);
	}

	/*
	 * 设置session value
	 */
	public void setSessionValue(String attributeName, Object value){
		getSession().setAttribute(attributeName, value);
	}	
	
	/*
	 * 获取Spring请求上下文
	 */
	public RequestContext getRequestContext(){
		return new RequestContext(getRequest());
	}
	
	/*
	 * 获取Servlet上下文
	 */
	public ServletContext getServletContext(){
		return getRequest().getServletContext();
	}

	/*
	 * 获取Spring应用上下文
	 */
	public WebApplicationContext getWebApplicationContext(){
		return (WebApplicationContext)getServletContext().getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
	}

	/*
	 * 添加cookie
	 */
	public void addCookie(String name, String value){
		addCookie(name, value, null, COOKIE_MAX_AGE, false, false, null);
	}
	
	/*
	 * 添加cookie
	 */
	public void addCookie(String name, String value, String domain, int expiry, boolean secure, boolean httpOnly, String path){
		if(StringUtils.isEmpty(name)){
			return;
		}
		
		Cookie cookie = new Cookie(name, value == null? "" : value);
		cookie.setMaxAge(expiry);
		cookie.setSecure(secure);
		cookie.setHttpOnly(httpOnly);
		
		if(StringUtils.isNotBlank(path)) {
			cookie.setPath(path);
		}
		else{
			cookie.setPath("/");
		}
		
		if(StringUtils.isNotBlank(domain)){
			cookie.setDomain(domain);
		}
		
		getResponse().addCookie(cookie);
	}
	
	/*
	 * 获取cookie
	 */
	public Cookie getCookie(String name){
		if(StringUtils.isEmpty(name)){
			return null;
		}
		
		Cookie[] cookies = getRequest().getCookies();
		
		for(Cookie cookie : cookies){
			if(cookie.getName().equalsIgnoreCase(name)){
				return cookie;
			}
		}
		
		return null;
	}
	
	/*
	 * 获取cookie的值
	 */
	public String getCookieValue(String name){
		Cookie cookie = getCookie(name); 
		
		if(cookie == null){
			return "";
		}
		
		return cookie.getValue();
	}
	
	/*
	 * 移除cookie
	 */
	public void removeCookie(String name){
		Cookie cookie = getCookie(name);
		
		if(cookie != null){
			cookie.setPath("/");
			cookie.setMaxAge(0);
			cookie.setValue(null);
			
			getResponse().addCookie(cookie);
		}
	}
	/*
	 * 获取Spring国际化信息
	 */
	public String getMessage(String code){
		return getRequestContext().getMessage(code);
	}
	
	/*
	 * 设置session级别error
	 */
	public void setI18nError(String label){
		getSession().setAttribute(SESSION_ERROR, getMessage(label));
	}

	/*
	 * 设置session级别error
	 */
	public void setError(String error){
		getSession().setAttribute(SESSION_ERROR, error);
	}

	/*
	 * 设置session级别error
	 */
	public String getError(){
		String error = (String)getSession().getAttribute(SESSION_ERROR);
		getSession().removeAttribute(SESSION_ERROR);
		
		return error;
	}	

	/*
	 * 获取Spring配置信息
	 */
	/*public String getProperty(String code){
		//return getWebApplicationContext().getEnvironment().getRequiredProperty(code);
		return getWebApplicationContext().getEnvironment().getProperty(code);
	}*/
}


