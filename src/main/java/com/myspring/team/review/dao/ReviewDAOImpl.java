package com.myspring.team.review.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int selectToReviews() throws DataAccessException {
	    Integer toReviews = sqlSession.selectOne("mapper.review.selectToReviews");
	    return (toReviews != null) ? toReviews : 0;  // 기본값을 0으로 설정
	}

	
	@Override
	public List<ReviewVO> reviewLists(Map pagingMap) throws DataAccessException {
		List<ReviewVO> reivewList =  sqlSession.selectList("mapper.review.reviewLists",pagingMap);
		return reivewList;
	}
	
	@Override
	public int selectSearchToReviews(Map searchMap) throws DataAccessException {
		int toSearchReviews = sqlSession.selectOne("mapper.review.selectSearchToReviews",searchMap);
		return toSearchReviews;
	}
	
	 @Override
	    public List<ReviewVO> searchReviewLists(Map searchMap) throws DataAccessException{
	        return sqlSession.selectList("mapper.review.searchReviewLists", searchMap);
	    }
	
		@Override
		public int getToReviews(Map<String, Object> searchMap) throws DataAccessException {
			int getTOReviews = sqlSession.selectOne("mapper.review.getToReviews", searchMap);
			return getTOReviews;
		}
	 
	 
	 @Override
	    public List<ReviewVO> getReviewsByGoodsId(Map searchMap) throws DataAccessException{
	        return sqlSession.selectList("mapper.review.getReviewsByGoodsId", searchMap);
	    }
	 
	
	@Override
	@Transactional
	public int addReview(Map reviewsMap) throws DataAccessException {
		int review_no = sqlSession.selectOne("mapper.review.seq_review_no_nextval");
		
		reviewsMap.put("review_no", review_no);
		sqlSession.insert("mapper.review.addReview", reviewsMap);
		return review_no;
	}
	
	@Override
	public void addReviewImage(Map<String, Object> imageMap) throws DataAccessException {
	    sqlSession.insert("mapper.review.insertReviewImage", imageMap);
	}
	
	

	@Override
	public ReviewVO viewReview(int review_no) throws DataAccessException {
		return sqlSession.selectOne("mapper.review.viewReview", review_no);
	}
	@Override
	public List<ImageFileVO> selectReviewImages(int review_no) throws DataAccessException {
		return sqlSession.selectList("mapper.review.selectReviewImages",review_no);
	}
	   @Override
	    public void updateReview(Map<String, Object> reviewMap) throws DataAccessException {
	        sqlSession.update("mapper.review.updateReview", reviewMap);
	    }

	@Override
	public void incrementLike(int review_no) throws DataAccessException {
		sqlSession.update("mapper.review.incrementLike", review_no);
	}
	
    @Override
    public void deleteReviewImage(int review_no, String fileName)  throws DataAccessException {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("review_no", review_no);
        paramMap.put("fileName", fileName);
        sqlSession.delete("mapper.review.deleteReviewImage", paramMap);
    }
	
	//리뷰삭제시에 필요 
	@Override
    public void deleteReviewImages(String imagePath) throws Exception {
        File folder = new File(imagePath);
        System.out.println("삭제 이미지 경로: " + imagePath); 
        if (folder.exists() && folder.isDirectory()) {
            for (File file : folder.listFiles()) {
                if (file.isFile()) {
                    if (!file.delete()) {
                        throw new Exception("파일 삭제 실패: " + file.getName());
                    }
                }
            }
            if (!folder.delete()) {
                throw new Exception("이미지 폴더 삭제 실패");
            }
        }
    }

	@Override
	public void deleteReview(int review_no) throws DataAccessException {
		sqlSession.delete("mapper.review.deleteReview",review_no);
	}
	@Override
	public void deleteReviewImagesNames(int review_no) throws DataAccessException {
		sqlSession.delete("mapper.review.deleteReviewImagesNames",review_no);
	}
	//리뷰삭제시에 필요 


	@Override
	public void updateViews(int review_no) throws DataAccessException {
		sqlSession.update("mapper.review.updateViews", review_no);
	}
	
	
	
	// 모든 리뷰를 가져오는 메서드
	@Override
	public List<ReviewVO> getAllReviews(String memId) throws DataAccessException {
	    // MyBatis 쿼리를 통해 모든 리뷰를 조회합니다.
	    return sqlSession.selectList("mapper.review.getAllReviews", memId);
	}


	@Override
	public List<ImageFileVO> getImagesForReview(int reviewNo) throws Exception {
	    return sqlSession.selectList("mapper.review.selectReviewImages", reviewNo);
	}



}



