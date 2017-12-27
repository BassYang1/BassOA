package com.bass.wxin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ExceptionHandler;

import com.bass.oa.core.ContextInstance;

public class BaseController {
	@ExceptionHandler
	protected String doException(HttpServletRequest request, Throwable ex){
		request.setAttribute("ex", ex);
		return "error";
	}
	
	protected final ContextInstance getContext(){
		return ContextInstance.getInstance();
	}
}
