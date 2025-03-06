package com.myspring.team.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;

public interface AdminGoodsService {
	public int  addNewGoods(Map newGoodsMap) throws Exception;
	public void addNewGoodsImage(List imageFileList) throws Exception;
	public List<GoodsVO> getGoodsListByStatus(Map<String, Object> condMap);
	public GoodsVO getmodgoodsForm(int goodsId);
	  // 상품과 이미지 파일 업데이트
	public void updateGoods(Map<String, Object> updatedGoodsMap) throws Exception;
	public void updateGoodsImageFile(List<ImageFileVO> imageFileList) throws Exception; 
	 public void deleteGoods(Map<String, Object> deletedGoodsMap) throws Exception;
	 public void deleteGoodsImage(int goodsId) throws Exception;
	 public List<GoodsVO> searchGoodsByQuery(String searchQuery);
	 public void updateGoodsStatusToY(int goods_id);
	 //이포근
	 public List<GoodsVO> getGoodsListByStatus2(Map<String, Object> condMap);
		public List<GoodsVO> getGoodsListByStatus3(Map<String, Object> condMap);
		public List<GoodsVO> getGoodsListByStatus4(Map<String, Object> condMap);
		public List<GoodsVO> getSellerGoodsListByStatus2(Map<String, Object> condMap);
	    public List<GoodsVO> getSellerGoodsListByStatus3(Map<String, Object> condMap);
	    public List<GoodsVO> getSellerGoodsListByStatus4(Map<String, Object> condMap);
	    public List<GoodsVO> getGoodsListByStatusseller(Map<String, Object> condMap);
}
