package com.myspring.team.address.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.address.dao.AddressDAO;
import com.myspring.team.address.vo.AddressVO;

@Service("addressService")
@Transactional(propagation=Propagation.REQUIRED)
public class AddressServiceImpl implements AddressService {

	@Autowired
	private AddressDAO addressDAO;
	
	
	@Override
	public List<AddressVO> getAddressByMemberId(String mem_id) throws Exception {
	    List<AddressVO> addressList = addressDAO.selectAddressByMemberId(mem_id);
	    return addressList;
	}
	
	@Override
	public void addAddress(AddressVO address) throws Exception{
		addressDAO.insertNewAddress(address);
	}
	
	@Override
	@Transactional
	public int modAddress(AddressVO address) throws Exception {
		return addressDAO.updateAddress(address);		 
	}
	
    @Override
    public void delAddress(AddressVO address) throws Exception {
        addressDAO.delAddress(address);
        addressDAO.relocationByAddressId(address);
    }
}