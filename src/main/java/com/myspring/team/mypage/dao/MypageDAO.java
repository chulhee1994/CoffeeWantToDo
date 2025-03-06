package com.myspring.team.mypage.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.order.vo.OrderVO;

public interface MypageDAO {
	public List<OrderVO> selectOrderList(String mem_id) throws DataAccessException;
	public List<OrderVO> selectOrderList_done(String mem_id) throws DataAccessException;
	public List<OrderVO> selectOrderList_cancel(String mem_id) throws DataAccessException;
}
