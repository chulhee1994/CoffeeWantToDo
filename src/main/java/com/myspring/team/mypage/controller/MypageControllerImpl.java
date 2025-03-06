package com.myspring.team.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.address.service.AddressService;
import com.myspring.team.address.vo.AddressVO;
import com.myspring.team.common.FileUploadUtil;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.member.vo.PointHistoryVO;
import com.myspring.team.mypage.service.MypageService;
import com.myspring.team.order.vo.OrderVO;

@Controller("mypageController")
public class MypageControllerImpl implements MypageController {

	private final FileUploadUtil fileUploadUtil = new FileUploadUtil();
	
	@Autowired
	private AddressService addressService;
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
    private MemberService memberService;

	@RequestMapping(value = "/mypage/myPageUsers.do", method = RequestMethod.GET)
	public ModelAndView myPageUsers (HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		String viewName = getViewName(request);
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기
		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
	    List<AddressVO> addressList = addressService.getAddressByMemberId(mem_id);
	    session.setAttribute("addressList", addressList);
	    List<OrderVO> ordersList = mypageService.listOrders(mem_id);
	    List<OrderVO> ordersList_done = mypageService.listOrders_done(mem_id);
	    List<OrderVO> ordersList_cancel = mypageService.listOrders_cancel(mem_id);
	    session.setAttribute("ordersList", ordersList);
	    session.setAttribute("ordersList_done", ordersList_done);
	    List<PointHistoryVO> pointsList_get = memberService.listPoint_get(mem_id); 
	    List<PointHistoryVO> pointsList_use = memberService.listPoint_use(mem_id);
	    List<PointHistoryVO> pointsList_get_review = memberService.listPoint_get_review(mem_id);
	    
	    
	    System.out.println("orderList : " + ordersList);
	    System.out.println("ordersList_done : " + ordersList_done);
	    System.out.println("ordersList_cancel : " + ordersList_cancel);
		ModelAndView mav = new ModelAndView();
		mav.addObject("addressList", addressList);
		mav.addObject("ordersList", ordersList);
		mav.addObject("ordersList_done", ordersList_done);
		mav.addObject("ordersList_cancel",ordersList_cancel);
		mav.addObject("pointsList_get", pointsList_get);
		mav.addObject("pointsList_use", pointsList_use);
		mav.addObject("pointsList_get_review", pointsList_get_review);
		mav.setViewName(viewName);
		return mav;
	}

	
	@RequestMapping(value = "/mypage/SignOutForm.do", method = RequestMethod.GET)
	public ModelAndView SignOutForm (HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		session.getAttribute("member");
		mav.setViewName(viewName);
		return mav;
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
	
	@RequestMapping(value = "/mypage/image.do")
    public void getImage(@RequestParam("goods_id") int goods_id, 
                         @RequestParam("fileName") String fileName,
                         HttpServletResponse response) throws IOException {
        fileUploadUtil.provideImage(goods_id, fileName, response);
}	
}
