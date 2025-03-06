package com.myspring.team.admin.order.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

public interface adminOrderService {

	public List<OrderVO> listOrders() throws DataAccessException;
	public boolean updateOrderDeliveryState(OrderVO orderVO) throws DataAccessException;
}
