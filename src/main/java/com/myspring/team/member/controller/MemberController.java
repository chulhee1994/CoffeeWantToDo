package com.myspring.team.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myspring.team.member.vo.MemberVO;

public interface MemberController {

	public ModelAndView login(@ModelAttribute("member") MemberVO member, RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView removeMember(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modMembers(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modDefaultAddress(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity overlapped(@RequestParam("mem_id") String mem_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  addCommon(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  addSeller(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modInfo(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView findId(@RequestParam(value= "mem_name",defaultValue = "") String mem_name ,@RequestParam(value= "mem_email1",defaultValue = "") String mem_email1 ,@RequestParam(value= "mem_email2",defaultValue = "") String mem_email2 ,HttpServletRequest request ,HttpServletResponse response) throws Exception;
    public ModelAndView findPwd(@RequestParam(value= "mem_id",defaultValue = "") String mem_id ,@RequestParam(value= "mem_pwd",defaultValue = "") String mem_pwd ,HttpServletRequest request ,HttpServletResponse response) throws Exception;
    public String sendMemPwdCa(@ModelAttribute MemberVO memberVO) throws Exception;
    public @ResponseBody String emailVerification(@RequestParam(value = "email", required = false) String email,  // Single email address field
            @RequestParam("sendCode") String sendCode,
            HttpSession session) throws Exception;
    public ResponseEntity addKakao(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
    public ModelAndView agree(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
