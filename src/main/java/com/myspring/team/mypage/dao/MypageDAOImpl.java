package com.myspring.team.mypage.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.mypage.dao.MypageDAO;
import com.myspring.team.order.vo.OrderVO;

@Repository("mypageDAO")
public class MypageDAOImpl implements MypageDAO {
	
	@Autowired
	 private SqlSession sqlSession;
	 
	public List<OrderVO> selectOrderList(String mem_id) throws DataAccessException {
		List<OrderVO> ordersList = sqlSession.selectList("mapper.order.selectmyOrderListByID", mem_id);
		return ordersList;
	}
	
	
	public List<OrderVO> selectOrderList_done(String mem_id) throws DataAccessException {
		List<OrderVO> ordersList_done = sqlSession.selectList("mapper.order.selectmyClearOrderListByID", mem_id);
		return ordersList_done;
	}
	
	@Override
    public List<OrderVO> selectOrderList_cancel(String mem_id) throws DataAccessException {
        List<OrderVO> ordersList_cancel = sqlSession.selectList("mapper.order.selectmyCacncelOrderListByID", mem_id);
        return ordersList_cancel;
    }
}
