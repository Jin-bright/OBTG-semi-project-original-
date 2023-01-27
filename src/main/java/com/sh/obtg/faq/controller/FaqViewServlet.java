package com.sh.obtg.faq.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.faq.model.dto.faq;
import com.sh.obtg.faq.model.service.FaqService;


@WebServlet("/faq/faqView")
public class FaqViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FaqService faqService = new FaqService();
       

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		int FaqNo = Integer.parseInt(request.getParameter("no"));
		
		// 쿠키 처리
		String faqCookieVal = "";
		boolean hasRead = false;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				
				if("faq".equals(name)) {
					faqCookieVal = value;
					if(value.contains("[" + FaqNo + "]" )) {
						hasRead = true;
					}
				}
			}
		}
		
		// 응답쿠키
		// 현재 게시글 쿠키 추가
		if(!hasRead) {
			Cookie cookie = new Cookie("faq", faqCookieVal + "[" + FaqNo + "]");
			cookie.setMaxAge(365 * 24 * 60 * 60); // 365일
			cookie.setPath(request.getContextPath() + "/faq/faqView");
			response.addCookie(cookie);
		}
		
		// 서비스단
		faq faq = faqService.selectOneFaq(FaqNo, hasRead);
		
		request.setAttribute("faq", faq);
		request.getRequestDispatcher("WEB-INF/views/faq/faqView.jsp")
		.forward(request, response);

	}
}
