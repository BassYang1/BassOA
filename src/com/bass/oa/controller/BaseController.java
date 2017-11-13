package com.bass.oa.controller;

import com.bass.oa.core.ContextHelper;

public class BaseController {
	protected final ContextHelper getContext(){
		return ContextHelper.getInstance();
	}
}
