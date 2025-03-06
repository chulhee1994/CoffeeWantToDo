package com.myspring.team.admin.order.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

public interface adminOrderController {

	public ModelAndView mgmOrderForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Map<String, Object> modOrderDeliverystate(@RequestBody OrderVO orderVO, HttpServletRequest request) throws Exception;
}
