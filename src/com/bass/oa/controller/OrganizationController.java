package com.bass.oa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.exception.SysException;
import com.bass.oa.exception.enums.SysExEnum;
import com.bass.oa.model.po.OrganizationModel;
import com.bass.oa.model.vo.OrgEditModel;
import com.bass.oa.service.IOrganizationService;

@Scope("prototype")
@Controller
@RequestMapping(value = "/org")
public class OrganizationController extends BaseController {
	@Autowired
	private IOrganizationService _orgService;

	@RequestMapping(value = "/detail")
	public ModelAndView orgDetail(@RequestParam(value = "orgId", required = false, defaultValue = "0") int id){
		OrganizationModel model = null;
		
		try{
			if(id <= 0){
				model = _orgService.getSingleOrgDetail();
			}
			else{
				model = _orgService.getOrgDetailById(id);
			}
		}
		catch(SysException ex){
			_logger.error(ex);
		}
		
		return new ModelAndView("org/orgDetail", "org", model);
	}	

	@RequestMapping(value = "/com/list")
	public String deptList(@RequestParam(value = "orgId", required = false, defaultValue = "0") int id){
		try{
			OrganizationModel org = null;
			
			if(id <= 0){
				org = _orgService.getSingleOrgDetail();
			}
			else{
				org = _orgService.getOrgDetailById(id);
			}
			
			if(org == null){
				new SysException(SysExEnum.ORG_UNFOUND);
			}
			
			
			
		}
		catch(SysException ex){
			_logger.error(ex);
		}
		
		return "org/deptList";
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView orgEdit(@RequestParam(value = "orgId", required = false, defaultValue = "0") int id){
		OrganizationModel model = null;
		OrgEditModel vo = new OrgEditModel();
		
		try{
			if(id <= 0){
				model = _orgService.getSingleOrgDetail();
			}
			else{
				model = _orgService.getOrgDetailById(id);
			}
			
			if(model == null){
				new SysException(SysExEnum.ORG_UNFOUND);
			}		
			
			vo = model.convertToEditVO();
		}
		catch(SysException ex){
			_logger.error(ex);
		}
		
		return new ModelAndView("org/orgEdit", "org", vo);
	}
	
}
