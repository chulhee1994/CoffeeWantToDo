package com.myspring.team.address.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.address.service.AddressService;
import com.myspring.team.address.vo.AddressVO;

import com.myspring.team.member.vo.MemberVO;

@Controller("addressController")
public class AddressControllerImpl implements AddressController {

	@Autowired
	private AddressService addressService;

	@Autowired
	private AddressVO addressVO;

	// 배송지 리스트 가져오기
	@Override
	@RequestMapping(value = "/address/addressList.do", method = RequestMethod.GET)
	public ModelAndView getAddressList(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기

		if (member == null) {
			throw new IllegalStateException("member is missing from session");
		}

		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
		List<AddressVO> addressList = addressService.getAddressByMemberId(mem_id);
		session.setAttribute("addressList", addressList);
		ModelAndView mav = new ModelAndView("redirect:/mypage/myPageUsers.do");
		mav.addObject("addressList", addressList);
		return mav;
	}

	// 배송지 추가 메소드
	@Override
	@RequestMapping(value = "/address/addAddress.do", method = RequestMethod.POST)
	public ModelAndView addAddress(AddressVO address, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기

		if (member == null) {
			throw new IllegalStateException("member is missing from session");
		}

		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
		address.setMem_id(mem_id); // 주소에 mem_id 설정
		addressService.addAddress(address);
		session.setAttribute("addressList", address); // 세션에 주소 정보 저장

		ModelAndView mav = new ModelAndView("redirect:/address/addressList.do");
		return mav;
	}

	// 배송지 수정 메소드
	@Override
	@RequestMapping(value = "/address/modAddress.do", method = RequestMethod.POST)
	public ModelAndView modAddress(@ModelAttribute("address") AddressVO address, HttpServletRequest request)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기

		if (member == null) {
			throw new IllegalStateException("member is missing from session");
		}

		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
		address.setMem_id(mem_id); // 주소에 mem_id 설정
		addressService.modAddress(address);
		session.setAttribute("addressList", address); // 세션에 수정된 주소 정보 저장

		ModelAndView mav = new ModelAndView("redirect:/address/addressList.do");
		return mav;
	}

	// 배송지 삭제 메소드
	@Override
	@RequestMapping(value = "/address/delAddress.do", method = RequestMethod.POST)
	public ModelAndView delAddress(@ModelAttribute("address") AddressVO address, HttpServletRequest request)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기

		if (member == null) {
			throw new IllegalStateException("member is missing from session");
		}

		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
		address.setMem_id(mem_id); // 주소에 mem_id 설정
		System.out.println("address_id: " + address.getAddress_id()); // 디버깅
		addressService.delAddress(address);
		session.removeAttribute("addressList"); // 세션 삭제
		session.setAttribute("addressList", address); // 세션에 수정된 주소 정보 저장

		ModelAndView mav = new ModelAndView("redirect:/address/addressList.do");
		return mav;
	}

	// 배송지 추가 폼
	@RequestMapping(value = "/address/addAddressForm.do", method = RequestMethod.GET)
	public ModelAndView addform(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기

		if (member == null) {
			throw new IllegalStateException("member is missing from session");
		}

		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
		ModelAndView mav = new ModelAndView();
		mav.addObject("mem_id", mem_id);
		return mav;
	}

	// 배송지 수정 폼
	@RequestMapping(value = "/address/modAddressForm.do", method = RequestMethod.GET)
	public ModelAndView modForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int address_id = Integer.parseInt(request.getParameter("address_id"));
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("address_id", address_id);
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
}
