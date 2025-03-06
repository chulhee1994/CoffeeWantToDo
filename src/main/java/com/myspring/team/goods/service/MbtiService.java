package com.myspring.team.goods.service;

import java.util.List;
import com.myspring.team.goods.vo.GoodsVO;

public interface MbtiService {
	
	public List<GoodsVO> getGoodsByMBTI(String mbti) throws Exception;
	
}
