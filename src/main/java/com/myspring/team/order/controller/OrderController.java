package com.myspring.team.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.order.vo.OrderVO;

public interface OrderController {
	
	public ModelAndView orderEachGoods(Map<String, String> orderData, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	
	
	public ModelAndView orderResult(@RequestParam(value = "order_id", required = false) String order_id, HttpServletRequest req,HttpServletResponse res) throws Exception;


	public ModelAndView orderFromCart(List<Integer> cartIds, HttpServletRequest request) throws Exception;


	public Map<String, Object> payToOrderGoods(Map<String, String> receiverMap, String selectedOrderListJson,
			HttpServletRequest request, HttpServletResponse response) throws Exception;



	public ModelAndView popupRefund(HttpServletRequest req, HttpServletResponse res) throws Exception;






}
