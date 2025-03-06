package com.myspring.team.cart.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.cart.service.CartService;
import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.common.interceptor.BaseController;
import com.myspring.team.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;
	
	
	@Override
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartList(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    HttpSession session = req.getSession();
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");
	    String id = memberVO.getMem_id();
	    
	    
	    res.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = res.getWriter();
	    
	    
	    
	    // 멤버가 null이면 로그인후 이용 null이 아니면 
    if (memberVO == null || memberVO.getMem_id() == null) {
        out.println("<script>alert('로그인 후 이용 가능합니다.'); </script>");
        mav.setViewName("redirect:/member/loginForm.do"); // ✅ 리다이렉트
        out.flush();
	    } else {
	        // 로그인 상태일 때
	        List<CartVO> cartList = cartService.selectCartList(id);
	        if (cartList == null || cartList.isEmpty()) {
	            System.out.println("장바구니에 상품이 없습니다.");
	        } else {
	            System.out.println("장바구니에 " + cartList.size() + "개의 상품이 있습니다.");
	        }
	        mav.addObject("cartList", cartList);
	        mav.setViewName("cart/myCartList"); // 장바구니 리스트 페이지로 이동
	    }
	    return mav;
	}
	
	
	@Override
	@RequestMapping(value = "/addCart.do", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> addCart(@RequestBody Map<String, Object> requestData, HttpServletRequest req)  throws Exception{
	    Map<String, Object> response = new HashMap<>();

	    HttpSession session = req.getSession();
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");

	    if (memberVO == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요한 서비스입니다.");
	        return response; // 로그인 필요 메시지 반환
	    }

	    // 요청 데이터 가져오기
	    String goodsId = (String) requestData.get("goods_id");
	    String memId = (String) requestData.get("mem_id");
	    int orderGoodsQty = Integer.parseInt((String) requestData.get("order_goods_qty"));  // ✅ 문자열을 정수 변환

	    CartVO cartVO = new CartVO();
	    cartVO.setGoods_id(Integer.parseInt(goodsId));  // ✅ goods_id 변환
	    cartVO.setMem_id(memId);
	    cartVO.setOrder_goods_qty(orderGoodsQty);  // ✅ 올바른 데이터 타입 적용
	    // 중복 체크
	    boolean isExist = cartService.checkDuplicateCart(cartVO);
	    if (isExist) {
	        response.put("success", false);
	        response.put("message", "이미 장바구니에 담긴 상품입니다.");
	        return response;
	    }

	    // 장바구니 추가
	    cartService.addCart(cartVO);
	    response.put("success", true);
	    response.put("message", "장바구니에 담았습니다!");	

	    return response;
	}

	@Override
	@ResponseBody
    @RequestMapping(value = "/deleteCart.do", method = RequestMethod.POST) // ✅ 메서드 매핑
    public Map<String, Object> deleteCart(@RequestParam("cart_id") int cartId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> result = new HashMap<>();
        System.out.println("deleteCart.do 실행 - cart_id: " + cartId);

        try {
            // 요청에서 세션 가져오기
            HttpSession session = request.getSession();
            MemberVO memberVO = (MemberVO) session.getAttribute("member");

            if (memberVO == null) {
                result.put("status", "error");
                result.put("message", "로그인이 필요합니다.");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return result;
            }

            System.out.println("삭제 요청: user_id=" + memberVO.getMem_id() + ", cart_id=" + cartId);

            // 장바구니에서 해당 상품 삭제
            int deleteCount = cartService.deleteCart(cartId, memberVO.getMem_id());
            System.out.println("삭제된 행 개수: " + deleteCount);

            if (deleteCount == 0) {
                result.put("status", "error");
                result.put("message", "삭제할 상품이 존재하지 않습니다.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return result;
            }

            // 최신 장바구니 정보 다시 조회
            List<CartVO> cartList = cartService.selectCartList(memberVO.getMem_id());

            // JSON 형태로 응답 반환
            result.put("status", "success");
            result.put("cartList", cartList);

        } catch (Exception e) {
            System.err.println("삭제 중 오류 발생: " + e.getMessage());
            result.put("status", "error");
            result.put("message", "삭제 중 오류 발생");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return result;
    }
	
	@Override
	@ResponseBody
	@RequestMapping(value="/deleteAllCart.do", method = RequestMethod.POST)
	public Map<String, String> deleteAllCart(HttpSession session) {
	    Map<String, String> response = new HashMap<>();
	    try {
	        String mem_id = (String) session.getAttribute("mem_id"); // 🔥 로그인 사용자 체크
	        if (mem_id == null) {
	            response.put("status", "fail");
	            response.put("message", "로그인이 필요합니다.");
	            return response;
	        }

	        cartService.deleteAllCart(mem_id); // 🔥 전체 삭제 로직 추가 필요
	        response.put("status", "success");
	    } catch (Exception e) {
	        response.put("status", "fail");
	        response.put("message", "서버 오류 발생");
	    }
	    return response;
	}
	
	    
	@Override
	@ResponseBody
	 @RequestMapping(value = "/updateCart.do", method = RequestMethod.POST) // ✅ 메서드 매핑
	    public Map<String, Object> updateCart(@RequestParam("cart_id") int cartId, 
	                                          @RequestParam("order_goods_qty") int orderGoodsQty,
	                                          HttpServletRequest request) {
		
			String cart_id = request.getParameter("cart_id");
			String order_goods_qty = request.getParameter("order_goods_qty");
			System.out.println("updateCart 실행 : " + cart_id + order_goods_qty);
	        Map<String, Object> response = new HashMap<>();
	        try {
	            HttpSession session = request.getSession();
	            MemberVO memberVO = (MemberVO) session.getAttribute("member");

	            if (memberVO == null) {
	                response.put("status", "error");
	                response.put("message", "로그인이 필요합니다.");
	                return response;
	            }

	            //  수량 업데이트 실행
	            int updatedRows = cartService.updateCart(cartId, memberVO.getMem_id(), orderGoodsQty);

	            if (updatedRows == 0) {
	                response.put("status", "error");
	                response.put("message", "수량 변경 실패: cart_id=" + cartId);
	            } else {
	                response.put("status", "success");
	            }

	            System.out.println(" [updateCart] cart_id: " + cartId + ", 변경된 수량: " + orderGoodsQty);
	            System.out.println(" [updateCart] 변경된 행 개수: " + updatedRows);

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.put("status", "error");
	            response.put("message", "서버 오류: " + e.getMessage());
	        }

	        return response;
	    }


	

}
