package com.bass.oa.service.impl;

import com.bass.oa.core.ContextHelper;

public class BaseService {
	protected final ContextHelper getContext(){
		return ContextHelper.getInstance();
	}
}
