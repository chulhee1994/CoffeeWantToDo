package com.myspring.team.goods.dao;

import org.springframework.dao.DataAccessException;
import java.util.List;

import com.myspring.team.goods.vo.GoodsVO;

public interface MbtiDAO {
	public List<GoodsVO> selectGoodsByMBTI(String mbti) throws DataAccessException;
	
}
