package com.bass.oa.service.impl;

import com.bass.oa.core.AppHelper;
import com.bass.oa.core.ContextHelper;

public class BaseService {
	protected ContextHelper _context = ContextHelper.getInstance();
	protected AppHelper _app = AppHelper.getInstance();
}
