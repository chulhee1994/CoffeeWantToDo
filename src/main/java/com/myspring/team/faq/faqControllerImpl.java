package com.myspring.team.faq;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("faqController")
public class faqControllerImpl implements faqController {


	// FAQ 리스트 전체 출력
		@Override
		@RequestMapping(value = "/faq/faqLists.do", method = RequestMethod.GET)
		public String faqLists(HttpServletRequest req, HttpServletResponse res) throws Exception {		  
		    return "faq/faqLists";
		}
}
