package com.myspring.team.common.error;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("errorController")
public class errorController {
	//Form 으로 끝나는 모든 jsp호출
	@RequestMapping(value = "/common/error/*Form.do", method = RequestMethod.GET)
	private ModelAndView form(@RequestParam(value= "result", required = false) String result,
							  @RequestParam(value= "action", required = false) String action,	
								HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}	
}
