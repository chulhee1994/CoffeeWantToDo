package com.myspring.team.review.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface ReviewController {
	
	//리뷰 리스트 출력
	public ModelAndView reviewList(HttpServletRequest req, HttpServletResponse res) throws Exception;
	public ModelAndView searchReviewLists(Map<String, String> searchParams, HttpServletRequest req) throws Exception;
	
	//리뷰 작성 폼
	public ModelAndView reviewForm(HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	//리뷰 상품 리스트 출력
	public ModelAndView reviewProducts(HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	//상품 상세 폼
	public ModelAndView viewReview(int review_no, HttpServletRequest req, HttpServletResponse res) throws Exception;
	//상품 작성 폼
	
	//리뷰 수정 폼
		public ModelAndView editReview(int review_no, HttpServletRequest req, HttpServletResponse res) throws Exception;
		public ResponseEntity<String> updateReview(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception;


		public ResponseEntity deleteReview(int review_no,HttpServletRequest req, HttpServletResponse res) throws Exception;

		//좋아요 증가
		public ResponseEntity<Map<String, Object>> incrementLike(HttpServletRequest req, HttpServletResponse res,
				HttpSession session) throws Exception;

		public ResponseEntity<String> addReview(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception;

	
}
