package com.myspring.team.member.vo;

import java.sql.Time;
import java.sql.Timestamp;

public class PointHistoryVO {
	
	private int history_id;
	private String mem_id;
	private int point_amount;
	private String action_type;
	private Timestamp action_date;
	
	private String goods_names;
	private int final_total_price;
	private int order_id;
	
	public String getGoods_names() {
		return goods_names;
	}
	public void setGoods_names(String goods_names) {
		this.goods_names = goods_names;
	}
	public int getFinal_total_price() {
		return final_total_price;
	}
	public void setFinal_total_price(int final_total_price) {
		this.final_total_price = final_total_price;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getHistory_id() {
		return history_id;
	}
	public void setHistory_id(int history_id) {
		this.history_id = history_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getPoint_amount() {
		return point_amount;
	}
	public void setPoint_amount(int point_amount) {
		this.point_amount = point_amount;
	}
	public String getAction_type() {
		return action_type;
	}
	public void setAction_type(String action_type) {
		this.action_type = action_type;
	}
	public Timestamp getAction_date() {
		return action_date;
	}
	public void setAction_date(Timestamp action_date) {
		this.action_date = action_date;
	}
	@Override
	public String toString() {
		return "PointHistory [history_id=" + history_id + ", mem_id=" + mem_id + ", point_amount=" + point_amount
				+ ", action_type=" + action_type + ", action_date=" + action_date + "]";
	}
	
	
}
