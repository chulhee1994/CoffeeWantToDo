package com.myspring.team.order.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.http.MediaType;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.HttpHeaders;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.inicis.std.util.SignatureUtil;
import com.myspring.team.address.service.AddressService;
import com.myspring.team.address.vo.AddressVO;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.service.OrderService;
import com.myspring.team.order.vo.OrderVO;


@Controller
@RequestMapping("/order")
public class OrderControllerImpl implements OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private AddressService addressService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderVO orderVO;
	

	@Override
	@RequestMapping(value="/orderEachGoods.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView orderEachGoods(@RequestParam Map<String, String> orderData, 
	                                   HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
	    HttpSession session = request.getSession();
	    Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
	    String memId = (String) session.getAttribute("mem_id"); 
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");

	    // ✅ 디버깅 로그 추가
	    System.out.println("🛠 orderEachGoods.do 호출됨!");
	    System.out.println("👉 요청된 데이터: " + orderData);
	    System.out.println("👉 로그인 여부: " + isLogOn);
	    System.out.println("👉 로그인 사용자 ID: " + memId);

	    // 로그인 체크
	    if (isLogOn == null || !isLogOn) {
	        System.out.println("❌ 로그인 필요 - 로그인 페이지로 리다이렉트");
	        session.setAttribute("orderInfo", orderData);
	        return new ModelAndView("redirect:/member/loginForm.do");
	    }

	    try {
	        // ✅ 기존 개별 주문 삭제 후 새로 저장
	        session.removeAttribute("singleOrder");

	        // ✅ 개별 구매용 객체 생성
	        OrderVO orderVO = new OrderVO();
	        orderVO.setMem_id(memId);
	        orderVO.setGoods_id(Integer.parseInt(orderData.get("goods_id")));
	        orderVO.setGoods_name(orderData.get("goods_name"));
	        orderVO.setOrder_goods_qty(Integer.parseInt(orderData.get("order_goods_qty")));
	        orderVO.setGoods_sales_price(Integer.parseInt(orderData.get("goods_sales_price")));
	        orderVO.setOrder_total_price(Integer.parseInt(orderData.get("order_total_price")));
	        orderVO.setGoods_fileName(orderData.get("goods_fileName"));
	        
	        // ✅ GoodsVO 객체 초기화 후 값 할당
	        GoodsVO goodsVO = new GoodsVO();
	        if (orderData.containsKey("goods_point") && orderData.get("goods_point") != null) {
	            goodsVO.setGoods_point(Integer.parseInt(orderData.get("goods_point")));
	        } else {
	            goodsVO.setGoods_point(0); // 기본값 설정
	        }

	        // ✅ GoodsVO 객체를 OrderVO에 추가
	        orderVO.setGoodsVO(goodsVO);

	        // ✅ 디버깅 로그 추가
	        System.out.println("✅ 주문 객체 생성 완료: " + orderVO);
	        System.out.println("✅ 상품 정보 추가 완료: " + goodsVO);

	        // ✅ 개별 구매용 세션에 저장
	        session.setAttribute("singleOrder", orderVO);
	        session.setAttribute("orderer", memberVO);
	        
	        List<AddressVO> addressList =  addressService.getAddressByMemberId(memId);
	        mav.setViewName("order/orderGoodsForm");
	        mav.addObject("addressList", addressList);
	        

	    } catch (NumberFormatException e) {
	        System.out.println("❌ 숫자 변환 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        return new ModelAndView("errorPage").addObject("message", "상품 정보 변환 중 오류 발생");
	    } catch (Exception e) {
	        System.out.println("❌ 서버 내부 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        return new ModelAndView("errorPage").addObject("message", "서버 내부 오류 발생");
	    }
	    
	    return mav;
	}

	@Override
	@RequestMapping(value = "/orderFromCart.do", method = RequestMethod.POST)
	public ModelAndView orderFromCart(@RequestParam(value = "cart_id") List<Integer> cartIds, HttpServletRequest request) throws Exception {
	    HttpSession session = request.getSession();
	    Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
	    String memId = (String) session.getAttribute("mem_id");
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");

	    if (isLogOn == null || !isLogOn) {
	        return new ModelAndView("redirect:/member/loginForm.do");
	    }

	    // ✅ 장바구니에서 선택한 상품 정보를 가져오기
	    System.out.println("🛠 orderFromCart.do 호출됨! cartIds: " + cartIds);
	    List<OrderVO> selectedOrders = orderService.getOrdersFromCart(memId, cartIds);
	    
	 // ✅ 리스트의 내용을 콘솔에 출력
	    System.out.println("🛠 선택된 주문 목록:");
	    for (OrderVO order : selectedOrders) {
	        System.out.println(order);
	    }

	    // ✅ 기존 단일 상품 주문 정보를 삭제하여 갱신 문제 해결
	    session.removeAttribute("singleOrder");
	    
	    // ✅ 주문 확인 페이지에서 사용할 데이터 세션에 저장
	    session.setAttribute("selectedOrderList", selectedOrders);
	    session.setAttribute("cartIdsToDelete", cartIds);
        session.setAttribute("orderer", memberVO);
        
	    return new ModelAndView("order/orderGoodsForm");
	}

	@Override
	@ResponseBody
	@Transactional
	@RequestMapping(value="/payToOrderGoods.do", method = RequestMethod.POST)
	public Map<String, Object> payToOrderGoods(@RequestParam Map<String, String> receiverMap,
	                                           @RequestParam(value = "selectedOrderList", required = false) String selectedOrderListJson,
	                                           HttpServletRequest request, HttpServletResponse response) throws Exception {
	    Map<String, Object> responseMap = new HashMap<>();
	    HttpSession session = request.getSession();
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");

	    if (memberVO == null) {
	        responseMap.put("success", false);
	        responseMap.put("error", "세션이 만료되었습니다. 다시 로그인해 주세요.");
	        return responseMap;
	    }

	    
	    String mem_id = memberVO.getMem_id();
	    List<OrderVO> myOrderList = (List<OrderVO>) session.getAttribute("myOrderList");
	    OrderVO singleOrder = (OrderVO) session.getAttribute("singleOrder");
	    List<OrderVO> selectedOrderList = new ArrayList<>();

	    System.out.println("받아온 데이터  :" + receiverMap);
	    try {
	        // ✅ JSON 데이터를 List<OrderVO>로 변환
	        if (selectedOrderListJson != null && !selectedOrderListJson.isEmpty()) {
	            ObjectMapper objectMapper = new ObjectMapper();
	            selectedOrderList = objectMapper.readValue(selectedOrderListJson, new TypeReference<List<OrderVO>>() {});
	            System.out.println("✅ 변환된 주문 목록: " + selectedOrderList);
	        }
	    } catch (Exception e) {
	        System.out.println("❌ JSON 변환 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        responseMap.put("success", false);
	        responseMap.put("error", "주문 데이터 변환 중 오류 발생");
	        return responseMap;
	    }

	    // ✅ 주문 목록 확인
	    if ((myOrderList == null || myOrderList.isEmpty()) && singleOrder == null && (selectedOrderList == null || selectedOrderList.isEmpty())) {
	        responseMap.put("success", false);
	        responseMap.put("error", "장바구니에 상품이 없습니다.");
	        return responseMap;
	    }

	    // ✅ 최종 주문 리스트 구성
	    List<OrderVO> finalOrderList = new ArrayList<>();
	    if (singleOrder != null) {
	        finalOrderList.add(singleOrder);
	    } else if (!selectedOrderList.isEmpty()) {
	        finalOrderList.addAll(selectedOrderList);
	    } else {
	        finalOrderList.addAll(myOrderList);
	    }
	    
	 // 사용한 포인트
	    int usedPoint = 0;
	    try {
	        usedPoint = Integer.parseInt(receiverMap.getOrDefault("usePoint", "0"));
	    } catch (NumberFormatException e) {
	        usedPoint = 0;
	    }
	    System.out.println("적립할 포인트 :" +usedPoint );
	    if (usedPoint > 0) {
	        memberService.updateMemberPoint(mem_id, -usedPoint);	        
	    }
	    boolean isFirst = true;
	    int totalAccumulatedPoint = 0;
	    
	    
	    for (OrderVO orderVO : finalOrderList) {
	    	System.out.println("주문 시작할 orderVO : " + orderVO );
	        orderVO.setMem_id(mem_id);
	        
	        if (orderVO.getGoodsVO() == null) {
                System.out.println("goodsVO가 NULL입니다! 상품 정보를 DB에서 다시 조회합니다.");
                GoodsVO goods =  orderService.getGoodsById(orderVO.getGoods_id());
                orderVO.setGoodsVO(goods);
            }
	        
	        // 주문 총 금액: 판매가 * 구매 수량
	        int orderTotal = orderVO.getGoods_sales_price() * orderVO.getOrder_goods_qty();
	        orderVO.setOrder_total_price(orderTotal);
	        
	        // 재고 차감: 현재 재고에서 구매 수량을 차감하고 DB에 업데이트
	        int newStock = orderVO.getOrder_goods_qty();
	        // 재고가 음수가 되지 않도록 처리(실제 로직에서는 사전에 재고 체크 필요)
	        if(newStock < 0) {
	            newStock = 0;
	        }
	        
	        //goods_id랑 주문수를 넘겨서 개수 업데이트??
	        System.out.println("빼야할 재고수 : " + newStock);
	        // goodsService를 통해 DB 재고 업데이트 (서비스/DAO에 구현되어 있어야 함)
	        
	        if (isFirst) {
	            // 첫 상품에만 사용 포인트를 적용하여 최종 결제 금액 계산
	            int finalTotalPrice = orderTotal - usedPoint;
	            orderVO.setFinal_total_price(finalTotalPrice);
	            isFirst = false;
	        } else {
	            // 나머지 상품은 포인트 차감 없이 그대로
	        	orderVO.setFinal_total_price(orderTotal);
	        }
	        // 회원 포인트 갱신: 사용한 포인트 차감 후, 구매 적립 포인트 추가
	        int currentPoint = memberVO.getMem_point();
	        int newPoint = currentPoint - usedPoint + totalAccumulatedPoint;
	        
	     // ✅ 개별 상품의 적립 포인트 계산 (상품 포인트 * 수량)
	        int productPoint = orderVO.getGoodsVO().getGoods_point() * orderVO.getOrder_goods_qty();
	        
	        // ✅ 총 적립 포인트 누적
	        totalAccumulatedPoint += productPoint;
	     
	        System.out.println("상품 적립 포인트: " + productPoint);
	        
	        orderVO.setReceiver_name(receiverMap.getOrDefault("receiver_name", ""));
	        orderVO.setReceiver_tel1(receiverMap.getOrDefault("receiver_tel1", ""));
	        orderVO.setReceiver_tel2(receiverMap.getOrDefault("receiver_tel2", ""));
	        orderVO.setReceiver_tel3(receiverMap.getOrDefault("receiver_tel3", ""));
	        orderVO.setDelivery_method(receiverMap.getOrDefault("delivery_method", ""));
	        orderVO.setDelivery_address(receiverMap.getOrDefault("delivery_address", ""));
	        orderVO.setDelivery_message(receiverMap.getOrDefault("delivery_message", ""));
	        orderVO.setPay_method(receiverMap.getOrDefault("pay_method", "없음"));
	        orderVO.setGift_wrapping(receiverMap.getOrDefault("gift_wrapping", "no"));
	        orderVO.setCard_com_name(receiverMap.getOrDefault("card_com_name", ""));
	        orderVO.setCard_pay_month(receiverMap.getOrDefault("card_pay_month", "0"));
	        orderVO.setOrderer_name((receiverMap.getOrDefault("orderer_name", "")));
	        orderVO.setOrderer_hp1((receiverMap.getOrDefault("orderer_hp1", "")));
	        orderVO.setOrderer_hp2((receiverMap.getOrDefault("orderer_hp2", "")));
	        orderVO.setOrderer_hp3( (receiverMap.getOrDefault("orderer_hp3", "") ) );
	        orderVO.setPay_orderer_hp_num(receiverMap.getOrDefault("pay_orderer_hp_num", ""));
	        String imp_uid = receiverMap.getOrDefault("imp_uid", "");
	        orderVO.setImp_uid(imp_uid);
	        
	        String merchant_uid = receiverMap.getOrDefault("merchant_uid", "");
	        orderVO.setMerchant_uid(merchant_uid);
	        
	        String t_id = receiverMap.getOrDefault("t_id", "");
	        orderVO.setT_id(t_id);
	        // ✅ final_total_price 설정 (포인트 적용 후 최종 결제 금액)
			/*
			  int finalTotalPrice = Integer.parseInt(receiverMap.getOrDefault("amount","0")); orderVO.setFinal_total_price(finalTotalPrice); 
			  // 🚀 추가: 최종 결제 금액 넣기
			 */		        // ✅ 상품 파일명 저장 (이미지가 DB에 저장될 경우 활용)
	        System.out.println("orderVO : " + orderVO);
	    }
	    
	    
        
	    // ✅ 세션에서 삭제할 장바구니 상품 ID 목록 가져오기
	    List<Integer> cartIds = (List<Integer>) session.getAttribute("cartIdsToDelete");

	    // ✅ 주문 처리 서비스 호출 (주문 저장 + 장바구니 삭제)
	   // int order_id = orderService.addNewOrder(finalOrderList);

	    // 주문 저장
	    int order_id = orderService.addNewOrder(finalOrderList);
	    
	    if (order_id > 0) {
	        if (cartIds != null && !cartIds.isEmpty()) {
	            orderService.processOrder(cartIds); // ✅ 수정된 서비스 메서드 호출		    
	        }	    
	        responseMap.put("success", true);
	        responseMap.put("order_id", order_id);
	    } else {
	        responseMap.put("success", false);
	        responseMap.put("error", "주문 저장에 실패했습니다.");
	    }
	    
	    //pointHistory에 정보 저장
	    memberService.updateMemberPointHistory(mem_id, -usedPoint, "금액 할인", order_id);
	    memberService.updateMemberPointHistory(mem_id, totalAccumulatedPoint, "상품 구매", order_id);
	    memberService.updateMemberPoint(mem_id, totalAccumulatedPoint);
	    return responseMap;
	}

	
		@Override
		@RequestMapping(value="/orderResult.do", method = RequestMethod.GET)
		public ModelAndView orderResult(@RequestParam(value = "order_id", required = false) String order_id, HttpServletRequest req,HttpServletResponse res) throws Exception {
		    
		    HttpSession session = req.getSession();
		    String mem_id = (String) session.getAttribute("mem_id"); // ✅ 세션에서 로그인된 사용자 ID 가져오기

		    if (mem_id == null) {
		        System.out.println("❌ 세션이 만료됨 → 로그인 페이지로 이동");
		        res.setContentType("text/html; charset=UTF-8");
		        PrintWriter out = res.getWriter();
		        String contextPath = req.getContextPath();  // ✅ 현재 애플리케이션의 Context Path 가져오기

		        out.println("<script>");
		        out.println("alert('세션이 만료되었습니다. 다시 로그인해주세요.');");
		        out.println("location.href='" + contextPath + "/member/loginForm.do';");  // ✅ 로그인 페이지로 이동
		        out.println("</script>");
		        out.flush();
		    }
		    
		    ModelAndView mav = new ModelAndView("order/orderResult");
		    
		    if (order_id == null) {
		        mav.addObject("errorMessage", "잘못된 접근입니다.");
		        mav.setViewName("error/errorPage");
		        return mav;
		    }

		    // 주문 정보 조회 (order_id 기준으로 여러 개의 상품 조회)
		    List<OrderVO> orderList = orderService.selectOrderIdList(order_id);

		    if (orderList == null || orderList.isEmpty()) {
		        mav.addObject("errorMessage", "해당 주문 정보를 찾을 수 없습니다.");
		        mav.setViewName("error/errorPage");
		        return mav;
		    }

		    // 첫 번째 주문에서 공통 정보 가져오기 (예: 주문자 정보, 결제 수단 등)
		    OrderVO firstOrder = orderList.get(0);
		    
		    System.out.println("firstOrder"+firstOrder.toString());
		    
		    // ✅ 로그인한 사용자와 주문한 사용자가 다르면 마이페이지로 이동
		    if (!firstOrder.getMem_id().equals(mem_id)) {
		        System.out.println("🚨 주문한 사용자와 로그인된 사용자가 다름 → 마이페이지 이동");
		        
		        // ✅ alert 메시지를 띄우고 마이페이지로 이동
		        mav.addObject("errorMessage", "잘못된 접근입니다. 본인의 주문만 조회할 수 있습니다.");
		        mav.setViewName("mypage/myPageUsers");
		        return mav;
		    }
		    
		    mav.addObject("orderList", orderList);
		    mav.addObject("firstOrder", firstOrder); // 주문 공통 정보 (결제정보 등)

		    return mav;
		}

	
	@Override
	@RequestMapping(value = "/popupRefund.do", method = RequestMethod.GET)
	public ModelAndView popupRefund(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName")); // JSP 뷰 설정
	    return mav;
	}
	
	
	
	
	@RequestMapping(value = "/refundOrder.do", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> refundOrder(@RequestBody Map<String, Object> requestData) {
	    System.out.println("📌 refundOrder.do 요청 받음");

	    if (requestData == null) {
	        System.out.println("❌ requestData가 null입니다! 클라이언트 요청을 확인하세요.");
	        return ResponseEntity.badRequest().body(Map.of("error", "Request body is missing or malformed"));
	    }

	    // ✅ 요청 값 확인
	    String tid = (String) requestData.get("t_id");  // ✅ 거래 ID (필드명 일치 여부 확인)
	    String msg = (String) requestData.get("reason"); // ✅ 환불 사유
	    int price = ((int) requestData.get("price")); // ✅ 취소 금액
	    int order_id = ((int) requestData.get("order_id")); // ✅ 취소 금액

	    
	    String apiUrl = "https://iniapi.inicis.com/v2/pg/refund";
	    ResponseEntity resEntity = null;
	    System.out.println(" tid: " + tid);
	    System.out.println(" price: " + price);
	    System.out.println(" msg: " + msg);
	    System.out.println(" order_id: " + order_id);
	    
	    // ✅ `tid`가 비어있는지 확인 (디버깅용)
	    if (tid == null || tid.trim().isEmpty()) {
	        System.out.println("❌ `tid` 값이 비어 있습니다. 결제 정보를 다시 확인하세요.");
	        return ResponseEntity.badRequest().body(Map.of("error", "Invalid transaction ID (tid)"));
	    }

	    SHA512 SHA512 = new SHA512();
	    Map<String, Object> responseMap = new HashMap<>();

	    // ✅ 이니시스 API 필수값 설정
	    String key = "ItEQKi3rY7uvDS8l";  // 🔥 이니시스 Secret Key
	    String mid = "INIpayTest";         // 🔥 상점 아이디
	    String type = "refund";            // 🔥 소문자로 변경
	    String clientIp = "127.0.0.1";      // 🔥 서버 IP
	    String timestamp = String.valueOf(System.currentTimeMillis() / 1000); // UNIX Timestamp
	    String message = null;
	    HttpHeaders responseHeaders = new HttpHeaders();
	    responseHeaders.add("Content-Type", "text/html; charset=utf-8");
	    
	    // ✅ step1. "data" JSON 생성
	    Map<String, Object> data1 = new LinkedHashMap<>(); // ✅ 순서 보장
	    data1.put("tid", tid);  // ✅ 필드명 수정: "t_id" → "tid"
	    data1.put("msg", msg);
	    data1.put("price", price); 
	    
	    JSONObject data = new JSONObject(data1);
	    
	    // ✅ step2. SHA-512 기반 해시 생성
	    String plainTxt = key + mid + type + timestamp + data;
	    plainTxt = plainTxt.replaceAll("\\\\", "");
	    System.out.println("📌 확인용 plainTxt : " + plainTxt);
	    String hashData = SHA512.hash(plainTxt);
	    
	    // ✅ step3. 요청 바디 JSON 생성
	    JSONObject requestJson = new JSONObject();
	    requestJson.put("mid", mid);
	    requestJson.put("type", type);
	    requestJson.put("timestamp", timestamp);
	    requestJson.put("clientIp", clientIp);
	    requestJson.put("data", data);
	    requestJson.put("hashData", hashData);
	    try {

	    	//step2. key=value 로 post 요청
				URL reqUrl = new URL(apiUrl);
				HttpURLConnection conn = (HttpURLConnection) reqUrl.openConnection();
				
				if (conn != null) {
					conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
					conn.setRequestMethod("POST");
					conn.setDefaultUseCaches(false);
					conn.setDoOutput(true);
					
					if (conn.getDoOutput()) {
						conn.getOutputStream().write(requestJson.toString().getBytes("UTF-8"));
						conn.getOutputStream().flush();
						conn.getOutputStream().close();
					}

					conn.connect();
					
						BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
						
						//step3. 요청 결과
						 ObjectMapper mapper = new ObjectMapper();
					     Map<String, Object> returnMap = mapper.readValue(br.readLine(), Map.class);
					     System.out.println(returnMap.get("resultCode"));
						br.close();
						if(returnMap.get("resultCode").equals("00") || returnMap.get("resultCode").equals("500626") ) {
						    responseMap.put("success", true);
						    responseMap.put("message", "결제가 취소되었습니다.");
						    
						    
						    int rows = orderService.updateOrderId(order_id);
						    
						    
						    
						}else{
						    responseMap.put("success", false);
						    responseMap.put("error", "결제 취소가 실패하였습니다.");
						}

						return ResponseEntity.ok(responseMap);

						
					}

			}catch(Exception e ) {
				e.printStackTrace();
			} 
	        resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
	        return resEntity;
	    }



	/**
	 * ✅ `hashData` 생성 (HMAC-SHA256 방식)
	 */
	private String generateHashData(String secretKey, String mid, String t_id, String price, String timestamp) throws Exception {
	    String data = mid + t_id + price + timestamp;
	    Mac mac = Mac.getInstance("HmacSHA256");
	    SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
	    mac.init(secretKeySpec);
	    byte[] hashBytes = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
	    return Base64.getEncoder().encodeToString(hashBytes);
	}

		


	
}

