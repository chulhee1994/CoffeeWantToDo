package com.myspring.team.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface AdminController {
    public ModelAndView adminmain(@RequestParam(value = "result", required = false) String result,
                                    @RequestParam(value = "action", required = false) String action,
                                    HttpServletRequest request, HttpServletResponse response) throws Exception;
}
