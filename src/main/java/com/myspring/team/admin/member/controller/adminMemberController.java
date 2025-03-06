package com.myspring.team.admin.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.member.vo.MemberVO;

public interface adminMemberController {
	public ModelAndView mgmMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Map<String, Object> modMember(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception;
	public Map<String, Object> delMember(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception;
	public Map<String, Object> modMemberdelyn(@RequestBody MemberVO memberVO, HttpServletRequest request) throws Exception;
}
