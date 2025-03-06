package com.myspring.team.cart.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {
	public ModelAndView myCartList(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public Map<String, Object> addCart(Map<String, Object> requestData, HttpServletRequest req) throws Exception;
	public Map<String, Object> deleteCart(int cartId, HttpServletRequest request, HttpServletResponse res) throws Exception;
	public Map<String, Object> updateCart(int cartId, int orderGoodsQty, HttpServletRequest request) throws Exception;
	public Map<String, String> deleteAllCart(HttpSession session) throws Exception;
	
	
	/*
	public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public  @ResponseBody String modifyCartQty(@RequestParam("goods_id") int goods_id,@RequestParam("cart_goods_qty") int cart_goods_qty,
			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	*/
	

}
