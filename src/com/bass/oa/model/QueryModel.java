package com.bass.oa.model;

public class QueryModel {
	/*
	 * 分页大小
	 */
	public int pageSize;
	
	/*
	 * 当前页
	 */
	public int pageNum;
	
	/*
	 * 记录总数
	 */
	public int totalSize;
	
	/*
	 * 总页数
	 */
	public int totalPage;

	public void setPageSize(int pageSize){
		this.pageSize = pageSize;
	}
	
	public int getPageSize(){
		return this.pageSize;
	}	

	public void setPageNum(int pageNum){
		this.pageNum = pageNum;
	}
	
	public int getPageNum(){
		return this.pageNum;
	}
	
	public void setTotalSize(int totalSize){
		this.totalSize = totalSize;
	}
	
	public int getTotalSize(){
		return this.totalSize;
	}

	public void setTotalPage(int totalPage){
		this.totalSize = totalPage;
	}
	
	public int getTotalPage(){
		return this.totalPage;
	}
}
