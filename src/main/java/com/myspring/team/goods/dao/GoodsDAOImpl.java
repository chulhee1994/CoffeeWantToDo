package com.myspring.team.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.goods.vo.GoodsVO;


@Repository("goodsDAO")
public class GoodsDAOImpl implements GoodsDAO{
	@Autowired
	private SqlSession sqlSession;
	public List<GoodsVO> selectGoodsList(Map<String, Object> condMap) {
	    return sqlSession.selectList("mapper.goods.selectGoodsList", condMap);  // 기존 메서드 그대로 사용
	}
	 public List<GoodsVO> getGoodsDetail(int goodsId) {
	        // SQL 쿼리 실행: goodsId에 맞는 상품과 이미지를 가져옵니다.
	        return sqlSession.selectList("mapper.goods.selectGoodsDetail", goodsId);
	    }
	    // MyBatis 매퍼를 호출하여 상품 목록 조회 (GoodsVO로 변환)
	 
	    public List<GoodsVO> selectGoodsWithMainImage(String searchQuery) {
	        return sqlSession.selectList("selectGoodsWithMainImage", searchQuery);
	        
	    }
	    // 날씨 정보에 맞는 상품을 검색하는 메서드
	    public List<GoodsVO> selectGoodsByWeather(String weatherMain) {
	    	System.out.println("dao날씨 정보: " + weatherMain); 
	    	return sqlSession.selectList("mapper.goods.selectwegoods", weatherMain); 
	    }
	    
	    public List<GoodsVO> selectAllGoods() throws DataAccessException {
	        return sqlSession.selectList("mapper.goods.selectAllGoods");
	    }

	    public List<GoodsVO> selectGoodsBySeller(String sellerId) throws DataAccessException {
	        return sqlSession.selectList("mapper.goods.selectGoodsBySeller", sellerId);
	    }
	    
	    //재고수 떨구기 
		@Override
		public void updateStock(Map stockMap) throws DataAccessException {
			sqlSession.update("mapper.goods.updateStock", stockMap);
			
		}
		
		@Override
        public GoodsVO getGoodsById(int goods_id) throws DataAccessException {
            return sqlSession.selectOne("mapper.goods.getGoodsById", goods_id);
        }
}
