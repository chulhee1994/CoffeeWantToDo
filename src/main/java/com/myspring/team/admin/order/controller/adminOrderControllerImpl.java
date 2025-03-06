package com.myspring.team.admin.order.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.admin.order.service.adminOrderService;
import com.myspring.team.common.FileUploadUtil;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;

@Controller("adminOrderController")
public class adminOrderControllerImpl implements adminOrderController {

	private final FileUploadUtil fileUploadUtil = new FileUploadUtil();
	
	@Autowired
	private adminOrderService adminOrderService;
	
	//회원 관리 폼
		@RequestMapping(value = "/admin/order/mgmOrderForm.do", method = RequestMethod.GET)
		public ModelAndView mgmOrderForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String viewName = getViewName(request);
			List<OrderVO> ordersList = adminOrderService.listOrders();
			System.out.println(ordersList);
			ModelAndView mav = new ModelAndView();
			mav.addObject("ordersList", ordersList);
			mav.setViewName(viewName);
			return mav;
		}
		
		
		//주문 배송상태 수정
		@RequestMapping(value = "/admin/order/modDeliveryState.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> modOrderDeliverystate(@RequestBody OrderVO orderVO, HttpServletRequest request) throws Exception {
					
			Map<String, Object> response = new HashMap<>();   
					
			boolean result = adminOrderService.updateOrderDeliveryState(orderVO);
					
			if(result) {
				response.put("success", true);
				  } else {
				response.put("success", false);
				  }
			return response;
		}				
		
		private String getViewName(HttpServletRequest request) throws Exception {
			String contextPath = request.getContextPath();
			String uri = request.getRequestURI();

			if (uri.startsWith(contextPath)) {
				uri = uri.substring(contextPath.length());
			}
			int end = uri.indexOf(".");
			if (end != -1) {
				uri = uri.substring(0, end);
			}
			System.out.println("Returning view name: " + uri);

			return uri;
		}	
		
		@RequestMapping(value = "/admin/order/image.do")
	    public void getImage(@RequestParam("goods_id") int goods_id, 
	                         @RequestParam("fileName") String fileName,
	                         HttpServletResponse response) throws IOException {
	        fileUploadUtil.provideImage(goods_id, fileName, response);
	}	
}
