package com.sh.obtg.ootd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.common.HelloMvcUtils;
import com.sh.obtg.ootd.model.service.OotdBoardService;

/**
 * Servlet implementation class ootdList
 * 혜진-ootd게시판시작 
 */
@WebServlet("/ootd/ootdList")
public class OotdListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OotdBoardService ootdBoardService = new OotdBoardService();

	/**  사진 / 제목 /아이디만 꺼내 ?
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1 사용자입력값 - 없음 
		
		//2. 업무로직 - 전체게시물 수 조회 -> 전체페이지수 구하기 
		int totalCount = ootdBoardService.getTotalCount();
		System.out.println( "**totalCount(전체사진갯수) = " + totalCount   );
		
		// 전체 페이지 수 구하기 
		try { 
			int limit = 5;
			int page = 1;
			page  = Integer.parseInt(request.getParameter("page"));

			int totalPage = (int)Math.ceil( (double)totalCount/ limit );
			System.out.println( "**totalPage(전체 페이지 수) = " + totalPage   );
		
		//	try{
		//		page  = Integer.parseInt(request.getParameter("page"));
		//	}catch(NumberFormatException e) {
		//		e.printStackTrace();
		//	}
			
		Map<String, Object> param = new HashMap<>();
		param.put("page", page);
		param.put("limit", limit);
		
		String url = request.getRequestURI(); // /mvc/board/boardList -> ootdList ?
		String pagebar = HelloMvcUtils.getPagebar(page, limit, totalCount, url);
		System.out.println("pagebar : " + pagebar );
		request.setAttribute("pagebar", pagebar);
		
		//3. view단응답처리 (연결)
		request.setAttribute("totalPage", totalPage);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("/WEB-INF/views/ootd/ootdList.jsp")
		.forward(request, response); // 
	
	}

 }
