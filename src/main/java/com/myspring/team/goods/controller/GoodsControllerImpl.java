package com.myspring.team.goods.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.common.FileUploadUtil;
import com.myspring.team.goods.service.GoodsService;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.recipe.service.RecipeService;
import com.myspring.team.review.controller.ReviewControllerImpl;
import com.myspring.team.review.service.ReviewService;
import com.myspring.team.review.vo.ReviewVO;


@Controller("GoodsController")
public class GoodsControllerImpl implements GoodsController {
	private final FileUploadUtil fileUploadUtil = new FileUploadUtil(); 
    @Autowired
    private GoodsService goodsService;
    
    @Autowired
    private RecipeService recipeService;
    
    @Autowired
    private ReviewService reviewService;
    
    @Override
    @RequestMapping("/goods/*goodsList*.do")
    public ModelAndView getGoodsListByStatus(
            @RequestParam(value = "goods_status", defaultValue = "Y") String goods_status, 
            @RequestParam(value = "section", defaultValue = "1") int section,  // int로 변경
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,  // int로 변경
            @RequestParam(value = "goods_category") String goods_category,  
            HttpServletRequest request) throws Exception {

        // 페이징을 위한 Map 설정
        Map<String, Object> condMap = new HashMap<>();
        condMap.put("goods_status", goods_status);
        condMap.put("section", section);  // section은 이제 int로 처리
        condMap.put("pageNum", pageNum);  // pageNum도 int로 처리
        condMap.put("goods_category", goods_category);  // goods_category 추가

        // 기존 메서드 호출 (페이징된 데이터 가져오기)
        List<GoodsVO> goodsList = goodsService.getGoodsListByStatus(condMap);

        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);  // 모델에 상품 목록 추가

        // 요청을 기반으로 뷰 이름을 설정
        String viewName = getViewName(request);
        mav.setViewName(viewName);  // 동적으로 결정된 뷰 이름 설정

        // 페이징 관련 파라미터 추가
        mav.addObject("goods_status", goods_status);
        mav.addObject("section", section);  // section도 int로 추가
        mav.addObject("pageNum", pageNum);  // pageNum도 int로 추가
        mav.addObject("goods_category", goods_category);  // goods_category 추가
     
