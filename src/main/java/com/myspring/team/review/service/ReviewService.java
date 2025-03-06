package com.myspring.team.review.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

public interface ReviewService {
	public Map reviewLists(Map<String, Object> pagingMap) throws DataAccessException;
	public Map<String, Object> searchReviewLists(Map<String, Object> searchMap) throws DataAccessException;
	public Map getReviewsList(Map<String, Object> searchMap) throws DataAccessException;

	public ReviewVO viewReview(int review_no) throws DataAccessException;

	public void updateReview(Map<String, Object> reviewMap) throws DataAccessException;
	public List<ImageFileVO> selectReviewImages(int review_no)  throws DataAccessException;

	public void incrementLike(int review_no) throws DataAccessException;

	public void deleteReview(int review_no, String reviewImagePath) throws DataAccessException;
	public void deleteReviewImage(int review_no, String fileName) throws DataAccessException;

	public List<ReviewVO> selectPossibleReviewList(String mem_id) throws DataAccessException;

	public int addReview(Map recipesMap) throws DataAccessException;

	public void addReviewImage(Map<String, Object> imageMap) throws DataAccessException;
	
	public void updateViews(int review_no) throws DataAccessException;
	
	public List<ReviewVO> getAllReviews(String memId) throws DataAccessException;

	public List<ImageFileVO> getImagesForReview(int reviewNo) throws Exception;

}



