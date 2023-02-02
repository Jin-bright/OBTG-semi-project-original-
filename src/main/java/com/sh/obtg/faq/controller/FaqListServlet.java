package com.sh.obtg.faq.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.common.HelloMvcUtils;
import com.sh.obtg.faq.model.dto.faq;
import com.sh.obtg.faq.model.service.FaqService;


@WebServlet("/faq/faqList")
public class FaqListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FaqService faqService = new FaqService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 
		final int limit = 5;
		int page = 1;
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			
		Map<String, Object> param = new HashMap<>();
		param.put("page", page);
		param.put("limit", limit);
		
		// 업무로직
		List<faq> faqList = faqService.selectFaqList(param);
		
		int totalCount = faqService.selectTotalCount();
		
		String url = request.getRequestURI();
		String pagebar = HelloMvcUtils.getPagebar(page, limit, totalCount, url);
		
		// view단 처리
		request.setAttribute("faqList", faqList);
		request.setAttribute("pagebar", pagebar);
		request.getRequestDispatcher("/WEB-INF/views/faq/faqList.jsp")
		.forward(request, response);
		
		}
	}
}
