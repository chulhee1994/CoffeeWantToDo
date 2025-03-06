package com.myspring.team.faq;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public interface faqController {

	public String faqLists(HttpServletRequest req, HttpServletResponse res) throws Exception;
}
