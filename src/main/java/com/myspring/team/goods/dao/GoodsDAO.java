package com.myspring.team.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.goods.vo.GoodsVO;

public interface GoodsDAO {
	public List<GoodsVO> selectGoodsList(Map<String, Object> condMap);
	public List<GoodsVO> getGoodsDetail(int goodsId);
	public List<GoodsVO> selectGoodsWithMainImage(String searchQuery);
	public List<GoodsVO> selectGoodsByWeather(String weatherMain);
	public List<GoodsVO> selectAllGoods() throws DataAccessException;
	public List<GoodsVO> selectGoodsBySeller(String sellerId) throws DataAccessException;
	
	public void updateStock(Map stockMap) throws DataAccessException;
	public GoodsVO getGoodsById(int goods_id) throws DataAccessException;
}