        return mav;  // 페이지 이동 처리
    }

    @RequestMapping("/goods/goodsDetail.do")
    public ModelAndView getGoodsDetail(@RequestParam("goods_id") int goodsId, 
    									@RequestParam Map<String, String> searchParams,
    									HttpServletRequest request) throws Exception {
    	
    	int review_section = 1;
    	int review_pageNum = 1;
    	int recipe_section = 1;
    	int recipe_pageNum = 1;
    	
    	 if (searchParams.get("review_section") != null && !searchParams.get("review_section").isEmpty()) {
    		  review_section = Integer.parseInt(searchParams.get("review_section"));
		    }
		 if (searchParams.get("review_pageNum") != null && !searchParams.get("review_pageNum").isEmpty()) {
		    	review_pageNum = Integer.parseInt(searchParams.get("review_pageNum"));
		    }
    	
		 if (searchParams.get("recipe_section") != null && !searchParams.get("recipe_section").isEmpty()) {
		    	recipe_section = Integer.parseInt(searchParams.get("recipe_section"));
		    }
		 if (searchParams.get("recipe_pageNum") != null && !searchParams.get("recipe_pageNum").isEmpty()) {
		    	recipe_pageNum = Integer.parseInt(searchParams.get("recipe_pageNum"));
		    }
		 
		 Map<String, Object> searchMap = new HashMap<>();
    	 searchMap.put("goodsId", goodsId);
		 searchMap.put("review_section", review_section);
		 searchMap.put("review_pageNum", review_pageNum);
		 searchMap.put("recipe_section", recipe_section);
		 searchMap.put("recipe_pageNum", recipe_pageNum);
		 
		 Map<String, Object> reviewsMap = reviewService.getReviewsList(searchMap);
    	
		 for (Map.Entry<String, Object> entry : reviewsMap.entrySet()) {
			    System.out.println("Key: " + entry.getKey());
			    System.out.println("Value: " + entry.getValue());
			    System.out.println("----------------------");
			}
		 
		 Map<String, Object> recipesMap = recipeService.getRecipesList(searchMap);
	    	
		 for (Map.Entry<String, Object> entry : recipesMap.entrySet()) {
			    System.out.println("Key: " + entry.getKey());
			    System.out.println("Value: " + entry.getValue());
			    System.out.println("----------------------");
			}
		 
		String reviewPath =  ReviewControllerImpl.REVIEW_IMAGE_PATH;
		List<ReviewVO> reviewList = (List<ReviewVO>) reviewsMap.get("reviewList");
		
		List<String> reviewNoList = new ArrayList();
		
		for(ReviewVO vo : reviewList) {
			int review_no = vo.getReview_no();
			
			String review_no_path =URLEncoder.encode(reviewPath + File.separator + review_no,StandardCharsets.UTF_8);
			reviewNoList.add(review_no_path);
		}
		
		
		
        // GoodsService에서 상품 상세 정보와 이미지를 구분하여 가져옴
        GoodsVO goodsDetail = goodsService.getGoodsDetail(goodsId);
        
        
        
        
        // 상품 정보를 제대로 가져왔는지 확인
        if (goodsDetail == null) {
            // 상품을 찾을 수 없으면 오류 처리
            System.out.println("상품 상세 정보를 찾을 수 없습니다.");
            ModelAndView mav = new ModelAndView("error"); // 오류 페이지로 리턴
            return mav;
        }

        // 상품 가격이 0이면 디버깅용 메시지 출력
        if (goodsDetail.getGoods_price() == 0) {
            System.out.println("상품 가격이 0원으로 나왔습니다. 상품 정보: " + goodsDetail);
        }

        // ModelAndView 객체 생성
        ModelAndView mav = new ModelAndView();

        // goodsDetail 객체를 모델에 추가
        mav.addObject("goodsDetail", goodsDetail);
        mav.addObject("reviewsMap",reviewsMap);
        mav.addObject("recipesMap",recipesMap);
        mav.addObject("reviewNoList", reviewNoList);
        
        // JSP 페이지로 포워딩
        String viewName = getViewName(request);
        mav.setViewName(viewName);  // "goodsDetail.jsp" 페이지로 이동

        // 상품 이름 및 가격 출력 (디버깅용)
        System.out.println("컨트롤러 상품 이름: " + goodsDetail.getGoods_name());
        System.out.println("컨트롤러 상품 가격: " + goodsDetail.getGoods_price());
 
        
        // ModelAndView 반환
        return mav;
    }
    
    // 상품 검색 메서드 추가
    @RequestMapping("/goods/searchGoods.do")
    public ModelAndView searchGoods(@RequestParam("searchQuery") String searchQuery, HttpServletRequest request) throws Exception {
        // GoodsService에서 상품 검색 결과를 가져옴
        List<GoodsVO> goodsList = goodsService.searchGoodsByQuery(searchQuery);

        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);  // 검색된 상품 목록을 모델에 추가

        // 검색어도 모델에 추가
        mav.addObject("searchQuery", searchQuery);

        // 뷰 이름 설정 (동적으로 결정된 뷰 이름)
        String viewName = getViewName(request);
        mav.setViewName(viewName);

        return mav;
    }
	private String getViewName(HttpServletRequest request) throws Exception {
	    String contextPath = request.getContextPath();
	    String uri = request.getRequestURI();

	    if (uri.startsWith(contextPath)) {
	        uri = uri.substring(contextPath.length());
	    }
	    int end = uri.indexOf(".");
	    if (end != -1) {
	        uri = uri.substring(0, end);
	    }
	    
	    return uri;
	}
    @RequestMapping(value = "/goods/wegoods.do", method = RequestMethod.GET)
    private ModelAndView wegoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 날씨 정보를 쿼리 파라미터로 받기
        String weatherMain = request.getParameter("weatherMain");

        // 날씨 정보를 서비스에 전달하여 결과 가져오기
        List<GoodsVO> goodsList = goodsService.getGoodsByWeather(weatherMain);

        // 모델에 결과 추가
        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);  // 상품 리스트를 JSP로 전달
        mav.addObject("weatherMain", weatherMain);  // 날씨 정보도 JSP로 전달
        System.out.println("날씨 정보: " + weatherMain);  // 콘솔에 출력하여 확인

        // 적절한 뷰 이름 설정
        mav.setViewName("goods/wegoods"); // 원하는 뷰로 변경

        return mav;
    }
	 @RequestMapping("/image.do")
	    public void getImage(@RequestParam("goods_id") int goods_id, 
	                         @RequestParam("fileName") String fileName,
	                         HttpServletResponse response) throws IOException {
	        fileUploadUtil.provideImage(goods_id, fileName, response);
}


}


