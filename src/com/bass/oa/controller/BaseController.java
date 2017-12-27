package com.bass.oa.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ExceptionHandler;

import com.bass.oa.core.ContextInstance;

public class BaseController {
	protected ContextInstance _context = ContextInstance.getInstance();	

	@ExceptionHandler
	protected String doException(HttpServletRequest request, Throwable ex){
		request.setAttribute("ex", ex);
		return "error";
	}
}
