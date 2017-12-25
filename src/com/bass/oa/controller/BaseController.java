package com.bass.oa.controller;

import com.bass.oa.core.AppHelper;
import com.bass.oa.core.ContextHelper;

public class BaseController {
	protected ContextHelper _context = ContextHelper.getInstance();
	protected AppHelper _app = AppHelper.getInstance();
}
