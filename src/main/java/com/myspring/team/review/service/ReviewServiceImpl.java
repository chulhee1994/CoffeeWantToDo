package com.myspring.team.review.service;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myspring.team.goods.service.GoodsService;
import com.myspring.team.order.dao.OrderDAO;
import com.myspring.team.order.vo.OrderVO;
import com.myspring.team.recipe.vo.RecipeVO;
import com.myspring.team.review.dao.ReviewDAO;
import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

@Service("reviewService")
@Transactional(rollbackFor = Exception.class) // 트랜잭션 적용 및 예외 시 롤백
public class ReviewServiceImpl  implements ReviewService{
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private OrderDAO orderDAO;

	@Override
	public Map reviewLists(Map<String, Object> pagingMap) throws DataAccessException {
		Map reviewsMap = new HashMap();
		
		List<ReviewVO> reviewList = reviewDAO.reviewLists(pagingMap);
		int toReviews = reviewDAO.selectToReviews();
		reviewsMap.put("reviewList", reviewList);
		reviewsMap.put("toReviews", toReviews);
		return reviewsMap;
	}
	
	 @Override
	 public Map searchReviewLists(Map searchMap) throws DataAccessException {
		Map<String, Object> reviewsMap = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.searchReviewLists(searchMap);
		int toSearchReviews = reviewDAO.selectSearchToReviews(searchMap);
		
		reviewsMap.put("reviewList", reviewList);
		reviewsMap.put("toReviews", toSearchReviews);
		reviewsMap.put("section",searchMap.get("section"));
		reviewsMap.put("pageNum", searchMap.get("pageNum"));
		
		 return reviewsMap;
	    }
	 
	 @Override
		public Map getReviewsList(Map<String, Object> searchMap) throws DataAccessException {
			Map<String, Object> reviewsMap = new HashMap<String, Object>();
			
			List<ReviewVO> reviewList = reviewDAO.getReviewsByGoodsId(searchMap);
			int getToReviews = reviewDAO.getToReviews(searchMap);
			
			reviewsMap = new HashMap<String, Object>();
			
			reviewsMap.put("reviewList", reviewList);
			reviewsMap.put("getToReviews", getToReviews);
			reviewsMap.put("review_section", searchMap.get("review_section"));
			reviewsMap.put("review_pageNum", searchMap.get("review_pageNum"));
			
			return reviewsMap;
		}
	
	

	@Override
	@Transactional
	public int addReview(Map reviewsMap) throws DataAccessException {
		int review_no = reviewDAO.addReview(reviewsMap);
		
		int seq_order_id =  Integer.parseInt(reviewsMap.get("seq_order_id").toString());
						orderDAO.updateSeqOrderIdStatus(seq_order_id);
		return review_no;
	}
	@Override
	public void addReviewImage(Map<String, Object> imageMap) throws DataAccessException {
		reviewDAO.addReviewImage(imageMap);
	}
	@Override
	public ReviewVO viewReview(int review_no) throws DataAccessException {
		return reviewDAO.viewReview(review_no); 
	}
	
    @Override
    public void updateReview(Map<String, Object> reviewMap) throws DataAccessException  {
        reviewDAO.updateReview(reviewMap);
    }
	
	@Override
	public List<ImageFileVO> selectReviewImages(int review_no) throws DataAccessException {
		return reviewDAO.selectReviewImages(review_no);
	}

	@Override
	public void incrementLike(int review_no) throws DataAccessException {
		reviewDAO.incrementLike(review_no);
	}
	
	   @Override
	    public void deleteReviewImage(int review_no, String fileName)  throws DataAccessException {
	        reviewDAO.deleteReviewImage(review_no, fileName);
	    }
	
	
	@Override
	@Transactional
	public void deleteReview(int review_no, String reviewImagePath) throws DataAccessException {
		
			//서버의 이미지 삭제 
			try {
				reviewDAO.deleteReviewImages(reviewImagePath);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//이미지 테이블의 이미지 이름 삭제 
			reviewDAO.deleteReviewImagesNames(review_no);
			
			//리뷰테이블에 리뷰게시글 삭제
			reviewDAO.deleteReview(review_no);
	}

	@Override
	public List selectPossibleReviewList(String mem_id) throws DataAccessException {
		return orderDAO.selectPossibleReviewList(mem_id);
	}

	@Override
	public void updateViews(int review_no) throws DataAccessException {
		reviewDAO.updateViews(review_no);
	}
	
	@Override
	public List<ReviewVO> getAllReviews(String memId) throws DataAccessException {
	    // ReviewDAO에서 모든 리뷰를 조회하는 메서드를 호출하여 반환
	    return reviewDAO.getAllReviews(memId);
	}

	@Override
	public List<ImageFileVO> getImagesForReview(int reviewNo) throws Exception {
	    return reviewDAO.getImagesForReview(reviewNo);
	}
}
