package com.bass.oa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/org")
public class OrganizationController extends BaseController {
	@RequestMapping(value = "/list")
	public String orgList(){
		return "org/orgList";
	}
	
	@RequestMapping(value = "/com/list")
	public String deptList(){
		return "org/deptList";
	}
}
