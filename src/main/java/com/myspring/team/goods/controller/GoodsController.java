package com.myspring.team.goods.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface GoodsController {
	public ModelAndView getGoodsListByStatus(
	            String goods_status, 
	            int section, 
	            int pageNum, 
	            String goods_category, 
	            HttpServletRequest request) throws Exception;
}
