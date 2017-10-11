package com.bass.oa.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class BaseService {
	/*
	 * 获取当前请求
	 */
	protected HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();  
	}
	
	/*
	 * 获取当前session
	 */
	protected HttpSession getSession(){
		return getRequest().getSession();
	}
}
