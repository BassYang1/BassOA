package com.bass.oa.model.vo;

import com.bass.oa.model.BaseModel;
import com.bass.oa.model.po.OrganizationModel;

public class OrgEditModel extends BaseModel {
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
	
	public OrgEditModel(){
		
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

	public OrganizationModel convertToPO(){
		OrganizationModel po = new OrganizationModel();
		po.setName(this.name);
		po.setDirector(this.director);
		po.setContact(contact);
		po.setAddress(address);
		po.setEmail(email);
		po.setIntro(intro);
		po.setUrl(url);
		
		return po;
	}
	
	@Override
	public String toString(){
		return String.format("[Organization=%s]", this.name);
	}
}
