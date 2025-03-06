package com.myspring.team.admin.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.admin.member.service.adminMemberService;
import com.myspring.team.member.vo.MemberVO;

@Controller("adminMemberController")
public class adminMemberControllerImpl implements adminMemberController {

	@Autowired
	private adminMemberService adminmemberService;
	
	
	//회원 관리 폼
	@RequestMapping(value = "/admin/member/mgmMemberForm.do", method = RequestMethod.GET)
	public ModelAndView mgmMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		List<MemberVO> membersList = adminmemberService.listMembers();
		ModelAndView mav = new ModelAndView();
		mav.addObject("membersList", membersList);		
		mav.setViewName(viewName);
		return mav;
	}
	//회원 등급 수정
	@RequestMapping(value = "/admin/member/modMemgrade.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> modMember(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception {
		
		Map<String, Object> response = new HashMap<>();   
		
		boolean result = adminmemberService.updateMemberGrade(memberVO);
		
		if(result) {
			response.put("success", true);
	    } else {
	    	response.put("success", false);
	    }
		return response;
	}
	
	//회원 삭제 (테이블에서도 삭제)
		@RequestMapping(value = "/admin/member/delMemgrade.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> delMember(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception {
			
			Map<String, Object> response = new HashMap<>();   
			
			boolean result = adminmemberService.deleteMember(memberVO);
			
			if(result) {
				response.put("success", true);
		    } else {
		    	response.put("success", false);
		    }
			return response;
		}
		
		//회원 탈퇴여부 수정
		@RequestMapping(value = "/admin/member/modMemdelyn.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> modMemberdelyn(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception {
			
			Map<String, Object> response = new HashMap<>();   
			
			boolean result = adminmemberService.updateMemberdelyn(memberVO);
			
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
}
