package com.bass.oa.core;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

public class ContextHelper {
	private final static class ContextInstanceHolder{
		public static ContextHelper _instance = null;
		
		static{
			//System.out.println("创建ContextHelper单例");
			_instance = new ContextHelper();
		}
	}
	
	public static ContextHelper getInstance(){
		return ContextInstanceHolder._instance;
	}
	
	private ContextHelper(){
		
	}
	
	private final static String SESSION_ERROR = "session_error";
	/*
	 * 获取当前请求
	 */
	public HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
	}
	
	/*
	 * 获取当前session
	 */
	public HttpSession getSession(){
		return getRequest().getSession();
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
	 * 获取Spring国际化信息
	 */
	public String getMessage(String code){
		return getRequestContext().getMessage(code);
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


