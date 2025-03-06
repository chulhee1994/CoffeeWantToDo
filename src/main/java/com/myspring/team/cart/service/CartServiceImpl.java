package com.myspring.team.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.cart.dao.CartDAO;
import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.goods.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl  implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	@Override
	public List<CartVO> selectCartList(String id) throws Exception {
		return cartDAO.selectCartList(id);
	}
	
	@Override
	public boolean checkDuplicateCart(CartVO cartVO) throws Exception{
	        return cartDAO.checkDuplicateCart(cartVO) > 0;
	    }
	
	
	 @Override
	    public int deleteCart(int cartId, String userId) throws Exception{
		 return  cartDAO.deleteCart(cartId, userId);
	    }
	 
	 @Override
		public void deleteAllCart(String mem_id) throws Exception {
				cartDAO.deleteAllCart(mem_id);
		}
	 
	 @Override
	    public int updateCart(int cartId, String memId, int orderGoodsQty) {
	        return cartDAO.updateCart(cartId, memId, orderGoodsQty);
	    }
	 
	
	@Override
	public void addCart(CartVO cartVO) throws Exception {
		cartDAO.addCart(cartVO);
	}
	   @Override
	    public List<CartVO> getCartItemsByIds(List<Integer> cartIds) {
	        return cartDAO.getCartItemsByIds(cartIds);
	    }
	
	
	
	public boolean findCartGoods(CartVO cartVO) throws Exception{
		 return cartDAO.selectCountInCart(cartVO);
		
	}	
	public void addGoodsInCart(CartVO cartVO) throws Exception{
		cartDAO.insertGoodsInCart(cartVO);
	}
	
	public boolean modifyCartQty(CartVO cartVO) throws Exception{
		boolean result=true;
		cartDAO.updateCartGoodsQty(cartVO);
		return result;
	}
	public void removeCartGoods(int cart_id) throws Exception{
		cartDAO.deleteCartGoods(cart_id);
	}
	
}
