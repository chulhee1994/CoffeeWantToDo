package com.myspring.team.review.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

public interface ReviewDAO {
	public List<ReviewVO> reviewLists(Map<String, Object> pagingMap) throws DataAccessException;
	public int selectToReviews() throws DataAccessException;

	public int selectSearchToReviews(Map searchMap) throws DataAccessException;
	public List<ReviewVO> searchReviewLists(Map searchMap) throws DataAccessException;

	
	public int getToReviews(Map<String, Object> searchMap) throws DataAccessException;
	public List<ReviewVO> getReviewsByGoodsId(Map searchMap) throws DataAccessException;
	public ReviewVO viewReview(int review_no) throws DataAccessException;

	public void updateReview(Map<String, Object> reviewMap) throws DataAccessException;
	public List<ImageFileVO> selectReviewImages(int review_no) throws DataAccessException;

	public void incrementLike(int review_no) throws DataAccessException;

	public void deleteReviewImage(int review_no, String fileName) throws DataAccessException;
	public void deleteReviewImages(String imagePath) throws Exception;
	public void deleteReview(int review_no) throws DataAccessException;
	public void deleteReviewImagesNames(int review_no) throws DataAccessException;


	public void addReviewImage(Map<String, Object> imageMap) throws DataAccessException;

	public int addReview(Map reviewsMap) throws DataAccessException;
	public void updateViews(int review_no) throws DataAccessException;
	
	public List<ReviewVO> getAllReviews(String memId) throws DataAccessException;
	public List<ImageFileVO> getImagesForReview(int reviewNo) throws Exception;
}




