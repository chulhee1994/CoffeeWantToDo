package com.myspring.team.address.vo;

import org.springframework.stereotype.Component;

@Component("addressVO")
public class AddressVO {
	
	private int address_id;
	private String mem_id;
	private String address_name;
	private String mem_zipcode;
	private String mem_add1;
	private String mem_add2;
	private String mem_add3;
	
	
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getAddress_name() {
		return address_name;
	}
	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_add1() {
		return mem_add1;
	}
	public void setMem_add1(String mem_add1) {
		this.mem_add1 = mem_add1;
	}
	public String getMem_add2() {
		return mem_add2;
	}
	public void setMem_add2(String mem_add2) {
		this.mem_add2 = mem_add2;
	}
	public String getMem_add3() {
		return mem_add3;
	}
	public void setMem_add3(String mem_add3) {
		this.mem_add3 = mem_add3;
	}

	
}
