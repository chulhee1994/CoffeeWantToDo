package com.myspring.team.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.member.vo.MemberVO;

public class SellerInterceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에서 member 정보를 가져옵니다.
        Object member = request.getSession().getAttribute("member");

        if (member != null) {
            // member 객체에서 mem_grade 값을 확인 (admin인지 seller인지)
            String memGrade = ((MemberVO) member).getMem_grade();

            // admin일 경우, 그대로 진행
            if ("seller".equals(memGrade)) {
                return true;
            }

        }


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