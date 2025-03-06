package com.myspring.team.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.cart.dao.CartDAO;
import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.goods.dao.GoodsDAO;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.order.dao.OrderDAO;
import com.myspring.team.order.vo.OrderVO;

@Service("orderService")
	public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDAO orderDAO;
	
    @Autowired
    private CartDAO cartDAO;  // ✅ 장바구니 DAO 추가
	
    @Autowired
    private GoodsDAO goodsDAO;
    
    /*
    여기는 주문테이블에 주문정보만 올라가는 로직
	@Override
	public int addNewOrder(List<OrderVO> myOrderList) throws Exception{
		//주문 추가
		int order_id = orderDAO.insertNewOrder(myOrderList);
		return order_id;
	}
	*/
	  @Override
	    @Transactional
	    public int addNewOrder(List<OrderVO> myOrderList) throws Exception{


	        //주문 추가
	        int order_id = orderDAO.insertNewOrder(myOrderList);

	        //배열마다 굿즈아이디의 주문갯수를 받아서 반복적으로 updateStock실행 goods_id의 order_goods_qty만큼 재고수가 빠짐
	        for(OrderVO orderVO : myOrderList) {
	            System.out.println("서비스 addNewOrder :" + orderVO);
	            int goods_id = orderVO.getGoods_id();
	            int order_goods_qty = orderVO.getOrder_goods_qty();
	            Map<String, Object> stockMap = new HashMap<>();
	            stockMap.put("goods_id", goods_id);
	            stockMap.put("order_goods_qty", order_goods_qty);
	            goodsDAO.updateStock(stockMap);
	        }


	        return order_id;
	    } 
	
	  // ✅ 주문 저장 후 장바구니 삭제 로직 추가
	@Override
	public void processOrder(List<Integer> cartIds) {
	    if (cartIds != null && !cartIds.isEmpty()) {
	        Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("list", cartIds); // MyBatis에서 사용할 key로 "list" 추가
	        cartDAO.deleteCartItems(paramMap); // 수정된 DAO 메서드 호출
	    }
	}

	
	
	  // 🚀 포인트 사용 & 적립 업데이트 메서드 추가
	@Override
    public void updateMemberPoints(Map<String, String> pointMap) throws Exception{
    	orderDAO.updateMemberPoints(pointMap);
    }
	
	@Override
	public List<OrderVO> selectOrderIdList(String cart_id) throws Exception{
		return orderDAO.selectOrderIdList(cart_id);
	}
	
	
	@Override
	public List<OrderVO> getOrdersFromCart(String memId, List<Integer> cartIds) {
	    // ✅ 장바구니에 있는 선택한 상품 정보를 가져오기
	    return orderDAO.getOrdersFromCart(memId, cartIds);
	}
	
	
	
	//이포근
		// 일매출 데이터를 가져오는 메서드
	    @Override
	    public List<OrderVO> getDailySales(Map<String, Object> condMap) throws Exception {
	        return orderDAO.selectDailySales(condMap);
	    }

	    @Override
	    public List<OrderVO> getMonthlySales(Map<String, Object> condMap) throws Exception {
	        // 6개월 단위로 월별 매출 데이터를 가져옴
	        List<OrderVO> monthlySalesData = orderDAO.selectMonthlySales6Months(condMap);

	        // 이미 SQL에서 6개월 단위로 집계되었기 때문에 추가적인 집계는 필요 없음
	        return monthlySalesData;  // 6개월 단위 매출 데이터 반환
	    }
	    
	    @Override
	    public List<OrderVO> getMonthlysellerSales(Map<String, Object> condMap) throws Exception {
	        // 6개월 단위로 월별 매출 데이터를 가져옴
	        List<OrderVO> monthlysellerSalesData = orderDAO.selectMonthlySales7Months(condMap);

	        // 이미 SQL에서 6개월 단위로 집계되었기 때문에 추가적인 집계는 필요 없음
	        return monthlysellerSalesData;  // 6개월 단위 매출 데이터 반환
	    }
	    
	 // 일매출 데이터를 가져오는 메서드
	    @Override
	    public List<OrderVO> getSellerDailySales(Map<String, Object> condMap) throws Exception {
	        return orderDAO.selectSellerDailySales(condMap);
	    }

	    @Override
	    public List<OrderVO> getSellerMonthlySales(Map<String, Object> condMap) throws Exception {
	        // 6개월 단위로 월별 매출 데이터를 가져옴
	        List<OrderVO> monthlySalesData = orderDAO.selectSellerMonthlySales6Months(condMap);

	        // 이미 SQL에서 6개월 단위로 집계되었기 때문에 추가적인 집계는 필요 없음
	        return monthlySalesData;  // 6개월 단위 매출 데이터 반환
	    }
	    
	    @Override
	    public GoodsVO getGoodsById(int goods_id) throws Exception {

	        GoodsVO goodsVO = goodsDAO.getGoodsById(goods_id);
	        return goodsVO;
	    }
	    public List<Map<String, Object>> getMonthlyOrderCount() {
	        // DAO 메소드를 호출하여 결과를 반환
	        return orderDAO.getMonthlyOrderCount();
	    }
    
    
    
    
    
    
    
    //내꺼
    @Override
    public int updateOrderId(int order_id) throws Exception {
        return orderDAO.updateOrderId(order_id);
    }
    
    @Override
    public List<OrderVO> SellerlistOrders(String mem_id) throws DataAccessException {
		List<OrderVO> SellerOrdersList = orderDAO.selectSellerOrderList(mem_id);
		System.out.println("service orderslist #1 : " + SellerOrdersList);
		return SellerOrdersList;
	}
	
    @Override
	public List<OrderVO> SellerlistOrders_done(String mem_id) throws DataAccessException {
		List<OrderVO> SellerOrdersList_done = orderDAO.selectSellerOrderList_done(mem_id);
		System.out.println("service orderslist #2 : " + SellerOrdersList_done);
		return SellerOrdersList_done;
	}
}
