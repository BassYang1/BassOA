package com.bass.oa.exception.enums;

import org.springframework.stereotype.Component;

import com.bass.oa.core.ContextInstance;

@Component
public interface ExceptionEnum {
	public final static ContextInstance _context = ContextInstance.getInstance();

	public String getModule();
	public String getCode();
	public String getMessage();
}
