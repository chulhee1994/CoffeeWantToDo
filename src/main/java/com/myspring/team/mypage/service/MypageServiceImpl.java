package com.myspring.team.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.myspring.team.mypage.dao.MypageDAO;
import com.myspring.team.order.vo.OrderVO;

@Service("mypageService")
public class MypageServiceImpl implements MypageService{

	@Autowired
	private MypageDAO mypageDAO;
	
	public List<OrderVO> listOrders(String mem_id) throws DataAccessException {
		List<OrderVO> ordersList = mypageDAO.selectOrderList(mem_id);
		return ordersList;
	}
	
	public List<OrderVO> listOrders_done(String mem_id) throws DataAccessException {
		List<OrderVO> ordersList_done = mypageDAO.selectOrderList_done(mem_id);
		return ordersList_done;
	}
	
	@Override
    public List<OrderVO> listOrders_cancel(String mem_id) throws DataAccessException {
        List<OrderVO> ordersList_cancel = mypageDAO.selectOrderList_cancel(mem_id);
        return ordersList_cancel;
    }
	
	
}
