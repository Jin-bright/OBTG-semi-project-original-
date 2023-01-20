package com.sh.obtg.column.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.column.model.dto.Column;
import com.sh.obtg.column.model.service.ColumnService;

/**
 * Servlet implementation class ColumnEnrollServlet
 */
@WebServlet("/column/columnEnroll")
public class ColumnEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ColumnService columnService = new ColumnService();
	
	/**
	 * column 작성폼 get 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/column/columnEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * column 저장 post 요청(아직 완성아님 - mutipartRequest 객체 생성해야함)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. MultipartRequest 객체 생성
			String saveDircetory = getServletContext().getRealPath("/upload/board");
			int maxPostSize = 10 * 1024 * 1024;
			String encoding = "utf-8";
			
			// 2. 사용자 입력값 처리
			String title = request.getParameter("col_title");
			String content = request.getParameter("col_content");
			
			Column column = new Column(maxPostSize, encoding, title, content, title, content, maxPostSize, null);
			
			// 2. 업무로직(insert)
//			int result = columnService.insertColumn(column);
			
			// 3. 리다이렉트 - 작성한 글로
			response.sendRedirect(request.getContextPath() + "/column/columnView?no=" + column.getNo());
		} catch (IOException e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "컬럼을 등록하는데 문제가 생겼습니다.");
			response.sendRedirect(request.getContextPath() + "/column/columnList");
		}
	}

}
