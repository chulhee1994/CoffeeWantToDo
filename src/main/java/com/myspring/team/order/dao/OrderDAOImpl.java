package com.myspring.team.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.order.vo.OrderVO;


@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO  {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException{
		int order_id=selectOrderID();
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			sqlSession.insert("mapper.order.insertNewOrder",orderVO);
		}
		return order_id;
	}		
	
	@Override
	public void removeGoodsFromCart(OrderVO orderVO) throws DataAccessException{
		sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);
	}
	
	@Override
	public void removeGoodsFromCart(List<OrderVO> myOrderList)throws DataAccessException{
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);		
		}
	}	
	
	@Override
	public List<OrderVO> selectOrderIdList(String cart_id) throws DataAccessException{
		return sqlSession.selectList("mapper.order.selectOrderIdList",cart_id);
	}
	
	@Override
	public int selectOrderID() throws DataAccessException{
		return sqlSession.selectOne("mapper.order.selectOrderID");
		
	}
	@Override
	public List<OrderVO> getOrdersFromCart(String memId, List<Integer> cartIds) throws DataAccessException {
	    return sqlSession.selectList("mapper.order.getOrdersFromCart", cartIds);
	}
	
	@Override
	public void updateMemberPoints(Map<String, String> pointMap) throws DataAccessException{
		sqlSession.update("mapper.order.updateMembersPoints",pointMap);
	}
	
	
	//이포근
	// 일매출 데이터를 가져오는 메서드
	@Override
    public List<OrderVO> selectDailySales(Map<String, Object> condMap) throws DataAccessException {
        return sqlSession.selectList("mapper.order.selectDailySales", condMap);
    }

    // 6개월 단위로 월별 매출 데이터를 가져오는 메서드
    @Override
    public List<OrderVO> selectMonthlySales6Months(Map<String, Object> condMap) throws DataAccessException {
        return sqlSession.selectList("mapper.order.selectMonthlySales6Months", condMap);
    }
    @Override
    public List<OrderVO> selectMonthlySales7Months(Map<String, Object> condMap) throws DataAccessException {
        return sqlSession.selectList("mapper.order.selectMonthlySales7Months", condMap);
    }
    
 // 일매출 데이터를 가져오는 메서드
    public List<OrderVO> selectSellerDailySales(Map<String, Object> condMap) throws DataAccessException {
        return sqlSession.selectList("mapper.order.selectSellerDailySales", condMap);
    }

    // 6개월 단위로 월별 매출 데이터를 가져오는 메서드
    @Override
    public List<OrderVO> selectSellerMonthlySales6Months(Map<String, Object> condMap) throws DataAccessException {
        return sqlSession.selectList("mapper.order.selectSellerMonthlySales6Months", condMap);
    }

    
    //월 주문수
    public List<Map<String, Object>> getMonthlyOrderCount() {
        // selectMonthlyOrderCount 메소드를 호출하여 월별 주문 수를 조회
        return sqlSession.selectList("mapper.order.selectMonthlyOrderCount");
    }
    //
    
    
    @Override
    public int updateOrderId(int order_id) throws DataAccessException {
        return sqlSession.update("mapper.order.updateOrderId", order_id);
    }
    
    @Override
    public List<OrderVO> selectSellerOrderList(String mem_id) throws DataAccessException {
		List<OrderVO> SellerOrdersList = sqlSession.selectList("mapper.order.selectSellerOrderListByID", mem_id);
		System.out.println("dao orderslist #1 : " + SellerOrdersList);
		return SellerOrdersList;
	}
	
	@Override
	public List<OrderVO> selectSellerOrderList_done(String mem_id) throws DataAccessException {
		List<OrderVO> SellerOrdersList_done = sqlSession.selectList("mapper.order.selectSellerClearOrderListByID", mem_id);
		System.out.println("dao orderslist #2 : " + SellerOrdersList_done);
		return SellerOrdersList_done;
	}
	
	
	@Override
	public List selectPossibleReviewList(String mem_id) throws DataAccessException{
		return sqlSession.selectList("mapper.order.selectPossibleReviewList", mem_id);
		
	}
	
	@Override
	public void updateSeqOrderIdStatus(int seq_order_id) throws DataAccessException {
		sqlSession.update("mapper.order.updateSeqOrderIdStatus", seq_order_id);
	}
    
}
