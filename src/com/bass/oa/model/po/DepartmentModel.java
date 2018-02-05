package com.bass.oa.model.po;

import com.bass.oa.model.BaseModel;
import java.util.Date;

public class DepartmentModel extends BaseModel
{
	private int id;

	public void setId(int id)
	{
		this.id = id;
	}

	public int getId()
	{
		return this.id;
	}

	private int orgId;

	public void setOrgId(int orgId)
	{
		this.orgId = orgId;
	}

	public int getOrgId()
	{
		return this.orgId;
	}

	private String orgName;

	public void setOrgName(String orgName)
	{
		this.orgName = orgName;
	}

	public String getOrgName()
	{
		return this.orgName;
	}
	
	private int parentId;

	public void setParentId(int parentId)
	{
		this.parentId = parentId;
	}

	public int getParentId()
	{
		return this.parentId;
	}

	private String parentName;

	public void setParentName(String parentName)
	{
		this.parentName = parentName;
	}

	public String getParentName()
	{
		return this.parentName;
	}
	
	private String code;

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getCode()
	{
		return this.code;
	}

	private String name;

	public void setName(String name)
	{
		this.name = name;
	}

	public String getName()
	{
		return this.name;
	}

	private int leader;

	public void setLeader(int leader)
	{
		this.leader = leader;
	}

	public int getLeader()
	{
		return this.leader;
	}

	private String leaderName;

	public void setLeaderName(String leaderName)
	{
		this.leaderName = leaderName;
	}

	public String getLeaderName()
	{
		return this.leaderName;
	}
	
	private Date createdDate;

	public void setCreatedDate(Date createdDate)
	{
		this.createdDate = createdDate;
	}

	public Date getCreatedDate()
	{
		return this.createdDate;
	}

}