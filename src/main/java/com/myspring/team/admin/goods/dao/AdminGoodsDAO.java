package com.myspring.team.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;

public interface AdminGoodsDAO {
    // 상품 등록 메소드
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	public void insertGoodsImageFile(List fileList)  throws DataAccessException;
	public List<GoodsVO> selectGoodsList(Map<String, Object> condMap);
	 public List<GoodsVO> getmodgoodsForm(int goodsId);
	 public void updateGoodsImageFile(List<ImageFileVO> imageFileList) throws Exception;
	 public void updateGoods(Map<String, Object> updatedGoodsMap) throws Exception;
	 public void deleteGoodsImageFile(Map<String, Object> deletedGoodsMap) throws Exception;
	 public void deleteGoods(Map<String, Object> deletedGoodsMap) throws Exception;
	 public List<GoodsVO> selectGoodsWithMainImage(String searchQuery);
	 public int updateGoodsStatusToY(int goods_id);
	 public List<GoodsVO> getGoodsForCarousel();
	 
	 //이포근
	 public List<GoodsVO> selectGoodsList2(Map<String, Object> condMap);
		public List<GoodsVO> selectGoodsList3(Map<String, Object> condMap);
		public List<GoodsVO> selectGoodsList4(Map<String, Object> condMap);
		public List<GoodsVO> selectSellerGoodsList2(Map<String, Object> condMap);
	    public List<GoodsVO> selectSellerGoodsList3(Map<String, Object> condMap);
	    public List<GoodsVO> selectSellerGoodsList4(Map<String, Object> condMap);
	    public List<GoodsVO> selectGoodsListseller(Map<String, Object> condMap);
}
