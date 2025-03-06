package com.myspring.team.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.cart.vo.CartVO;

public interface CartService {
	//장바구니 리스트 조회 기능
	public List<CartVO> selectCartList(String id) throws Exception;
	boolean checkDuplicateCart(CartVO cartVO) throws Exception;
	public void addCart(CartVO cartVO) throws Exception;
	public int deleteCart(int cartId, String userId) throws Exception;
	public int updateCart(int cartId, String memId, int orderGoodsQty) throws Exception;
	public List<CartVO> getCartItemsByIds(List<Integer> cartIds) throws Exception;
	public void deleteAllCart(String mem_id) throws Exception;
	
	public boolean findCartGoods(CartVO cartVO) throws Exception;
	public void addGoodsInCart(CartVO cartVO) throws Exception;
	public boolean modifyCartQty(CartVO cartVO) throws Exception;
	public void removeCartGoods(int cart_id) throws Exception;

}
