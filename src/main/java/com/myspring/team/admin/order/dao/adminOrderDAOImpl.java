package com.myspring.team.admin.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

@Repository("adminOrderDAO")
public class adminOrderDAOImpl implements adminOrderDAO {
	
	@Autowired
	 private SqlSession sqlSession;

	public List<OrderVO> selectOrderList() throws DataAccessException {
		List<OrderVO> ordersList = sqlSession.selectList("mapper.order.selectOrderList");
		return ordersList;
	}
	
	@Override
	public boolean updateOrderDeliveryState(OrderVO orderVO) throws DataAccessException {
	        sqlSession.update("mapper.order.modOrderDeliverystate", orderVO);
	        return true;
	    }
}
