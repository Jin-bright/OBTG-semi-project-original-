package com.sh.obtg.ootd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.service.OotdBoardService;

/**
 * Servlet implementation class OotdUpdateServlet
 */
@WebServlet("/ootd/ootdUpdate")
public class OotdUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OotdBoardService ootdBoardService = new OotdBoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("no = " + no);
		
		
		
		//2. 업무로직 
		OotdBoard board = ootdBoardService.selectOneBoard(no);		
		System.out.println( "board = "  + board );
		
		
		request.setAttribute("board", board);
		request.getRequestDispatcher("/WEB-INF/views/ootd/ootdboardUpdate.jsp")
		.forward(request, response);
	}
		
		
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
