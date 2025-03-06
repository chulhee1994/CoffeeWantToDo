package com.myspring.team.seller.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface SellerController {
    
    public ModelAndView SellerOrderList (HttpServletRequest request, HttpServletResponse response) throws Exception;
}
