package com.myspring.team.admin.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.myspring.team.admin.order.dao.adminOrderDAO;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

@Service("adminOrderService")
public class adminOrderServiceImpl implements adminOrderService {

	@Autowired
	private adminOrderDAO adminOrderDAO;
	
	
	public List<OrderVO> listOrders() throws DataAccessException {
		List<OrderVO> ordersList = adminOrderDAO.selectOrderList();
		return ordersList;
	}
	
	@Override
	public boolean updateOrderDeliveryState(OrderVO orderVO) throws DataAccessException {
		return adminOrderDAO.updateOrderDeliveryState(orderVO);
        
    }
}	
