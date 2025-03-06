package com.myspring.team.address.service;

import java.util.List;
import java.util.Map;

import com.myspring.team.address.vo.AddressVO;

public interface AddressService {

	public List<AddressVO> getAddressByMemberId(String mem_id) throws Exception;
	public void addAddress(AddressVO address) throws Exception;
	public int modAddress(AddressVO address) throws Exception;
	public void delAddress(AddressVO address) throws Exception;
}
