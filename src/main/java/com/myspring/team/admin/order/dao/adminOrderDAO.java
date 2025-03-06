package com.myspring.team.admin.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

public interface adminOrderDAO {

	public List<OrderVO> selectOrderList() throws DataAccessException;
	public boolean updateOrderDeliveryState(OrderVO orderVO) throws DataAccessException;
}
