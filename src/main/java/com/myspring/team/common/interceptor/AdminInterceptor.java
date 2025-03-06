package com.myspring.team.common.interceptor;

import com.myspring.team.member.vo.MemberVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에서 member 정보를 가져옵니다.
        Object member = request.getSession().getAttribute("member");

        if (member != null) {
            // member 객체에서 mem_grade 값을 확인 (admin인지 seller인지)
            String memGrade = ((MemberVO) member).getMem_grade();
            
            // admin일 경우, 그대로 진행
            if ("admin".equals(memGrade)) {
                return true;
            }

            // seller일 경우 예외 경로 처리
            if ("seller".equals(memGrade)) {
                String requestURI = request.getRequestURI();

                // seller가 접근할 수 있는 페이지를 지정
                if (requestURI.contains("/admin/goods/addNewGoodsForm.do") 
                		|| requestURI.contains("/admin/goods/modGoodsForm.do") 
                		|| requestURI.contains("/admin/goods/modgoodsListBean.do") 
                		|| requestURI.contains("/admin/goods/modgoodsListBakery.do")
                		|| requestURI.contains("/admin/goods/modgoodsListTool.do")
                		|| requestURI.contains("/admin/goods/addNewGoods.do")
                		|| requestURI.contains("/admin/goods/modsearchGoods.do")
                		|| requestURI.contains("/admin/goods/updateGoods.do")               		
                		|| requestURI.contains("/admin/sellergoodsList.do")
                		
                		) {
                    return true;
                }
                
            }
            // common일 경우 예외 경로 처리
            if ("common".equals(memGrade)) {
                String requestURI = request.getRequestURI();

                // common가 접근할 수 있는 페이지를 지정
                if (requestURI.contains("admin/order/image.do")
                		) {
                    return true;
                }
                
            }
        }
        
        // admin도 아니고 seller도 아니거나 세션에 member가 없는 경우 /403.에러로 리디렉션
        response.sendRedirect("/WantToDo/common/error/403errorForm.do");
        return false;  // 요청을 컨트롤러로 전달하지 않음
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // postHandle 메서드는 선택적이지만, 여기서 추가적인 후처리 작업을 할 수 있습니다.
        // 예를 들어, 컨트롤러에서 처리한 데이터를 수정하거나 로그를 남길 수 있습니다.
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // 요청 처리 후 후처리 작업을 수행합니다. 예를 들어, 리소스 정리, 로그 기록 등을 할 수 있습니다.
        // 예외가 발생한 경우에 로그를 남길 수도 있습니다.
        
        if (ex != null) {
            // 예외 처리 (로그 남기기 등)
            System.out.println("요청 처리 중 예외 발생: " + ex.getMessage());
        }
        System.out.println("요청 처리 후 후속 작업");
    }
}
