package com.bass.oa.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.bass.oa.core.ContextInstance;

public class BaseController {
	protected final static ContextInstance _context = ContextInstance.getInstance();	
	protected Logger _logger = null;

	public BaseController(){
		_logger = Logger.getLogger(getClass().getName());
	}
	
	@ExceptionHandler
	protected String doException(HttpServletRequest request, Throwable ex){
		request.setAttribute("ex", ex);
		_logger.error(ex);
		return "error";
	}
}
