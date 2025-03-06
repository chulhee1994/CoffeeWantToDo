package com.myspring.team.address.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.team.address.vo.AddressVO;

public interface AddressDAO {
	public List<AddressVO> selectAddressByMemberId(String mem_id) throws DataAccessException;
	public void insertNewAddress(AddressVO address) throws DataAccessException;
	public int updateAddress(AddressVO address) throws DataAccessException;
	public void delAddress(AddressVO address) throws DataAccessException;
	public void relocationByAddressId(AddressVO address) throws Exception;
}
