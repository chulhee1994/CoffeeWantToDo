package com.myspring.team.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.order.vo.OrderVO;


public interface OrderService{

	public int addNewOrder(List<OrderVO> myOrderList) throws Exception;

	public void updateMemberPoints(Map<String, String> pointMap) throws Exception;

	public List<OrderVO> selectOrderIdList(String cart_id) throws Exception;


	public List<OrderVO> getOrdersFromCart(String memId, List<Integer> cartIds);

	public void processOrder(List<Integer> cartIds);
	
	//이포근
	// 일매출을 가져오는 메서드
    public List<OrderVO> getDailySales(Map<String, Object> condMap) throws Exception;
    public List<OrderVO> getMonthlySales(Map<String, Object> condMap) throws Exception;
    public List<OrderVO> getSellerDailySales(Map<String, Object> condMap) throws Exception;
    public List<OrderVO> getSellerMonthlySales(Map<String, Object> condMap) throws Exception;
    public List<OrderVO> getMonthlysellerSales(Map<String, Object> condMap) throws Exception;
    public GoodsVO getGoodsById(int goods_id) throws Exception;
    public List<Map<String, Object>> getMonthlyOrderCount();
    
    
    
    
    
    
    
    
    
    public int updateOrderId(int order_id) throws Exception;
    
    public List<OrderVO> SellerlistOrders(String mem_id) throws DataAccessException;
    public List<OrderVO> SellerlistOrders_done(String mem_id) throws DataAccessException;

}
