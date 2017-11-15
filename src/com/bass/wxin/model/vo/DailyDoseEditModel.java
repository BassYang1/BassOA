package com.bass.wxin.model.vo;

/*
 * 编辑日常用药量
 */
public class DailyDoseEditModel {
	private long _seqNumber;
	private String _dose;
	private String _unit;

	public void setSeqNumber(long seqNumber){
		this._seqNumber = seqNumber;
	}
	
	public long getSeqNumber(){
		return this._seqNumber;
	}
	
	public void setDose(String dose){
		this._dose = dose;
	}
	
	public String getDose(){
		return this._dose;
	}
	
	public void setUnit(String unit){
		this._unit = unit;
	}
	
	public String getUnit(){
		return this._unit;
	}
}
