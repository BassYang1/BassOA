package com.bass.oa.model.po;

import java.util.Date;

import com.bass.oa.core.AppUtil;
import com.bass.oa.model.BaseModel;
import com.bass.oa.model.vo.OrgEditModel;

public class OrganizationModel extends BaseModel {
	private int id;
	
	/*
	 * 机构名
	 */
	private String name;
	
	/*
	 * 机构负责人
	 */
	private String director;
	
	/*
	 * 联系方式
	 */
	private String contact;
	
	/*
	 * 机构网址
	 */
	private String url;
	
	/*
	 * 地址
	 */
	private String address;

	/*
	 * 公司科介
	 */
	private String intro;
	
	/*
	 * 用户邮箱
	 */
	private String email;
	
	private Date createdDate;

	public OrganizationModel(){
		
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return this.id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return this.name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return this.email;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getDirector() {
		return this.director;
	}
	
	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getContact() {
		return this.contact;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUrl() {
		return this.url;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return this.address;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getIntro() {
		return this.intro;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getCreatedDate() {
		return this.createdDate;
	}

	public OrgEditModel convertToEditVO(){
		OrgEditModel vo = new OrgEditModel();
		vo.setId(id);
		vo.setName(this.name);
		vo.setDirector(this.director);
		vo.setContact(contact);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setIntro(intro);
		vo.setUrl(url);
		
		return vo;
	}
	
	@Override
	public String toString(){
		return String.format("[Organization=%d,%s,%s]", this.id, this.name, AppUtil.formatDateTime(this.createdDate));
	}
}
