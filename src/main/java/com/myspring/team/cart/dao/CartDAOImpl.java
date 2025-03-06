package com.myspring.team.cart.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.goods.vo.GoodsVO;

@Repository("cartDAO")
public class CartDAOImpl  implements  CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CartVO> selectCartList(String id) throws DataAccessException {
		return sqlSession.selectList("mapper.cart.selectCartList", id);
	}
	
	@Override
	public int addCart(CartVO cartVO) throws DataAccessException {
		int rows = sqlSession.insert("mapper.cart.addCart", cartVO);
		return rows;
	}
	
	@Override
	  public int checkDuplicateCart(CartVO cartVO) {
	        return sqlSession.selectOne("mapper.cart.checkDuplicateCart", cartVO);
	   }
	
	 @Override
	    public int deleteCart(int cartId, String userId) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("cartId", cartId);
	        params.put("userId", userId);
	        return sqlSession.delete("mapper.cart.deleteCart", params);
	    }
	 
	    @Override
	    public int updateCart(int cartId, String memId, int orderGoodsQty) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("cartId", cartId);
	        params.put("memId", memId);
	        params.put("orderGoodsQty", orderGoodsQty);
	        return sqlSession.update("mapper.cart.updateCart", params);
	    }
	
	    @Override
	    public List<CartVO> getCartItemsByIds(List<Integer> cartIds) {
	        return sqlSession.selectList("mapper.cart.getCartItemsByIds", cartIds);
	    }
	    
	    // ✅ 여러 개의 장바구니 아이템 삭제
	    @Override
	    public void deleteCartItems(Map<String, Object> paramMap) {
	        sqlSession.delete("mapper.cart.deleteCartItems", paramMap);
	    }

	    
	    
	    
	    
	
	
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String  result =sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		return Boolean.parseBoolean(result);
	}

	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException{
		int cart_id=selectMaxCartId();
		cartVO.setCart_id(cart_id);
		sqlSession.insert("mapper.cart.insertGoodsInCart",cartVO);
	}
	
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException{
		sqlSession.insert("mapper.cart.updateCartGoodsQty",cartVO);
	}
	
	public void deleteCartGoods(int cart_id) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteCartGoods",cart_id);
	}

	private int selectMaxCartId() throws DataAccessException{
		int cart_id =sqlSession.selectOne("mapper.cart.selectMaxCartId");
		return cart_id;
	}

	@Override
	public void deleteAllCart(String mem_id) throws DataAccessException {
		sqlSession.delete("mapper.cart.deleteAllCart",mem_id);
	}

	 

}
