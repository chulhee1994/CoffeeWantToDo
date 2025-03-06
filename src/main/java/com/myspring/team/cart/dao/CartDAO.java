package com.myspring.team.cart.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.goods.vo.GoodsVO;

public interface CartDAO {
	public List<CartVO> selectCartList(String id) throws DataAccessException;
	public int addCart(CartVO cartVO) throws DataAccessException;
	public int checkDuplicateCart(CartVO cartVO) throws DataAccessException;
	public int deleteCart(int cartId, String userId) throws DataAccessException;
	public int updateCart(int cartId, String memId, int orderGoodsQty) throws DataAccessException;
	public List<CartVO> getCartItemsByIds(List<Integer> cartIds) throws DataAccessException;
	public void deleteCartItems(Map<String, Object> paramMap) throws DataAccessException;
	

	
	
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException;
	public void deleteCartGoods(int cart_id) throws DataAccessException;
	public void deleteAllCart(String mem_id) throws DataAccessException;


	
	

}
