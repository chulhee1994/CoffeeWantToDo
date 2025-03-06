package com.myspring.team.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.order.vo.OrderVO;


public interface OrderDAO {
	
	public int insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;
	public List<OrderVO> selectOrderIdList(String cart_id) throws DataAccessException;
	public int selectOrderID() throws DataAccessException;
	public List<OrderVO> getOrdersFromCart(String memId, List<Integer> cartIds) throws DataAccessException;
	
	
	public void removeGoodsFromCart(List<OrderVO> myOrderList)throws DataAccessException;
	public void removeGoodsFromCart(OrderVO orderVO) throws DataAccessException;
	public void updateMemberPoints(Map<String, String> pointMap) throws DataAccessException;
	
	//
	public List<OrderVO> selectPossibleReviewList(String mem_id) throws DataAccessException;
	public void updateSeqOrderIdStatus(int seq_order_id) throws DataAccessException;
	
	
	//이포근
	// 일매출 데이터를 가져오는 메서드
    public List<OrderVO> selectDailySales(Map<String, Object> condMap) throws DataAccessException;
    public List<OrderVO> selectMonthlySales6Months(Map<String, Object> condMap) throws DataAccessException;
    public List<OrderVO> selectSellerDailySales(Map<String, Object> condMap) throws DataAccessException;
    public List<OrderVO> selectSellerMonthlySales6Months(Map<String, Object> condMap) throws DataAccessException;
    public List<Map<String, Object>> getMonthlyOrderCount();
    public List<OrderVO> selectMonthlySales7Months(Map<String, Object> condMap) throws DataAccessException;
    
    
    
    //백광민
    public List<OrderVO> selectSellerOrderList(String mem_id) throws DataAccessException;
    public List<OrderVO> selectSellerOrderList_done(String mem_id) throws DataAccessException;
    
    public int updateOrderId(int order_id) throws DataAccessException;
}
