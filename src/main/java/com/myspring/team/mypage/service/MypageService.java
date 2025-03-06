package com.myspring.team.mypage.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.order.vo.OrderVO;

public interface MypageService {
	public List<OrderVO> listOrders(String mem_id) throws DataAccessException;
	public List<OrderVO> listOrders_done(String mem_id) throws DataAccessException;
	public List<OrderVO> listOrders_cancel(String mem_id) throws DataAccessException;
}
