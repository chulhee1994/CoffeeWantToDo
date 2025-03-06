package com.myspring.team.seller.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.admin.goods.service.AdminGoodsService;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.service.OrderService;
import com.myspring.team.order.vo.OrderVO;
import com.myspring.team.review.service.ReviewService;
import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

@Controller("sellerController")
public class SellerControllerImpl implements SellerController {

    @Autowired
    private AdminGoodsService adminGoodsService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private OrderService orderService;  // OrderService 사용
    
    @Autowired
    private MemberService memberService;

    @Autowired
    private ImageFileVO imageFileVO;
    

    // viewName을 가져오는 메서드 (불필요한 경우 제거 가능)
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
    
 // 상품 목록 조회
    @RequestMapping("/seller/sellergoodsList.do")
    public ModelAndView sellergoodsList(
            @RequestParam(value = "goods_status", defaultValue = "Y") String goods_status, 
            @RequestParam(value = "section", defaultValue = "1") int section,  
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,  
            HttpServletRequest request) throws Exception {

        
     // 세션에서 mem_id 가져오기
        HttpSession session = request.getSession();
        String mem_id = (String) session.getAttribute("mem_id");  // 세션에서 mem_id를 가져옴

        
        // 페이징을 위한 Map 설정
        Map<String, Object> condMap = new HashMap<>();
        condMap.put("goods_status", goods_status);
        condMap.put("section", section);  
        condMap.put("pageNum", pageNum);  
        condMap.put("mem_id", mem_id);

        // 기존 메서드 호출 (페이징된 데이터 가져오기)
        List<GoodsVO> goodsList = adminGoodsService.getSellerGoodsListByStatus2(condMap);
        List<GoodsVO> goodsList2 = adminGoodsService.getSellerGoodsListByStatus3(condMap);
        List<GoodsVO> goodsList3 = adminGoodsService.getSellerGoodsListByStatus4(condMap);
        
        System.out.println(goodsList.size());

        // 모델에 goodsList 추가
        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);
        mav.addObject("goodsList2", goodsList2);
        mav.addObject("goodsList3", goodsList3);
       
        session.setAttribute("goodsList", goodsList);
        session.setAttribute("goodsList2", goodsList2);
        session.setAttribute("goodsList3", goodsList3);

