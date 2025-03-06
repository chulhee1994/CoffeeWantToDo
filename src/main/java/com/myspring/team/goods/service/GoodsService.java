package com.myspring.team.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.goods.vo.GoodsVO;

public interface GoodsService {
	 List<GoodsVO> getGoodsListByStatus(Map<String, Object> condMap);
	 public GoodsVO getGoodsDetail(int goodsId);
	 public List<GoodsVO> searchGoodsByQuery(String searchQuery);
	 public List<GoodsVO> getGoodsByWeather(String weatherMain);
	 public List<GoodsVO> getAllGoods() throws DataAccessException;
	 public List<GoodsVO> getGoodsBySeller(String sellerId) throws DataAccessException;	 
}
