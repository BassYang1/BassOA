package com.bass.oa.mapper;

import java.util.List;

import com.bass.oa.model.po.DepartmentModel;
import com.bass.oa.model.po.OrganizationModel;

public interface OrganizationMapper {
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

	/*
	 * 更新构机信息
	 */
	public void updateOrganization(OrganizationModel po);
}
