package com.sh.obtg.share.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.share.model.service.ShareService;

@WebServlet("/share/shareList")
public class ShareListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShareService shareService = new ShareService();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/share/shareList.jsp")
		.forward(request, response);
	}
}
