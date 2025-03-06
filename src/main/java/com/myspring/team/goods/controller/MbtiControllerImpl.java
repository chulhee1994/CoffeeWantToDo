package com.myspring.team.goods.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.team.common.FileUploadUtil;
import com.myspring.team.goods.service.MbtiService;
import com.myspring.team.goods.vo.GoodsVO;

@Controller("mbtiController")
public class MbtiControllerImpl implements MbtiController {
	
	private final FileUploadUtil fileUploadUtil = new FileUploadUtil();
	
	@Autowired
	private MbtiService mbtiService;
	
	@Autowired
	private GoodsVO goodsVO;
	
	
	@RequestMapping(value = "/goods/mbti.do", method = RequestMethod.POST)
	@ResponseBody
	public List<GoodsVO> getRecommendation(@RequestParam("mbti") String mbti, HttpServletResponse response) throws Exception {
		List<GoodsVO> goodsList = mbtiService.getGoodsByMBTI(mbti);	
		System.out.println(mbti);
	    return goodsList;
	}

	
	@RequestMapping(value = "/mbti/image.do")
    public void getImage(@RequestParam("goods_id") int goods_id, 
                         @RequestParam("fileName") String fileName,
                         HttpServletResponse response) throws IOException {
        fileUploadUtil.provideImage(goods_id, fileName, response);
}
	
}
