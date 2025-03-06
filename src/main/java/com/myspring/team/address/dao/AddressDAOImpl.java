package com.myspring.team.address.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.team.address.vo.AddressVO;

@Repository("addressDAO")
public class AddressDAOImpl implements AddressDAO {

	@Autowired
	private SqlSession sqlSession;
	
    @Override
    public List<AddressVO> selectAddressByMemberId(String mem_id) {
    	List<AddressVO> addressList = sqlSession.selectList("mapper.address.selectAddressByMemberId", mem_id);
        return addressList;     		
    }
	
	@Override
	public void insertNewAddress(AddressVO address) throws DataAccessException {
		sqlSession.insert("mapper.address.insertNewAddress", address);
	}
	
	@Override
	public int updateAddress(AddressVO address) throws DataAccessException {
		return sqlSession.update("mapper.address.updateAddressByAddressId", address);
	}
	
	 @Override
	    public void delAddress(AddressVO address) throws DataAccessException {
		 sqlSession.delete("mapper.address.deleteAddressByAddressId", address);
	    }
	 @Override
	 public void relocationByAddressId(AddressVO address) throws Exception {
		 sqlSession.update("mapper.address.relocationByAddressId", address);
	 }
}
