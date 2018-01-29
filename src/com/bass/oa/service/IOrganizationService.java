package com.bass.oa.service;

import java.util.List;

import com.bass.oa.model.po.DepartmentModel;
import com.bass.oa.model.po.OrganizationModel;

public interface IOrganizationService {
	/*
	 * 获取单个组织详细
	 */
	public OrganizationModel getSingleOrgDetail();
	
	/*
	 * 根据Id获取组织详细
	 */
	public OrganizationModel getOrgDetailById(int id);
	
	/*
	 * 根据Id获取组织部门
	 */
	public List<DepartmentModel> getDeptsByOrgId(int id);
}
