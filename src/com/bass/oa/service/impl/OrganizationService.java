package com.bass.oa.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.bass.oa.mapper.OrganizationMapper;
import com.bass.oa.model.po.DepartmentModel;
import com.bass.oa.model.po.OrganizationModel;
import com.bass.oa.service.IOrganizationService;

@Scope("prototype")
@Service
public class OrganizationService extends BaseService implements IOrganizationService {
	@Autowired
	private OrganizationMapper _orgMapper;

	/*
	 * 获取单个组织详细
	 */
	@Override
	public OrganizationModel getSingleOrgDetail() {
		return _orgMapper.getSingleOrgDetail();
	}

	/*
	 * 根据Id获取组织详细
	 */
	@Override
	public OrganizationModel getOrgDetailById(int id) {
		return _orgMapper.getOrgDetailById(id);
	}
	
	/*
	 * 根据Id获取组织部门
	 */
	@Override
	public List<DepartmentModel> getDeptsByOrgId(int id){
		return _orgMapper.getDeptsByOrgId(id);
	}
}
