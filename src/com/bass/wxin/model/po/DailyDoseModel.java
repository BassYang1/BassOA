package com.bass.wxin.model.po;

import java.util.Date;

import com.bass.oa.core.AppUtil;
import com.bass.wxin.model.BaseModel;
import com.bass.wxin.model.vo.DailyDoseEditModel;

public class DailyDoseModel extends BaseModel {	
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
	 * 用户Id
	 */
	private int _userId;
	
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
	private Date _drugTime;
	
	public int getSeqNumber(){
		return this._seqNumber;
	}
	
	public void setSeqNumber(int seqNumber){
		this._seqNumber = seqNumber;
	}

	public int getUserId(){
		return this._userId;
	}
	
	public void setUserId(int userId){
		this._userId = userId;
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

	public Date getDrugTime(){
		return this._drugTime;
	}
	
	public void setDrugTime(Date drugTime){
		this._drugTime = drugTime;
	}
	
	@Override
	public String toString(){
		return String.format("[DailyDose=%d,%s,%s,%s,%s]", this._seqNumber, this._drugName, this._dose, this._unit, AppUtil.formatDateTime(this._drugTime));
	}
}
