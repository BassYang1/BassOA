package com.bass.wxin.service.impl;

import com.bass.oa.core.ContextInstance;

public class BaseService {
	protected final ContextInstance getContext(){
		return ContextInstance.getInstance();
	}
}
