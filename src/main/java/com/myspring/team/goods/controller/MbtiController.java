package com.myspring.team.goods.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.team.goods.vo.GoodsVO;

public interface MbtiController {

	public List<GoodsVO> getRecommendation(@RequestParam("mbti") String mbti, HttpServletResponse response) throws Exception;
	
}
