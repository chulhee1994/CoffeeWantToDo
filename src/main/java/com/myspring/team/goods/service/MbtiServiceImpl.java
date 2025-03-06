package com.myspring.team.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.team.goods.dao.MbtiDAO;
import com.myspring.team.goods.vo.GoodsVO;

@Service("mbtiService")
public class MbtiServiceImpl implements MbtiService {

	@Autowired
	private MbtiDAO mbtiDAO;
	
	public List<GoodsVO> getGoodsByMBTI(String mbti) throws Exception {
		return mbtiDAO.selectGoodsByMBTI(mbti);
		 
	}
}
