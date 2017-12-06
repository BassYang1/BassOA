package com.bass.oa.core;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	 * 获取Spring国际化信息
	 */
	public String getMessage(String code){
		return getRequestContext().getMessage(code);
	}
}


