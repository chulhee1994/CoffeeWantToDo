package com.myspring.team.notice.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.notice.vo.NoticeVO;

public interface NoticeController {
	
	//공지사항 게시판 리스트 전체 출력
	public ModelAndView listNotices(HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	//공지시항 글 작성 폼 출력
	public ModelAndView noticeForm(HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	//공지사항 상세글 정보 출력
	public ModelAndView editNotice(int notice_no, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public ModelAndView viewNotice(@RequestParam(required = false) int  notice_no, HttpServletRequest req, HttpServletResponse res);

	
	
	public ResponseEntity addNotice(MultipartHttpServletRequest multipartReq, HttpServletResponse res)
			throws Exception;
	
	public ResponseEntity deleteNotice(int notice_no, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public ResponseEntity updateNotice(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception;
	public ModelAndView searchNoticeLists(Map<String, String> searchParams, HttpServletRequest request);











}
