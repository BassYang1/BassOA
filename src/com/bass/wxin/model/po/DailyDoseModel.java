package com.bass.wxin.model.po;

import java.util.Date;

import com.bass.wxin.model.vo.DailyDoseEditModel;

public class DailyDoseModel {	
	public DailyDoseModel(){}

	public DailyDoseModel(DailyDoseEditModel model){		
		if(model != null){
			this._seqNumber = model.getSeqNumber();
			this._drugName = model.getDrugName();
			this._dose = model.getDose();
			this._unit = model.getUnit();
		}		
	}
	
	

	/*
	 * 序列号
	 */
	private int _seqNumber;
	
	/*
	 * 药品名称
	 */
	private String _drugName;
	
	/*
	 * 用药剂量
	 */
	private String _dose;
	
	/*
	 * 剂量单位
	 */
	private String _unit;
	
	/*
	 * 用药时间
	 */
	private Date _drupTime;
	
	public int getSeqNumber(){
		return this._seqNumber;
	}
	
	public void setSeqNumber(int seqNumber){
		this._seqNumber = seqNumber;
	}
	
	public String getDrugName(){
		return this._drugName;
	}
	
	public void setDrugName(String drugName){
		this._drugName = drugName;
	}

	public String getDose(){
		return this._dose;
	}
	
	public void setDose(String dose){
		this._dose = dose;
	}

	public String getUnit(){
		return this._unit;
	}
	
	public void setUnit(String unit){
		this._unit = unit;
	}

	public Date getDrupTime(){
		return this._drupTime;
	}
	
	public void setDrupTime(Date drupTime){
		this._drupTime = drupTime;
	}
}