        // 리다이렉트로 이동
        mav.setViewName("redirect:/seller/sellerdailySales.do");  // 리다이렉트 방식으로 이동
        return mav;
    }
    
 // 일매출 및 월매출 조회
    @RequestMapping(value = "/seller/sellerdailySales.do", method = RequestMethod.GET)
    public ModelAndView sellerdailySales(HttpServletRequest req, HttpServletResponse response, HttpSession session) throws Exception {
        Map<String, Object> condMap = new HashMap<>();

        
     // 세션에서 판매자 ID를 가져옴
        
        condMap.put("mem_id", (String) session.getAttribute("mem_id"));

        		
        // 일매출 데이터 가져오기
        List<OrderVO> dailySalesData = orderService.getSellerDailySales(condMap);

        // 월매출 데이터 가져오기
        List<OrderVO> monthlysellerSalesData = orderService.getMonthlysellerSales(condMap);
        System.out.println("Service Check");
        System.out.println(monthlysellerSalesData.size());

        // 일매출 데이터 처리
        for (OrderVO data : dailySalesData) {
            if (data.getOrderDate() == null) {
                // 기본 날짜 처리
                data.setOrderDate(new java.sql.Date(new Date().getTime()));
            }
            if (data.getTotalSales() == 0.0) {
                data.setTotalSales(0.0);  // 기본 값 초기화
            }
        }

        // 월매출 데이터 처리 (같은 방식으로 처리)
        for (OrderVO data : monthlysellerSalesData) {
            System.out.println("check List");
            System.out.println(data.getTotalSales());
            if (data.getOrderDate() == null) {
                // 기본 날짜 처리
                data.setOrderDate(new java.sql.Date(new Date().getTime()));
            }
            if (data.getTotalSales() == 0.0) {
                data.setTotalSales(0.0);  // 기본 값 초기화
            }
        }

        // 1. ModelAndView에 일매출, 월매출 데이터 전달
        ModelAndView mav = new ModelAndView();
        mav.addObject("dailySalesData", dailySalesData);  // 일매출 데이터
        mav.addObject("monthlySalesData", monthlysellerSalesData);  // 월매출 데이터

        // 2. 세션에 일매출, 월매출 데이터 저장
        session.setAttribute("dailySalesData", dailySalesData); // 세션에 일매출 데이터
        session.setAttribute("monthlySalesData", monthlysellerSalesData); // 세션에 월매출 데이터

        // 리다이렉트로 이동
        mav.setViewName("redirect:/seller/sellerReviewLists.do");  // "adminmain.do"로 리다이렉트
        return mav;
    }
    
    @RequestMapping(value = "/seller/sellerReviewLists.do", method = RequestMethod.GET)
    public ModelAndView sellerReviewLists(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();

     // 세션에서 mem_id 값을 가져옵니다.
        String memId = (String) req.getSession().getAttribute("mem_id");
        
        // 서비스 호출하여 모든 리뷰 목록 가져오기
        List<ReviewVO> reviewList = reviewService.getAllReviews(memId);
        
     // 리뷰 번호를 이용해 각 리뷰에 대한 이미지를 가져옵니다.
        for (ReviewVO review : reviewList) {
            int reviewNo = review.getReview_no();
            List<ImageFileVO> imageList = reviewService.getImagesForReview(reviewNo);
            review.setImageList(imageList);  // ReviewVO 객체에 이미지 리스트 추가
        }

        // ModelAndView에 리뷰 목록 설정
        mav.addObject("reviewList", reviewList);

        // 뷰 이름 설정 (리뷰 리스트 뷰로 이동)
        mav.setViewName("redirect:/seller/sellermain.do");
        
        session.setAttribute("reviewList", reviewList);

        return mav;
    }




    
 // 관리자 메인 페이지
    @RequestMapping(value = "/seller/sellermain.do", method = RequestMethod.GET)
    public ModelAndView sellermain(@RequestParam(value = "result", required = false) String result,
                                    @RequestParam(value = "action", required = false) String action,
                                    HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 세션에서 goodsList를 가져옵니다.
        HttpSession session = request.getSession();
        List<GoodsVO> goodsList = (List<GoodsVO>)session.getAttribute("goodsList");


        // goodsList가 null이 아닌지 확인
        if (goodsList != null) {
            System.out.println("상품 리스트의 크기: " + goodsList.size());
        } else {
            System.out.println("상품 리스트가 존재하지 않습니다.");
        }

        // viewName을 request 속성에서 가져옵니다.
        String viewName = (String) request.getAttribute("viewName");

        // action을 세션에 저장
        session.setAttribute("action", action);

        // ModelAndView 객체 생성
        ModelAndView mav = new ModelAndView();
        mav.addObject("result", result);  // result 모델에 추가

        // viewName이 null이 아니면 사용하고, 아니면 기본 뷰를 설정
        if (viewName != null && !viewName.isEmpty()) {
            mav.setViewName(viewName);
        } else {
            mav.setViewName("seller/sellermain");  // 기본 뷰 설정
        }

        return mav;  // ModelAndView 반환
    }

    //판매자 주문내역
    @Override
    @RequestMapping(value = "/seller/SellerOrderList.do", method = RequestMethod.GET)
    public ModelAndView SellerOrderList (HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String viewName = getViewName(request);
        MemberVO member = (MemberVO) session.getAttribute("member"); // 세션에서 member 객체 가져오기
        String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
        System.out.println("셀러 아이디 : " + mem_id);
        List<OrderVO> SellerOrdersList = orderService.SellerlistOrders(mem_id);
        List<OrderVO> SellerOrdersList_done = orderService.SellerlistOrders_done(mem_id);
        session.setAttribute("SellerOrdersList", SellerOrdersList);
        session.setAttribute("SellerOrdersList_done", SellerOrdersList_done);
        System.out.println("SellerOrderList : " + SellerOrdersList);
        System.out.println("SellerOrdersList_done : " + SellerOrdersList_done);
        ModelAndView mav = new ModelAndView();
        mav.addObject("SellerOrdersList", SellerOrdersList);
        mav.addObject("SellerOrdersList_done", SellerOrdersList_done);
        mav.setViewName(viewName);
        return mav;
    }
    
    @RequestMapping("/seller/modgoodsList*.do")
    public ModelAndView getGoodsListByStatus(
            @RequestParam(value = "goods_status", defaultValue = "Y") String goods_status, 
            @RequestParam(value ="mem_id") String mem_id,
            @RequestParam(value = "section", defaultValue = "1") int section,  // int로 변경
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,  // int로 변경
            @RequestParam(value = "goods_category") String goods_category,  
            HttpServletRequest request) throws Exception {
    	
    	
    	
        HttpSession session = request.getSession();
        mem_id = (String) session.getAttribute("mem_id");
        
        // 페이징을 위한 Map 설정
        Map<String, Object> condMap = new HashMap<>();
        condMap.put("goods_status", goods_status);
        condMap.put("mem_id", mem_id);
        condMap.put("section", section);  // section은 이제 int로 처리
        condMap.put("pageNum", pageNum);  // pageNum도 int로 처리
        condMap.put("goods_category", goods_category);  // goods_category 추가

        // 기존 메서드 호출 (페이징된 데이터 가져오기)
        List<GoodsVO> goodsList = adminGoodsService.getGoodsListByStatusseller(condMap);
        // 세션에서 mem_id를 가져옵니다.

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
    }@RequestMapping("/seller/modsearchGoods.do")
    public ModelAndView searchGoods(@RequestParam("searchQuery") String searchQuery, HttpServletRequest request) throws Exception {
        // GoodsService에서 상품 검색 결과를 가져옴
        List<GoodsVO> goodsList = adminGoodsService.searchGoodsByQuery(searchQuery);

        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);  // 검색된 상품 목록을 모델에 추가

        // 검색어도 모델에 추가
        mav.addObject("searchQuery", searchQuery);

        // 뷰 이름 설정 (동적으로 결정된 뷰 이름)
        String viewName = getViewName(request);
        mav.setViewName(viewName);

        return mav;
    }
}
