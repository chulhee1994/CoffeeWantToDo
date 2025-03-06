package com.myspring.team.admin.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.admin.goods.service.AdminGoodsService;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;
import com.myspring.team.order.service.OrderService;

@Controller("adminController")
public class AdminControllerImpl implements AdminController {

    @Autowired
    private AdminGoodsService adminGoodsService;

    @Autowired
    private OrderService orderService;  // OrderService 사용

    @Autowired
    private MemberService memberService;
    
    // 상품 목록 조회
    @RequestMapping("/admin/admingoodsList.do")
    public ModelAndView admingoodsList(
            @RequestParam(value = "goods_status", defaultValue = "N") String goods_status, 
            HttpServletRequest request) throws Exception {

        // 페이징을 위한 Map 설정
        Map<String, Object> condMap = new HashMap<>();
        condMap.put("goods_status", goods_status);

        // 기존 메서드 호출 (페이징된 데이터 가져오기)
        List<GoodsVO> goodsList = adminGoodsService.getGoodsListByStatus2(condMap);

        
        if (goodsList == null || goodsList.isEmpty()) {
            goodsList = new ArrayList<>(); // 빈 리스트
        }

        System.out.println(goodsList.size());

        // 모델에 goodsList 추가
        ModelAndView mav = new ModelAndView();
        mav.addObject("goodsList", goodsList);

        HttpSession session = request.getSession();
        session.setAttribute("goodsList", goodsList);

        // 리다이렉트로 이동
        mav.setViewName("redirect:/admin/dailySales.do");  // 리다이렉트 방식으로 이동
        return mav;
    }

    // 일매출 및 월매출 조회
    @RequestMapping(value = "/admin/dailySales.do", method = RequestMethod.GET)
    public ModelAndView dailySales(HttpServletRequest req, HttpServletResponse response, HttpSession session) throws Exception {
        Map<String, Object> condMap = new HashMap<>();

        // 일매출 데이터 가져오기
        List<OrderVO> dailySalesData = orderService.getDailySales(condMap);
        List<MemberVO> sellerList = memberService.selectSellerList();

        condMap.put("mem_id", sellerList.get(0).getMem_cmp_name());
        // 월매출 데이터 가져오기
        List<OrderVO> monthlySalesData = orderService.getMonthlySales(condMap);
        List<OrderVO> monthlysellerSalesData = orderService.getMonthlysellerSales(condMap);
        // 회원수 가져오기
        
        // 월 주문수 가져오기
        List<Map<String, Object>> monthlyOrderCount = orderService.getMonthlyOrderCount();
    
        System.out.println("Service Check");
        System.out.println(monthlySalesData.size());
        
        // 일반 사용자 수 가져오기 (MemberService 호출)
        int commonUserCount = memberService.getCommonUserCount();

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
        for (OrderVO data : monthlySalesData) {
            System.out.println("check List");
            System.out.println(data.getTotalSales());
            if (data.getOrderDate() == null) {
                // 기본 날짜 처리
                data.setOrderDate(new java.sql.Date(new Date().getTime()));
            }
            if (data.getTotalSales() == 0.0) {
                data.setTotalSales(0.0);  // 기본 값 초기화
            }
        } System.out.println("Monthly Sales Data: ");
        for (OrderVO data : monthlySalesData) {
            System.out.println("Seller ID: " + data.getSeller_id());
            System.out.println("Order Date (Month): " + data.getOrderDate());
            System.out.println("Total Sales: " + data.getTotalSales());
        }
        
System.out.println("집"+monthlySalesData);
        // 1. ModelAndView에 일매출, 월매출 데이터 전달
        ModelAndView mav = new ModelAndView();
        mav.addObject("dailySalesData", dailySalesData);  // 일매출 데이터
        mav.addObject("monthlySalesData", monthlySalesData);  // 월매출 데이터
        mav.addObject("monthlysellerSalesData", monthlysellerSalesData);  // 월매출 데이터
        mav.addObject("monthlyOrderCount", monthlyOrderCount); // 월 주문수 데이터
        mav.addObject("commonUserCount", commonUserCount); // 일반 사용자 수 추가
        
        mav.addObject("sellerList", sellerList); // 판매자 목록 저장
        
        // 2. 세션에 일매출, 월매출 데이터 저장
        session.setAttribute("dailySalesData", dailySalesData); // 세션에 일매출 데이터
        session.setAttribute("monthlySalesData", monthlySalesData); // 세션에 월매출 데이터
        session.setAttribute("monthlysellerSalesData", monthlysellerSalesData); // 세션에 월매출 데이터
        session.setAttribute("monthlyOrderCount", monthlyOrderCount); // 세션에 월 주문수 데이터
        session.setAttribute("commonUserCount", commonUserCount); // 세션에 일반 사용자 수 저장
        session.setAttribute("sellerList", sellerList); // 세션에 판매자 목록 저장
        // 리다이렉트로 이동
        mav.setViewName("redirect:/admin/adminmain.do");  // "adminmain.do"로 리다이렉트
        
        System.out.print("하"+monthlysellerSalesData);
        return mav;
        
    }

    // 관리자 메인 페이지
    @RequestMapping(value = "/admin/adminmain.do", method = RequestMethod.GET)
    public ModelAndView adminmain(@RequestParam(value = "result", required = false) String result,
                                    @RequestParam(value = "action", required = false) String action,
                                    HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 세션에서 goodsList를 가져옵니다.
        HttpSession session = request.getSession();
        List<GoodsVO> goodsList = (List<GoodsVO>)session.getAttribute("goodsList");
        List<OrderVO> monthlySalesData = (List<OrderVO>) session.getAttribute("monthlySalesData");
        List<OrderVO> monthlysellerSalesData = (List<OrderVO>) session.getAttribute("monthlysellerSalesData");
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
        mav.addObject("monthlySalesData", monthlySalesData);
        mav.addObject("monthlysellerSalesData", monthlysellerSalesData);// result 모델에 추가
        // viewName이 null이 아니면 사용하고, 아니면 기본 뷰를 설정
        if (viewName != null && !viewName.isEmpty()) {
            mav.setViewName(viewName);
        } else {
            mav.setViewName("admin/adminmain");  // 기본 뷰 설정
        }

        return mav;  // ModelAndView 반환
    }

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
    
    @RequestMapping(value = "/admin/adminGetMonthlySales.do")
    @ResponseBody
    public Map<String, Object> getSellerDailySales(@RequestParam("mem_id") String mem_id) throws Exception {
        // 조건 맵에 memId 설정
        Map<String, Object> condMap = new HashMap<String, Object>();
        condMap.put("mem_id", mem_id);
        // 월매출 데이터 가져오기
        List<OrderVO> monthlysellerSalesData = orderService.getMonthlysellerSales(condMap);
        

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("datas", monthlysellerSalesData);

        return resultMap;  // JSON 형태로 반환
    }
    

}
