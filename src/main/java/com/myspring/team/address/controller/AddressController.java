package com.myspring.team.address.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.address.vo.AddressVO;

public interface AddressController {
	public ModelAndView getAddressList(HttpServletRequest request) throws Exception;	
	public ModelAndView addAddress(AddressVO address, HttpServletRequest request) throws Exception;
	public ModelAndView modAddress(@ModelAttribute("address") AddressVO address, HttpServletRequest request) throws Exception;
	public ModelAndView delAddress(@ModelAttribute("address") AddressVO address, HttpServletRequest request) throws Exception;
}
