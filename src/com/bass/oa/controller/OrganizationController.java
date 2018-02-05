package com.bass.oa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.core.Constant;
import com.bass.oa.exception.SysException;
import com.bass.oa.exception.enums.SysExEnum;
import com.bass.oa.model.po.DepartmentModel;
import com.bass.oa.model.po.OrganizationModel;
import com.bass.oa.model.vo.OrgEditModel;
import com.bass.oa.service.IOrganizationService;

@Scope("prototype")
@Controller
@RequestMapping(value = "/org")
public class OrganizationController extends BaseController {
	@Autowired
	private IOrganizationService _orgService;

	/*
	 * 机构详细
	 */
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

	/*
	 * 部门列表
	 */
	@RequestMapping(value = "/dept/list")
	public ModelAndView deptList(@RequestParam(value = "orgId", required = false, defaultValue = "0") int id){
		List<DepartmentModel> depts = new ArrayList<DepartmentModel>();
		
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
			
			depts = _orgService.getDeptsByOrgId(org.getId());			
		}
		catch(SysException ex){
			_logger.error(ex);
		}
		
		return new ModelAndView("org/deptList", "depts", depts);
	}
	
	/*
	 * 编辑机构信息
	 */
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

	/*
	 * 编辑机构信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ModelAndView orgEdit(@ModelAttribute("org") @Validated OrgEditModel vo, BindingResult result, Model model){		
		try{
			if(result.hasErrors()){
				throw new SysException("保存机构信息失败");
			}
			
			OrganizationModel po = vo.convertToPO();
			_orgService.updateOrganization(po);
		}
		catch(SysException ex){
			_logger.error(ex);
			model.addAttribute(Constant.ATTR_ERROR_MSG, ex.getMessage());
			return new ModelAndView("org/orgEdit", "org", vo);
		}
		
		return new ModelAndView("redirect:/org/detail.do");
	}
}
