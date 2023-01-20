package com.sh.obtg.ootd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sh.obtg.common.OotdFileRenamePolicy;

import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.dto.Style;

/**
 * Servlet implementation class OotdEnrollServlet
 */
@WebServlet("/ootd/ootdEnroll")
public class OotdEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private OotdBoardService ootdBoardService = new OotdBoardService();
	/**
	 * 혜진 - ootd 글쓰기 폼 서블렛 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/ootd/ootdEnroll.jsp")
		.forward(request, response);	
	}



}
