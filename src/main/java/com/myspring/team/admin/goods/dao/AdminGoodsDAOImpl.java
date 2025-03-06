package com.myspring.team.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;



@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl implements AdminGoodsDAO {

    @Autowired
    private SqlSession sqlSession;

  

    // 상품 등록 처리
    @Override
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
		sqlSession.insert("mapper.admin.goods.insertNewGoods",newGoodsMap);
		return (Integer) newGoodsMap.get("goods_id");
	}
	
	@Override
	public void insertGoodsImageFile(List fileList)  throws DataAccessException {
		for(int i=0; i<fileList.size();i++){
			ImageFileVO imageFileVO=(ImageFileVO)fileList.get(i);
			sqlSession.insert("mapper.admin.goods.insertGoodsImageFile",imageFileVO);
		}
	}
	public List<GoodsVO> selectGoodsList(Map<String, Object> condMap) {
	    return sqlSession.selectList("mapper.goods.selectGoodsList", condMap);  // 기존 메서드 그대로 사용
	}
	
	public List<GoodsVO> selectGoodsListseller(Map<String, Object> condMap) {
	    return sqlSession.selectList("mapper.goods.selectGoodsListseller", condMap);  // 기존 메서드 그대로 사용
	}
	 public List<GoodsVO> getmodgoodsForm(int goodsId) {
	        // SQL 쿼리 실행: goodsId에 맞는 상품과 이미지를 가져옵니다.
	        return sqlSession.selectList("mapper.goods.selectGoodsDetail", goodsId);
	    }
	  // 상품 정보 업데이트
	    public void updateGoods(Map<String, Object> updatedGoodsMap) throws Exception {
	        sqlSession.update("mapper.admin.goods.updateGoods", updatedGoodsMap);
	    }

	    // 이미지 파일 업데이트
	    public void updateGoodsImageFile(List<ImageFileVO> fileList) throws Exception {
	        for (int i = 0; i < fileList.size(); i++) {
	            ImageFileVO imageFileVO = fileList.get(i);
	            sqlSession.update("mapper.admin.goods.updateGoodsImageFile", imageFileVO);
	        }
	    }

	    // 상품 이미지 파일 정보 삭제 (DB에서만 삭제)
	    public void deleteGoodsImageFile(Map<String, Object> deletedGoodsMap) throws Exception {
	        sqlSession.delete("mapper.admin.goods.deleteGoodsImageFile", deletedGoodsMap);
	    }

	    // 상품 삭제
	    public void deleteGoods(Map<String, Object> deletedGoodsMap) throws Exception {
	        sqlSession.delete("mapper.admin.goods.deleteGoods", deletedGoodsMap);
	    }
	    //모드서치굿즈
	    public List<GoodsVO> selectGoodsWithMainImage(String searchQuery) {
	        return sqlSession.selectList("mapper.admin.goods.modselectGoodsWithMainImage", searchQuery);
	        
	    }
	    // updateN 메서드는 goods_id로 goods_status를 'Y'로 업데이트하는 쿼리 호출
	    public int updateGoodsStatusToY(int goods_id) {
	        return sqlSession.update("updateN", goods_id);
	    }
	    
	    @Override
        public List<GoodsVO> getGoodsForCarousel() {
            try {
                return sqlSession.selectList("mapper.goods.getGoodsForCarousel");
            } catch (PersistenceException e) {
                // 예외 처리
                e.printStackTrace();
                return null;
            }
        }
	    
	    //이포근
	    public List<GoodsVO> selectGoodsList2(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectGoodsList2", condMap);  // 기존 메서드 그대로 사용
	    }
		
		public List<GoodsVO> selectGoodsList3(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectGoodsList3", condMap);  // 기존 메서드 그대로 사용
	    }
		
		public List<GoodsVO> selectGoodsList4(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectGoodsList4", condMap);  // 기존 메서드 그대로 사용
	    }
		
		public List<GoodsVO> selectSellerGoodsList2(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectSellerGoodsList2", condMap);  // 기존 메서드 그대로 사용
	    }
	    
	    public List<GoodsVO> selectSellerGoodsList3(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectSellerGoodsList3", condMap);  // 기존 메서드 그대로 사용
	    }
	    
	    public List<GoodsVO> selectSellerGoodsList4(Map<String, Object> condMap) {
	        return sqlSession.selectList("mapper.goods.selectSellerGoodsList4", condMap);  // 기존 메서드 그대로 사용
	    }
	    
}
