package com.sh.obtg.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sh.obtg.common.HelloMvcUtils;
import com.sh.obtg.member.model.dto.Member;
import com.sh.obtg.member.model.service.MemberService;
import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.share.model.dto.ShareBoard;

/**
 * Servlet implementation class MemberBoardListServlet
 */
@WebServlet("/member/memberBoardList")
public class MemberBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try { 
			// 페이징 
			final int limit = 3;
			int page = 1;
			
			try{
				page  = Integer.parseInt(request.getParameter("page"));
			}catch(NumberFormatException e) {}
			
			Map<String, Object> param = new HashMap<>();
			param.put("page", page);
			param.put("limit", limit);	

			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			String memberId = loginMember.getMemberId();
			
			List<OotdBoard> ootdBoardList = memberService.selectMyOotdPost(memberId, param);
			List<ShareBoard> shareBoardList = memberService.selectMySharePost(memberId, param);
			
		 	
			int totalCount = memberService.getMyPostTotalCount(memberId);
			System.out.println("> 내가 쓴 게시글 수 : " +  totalCount);

			String url = request.getRequestURI();
			String pagebar = HelloMvcUtils.getPagebar(page, limit, totalCount, url);
			System.out.println("> pagebar" + pagebar);
			
			request.setAttribute("pagebar", pagebar);
			request.setAttribute("ootdBoardList", ootdBoardList);
			request.setAttribute("shareBoardList", shareBoardList);
				
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
				
		request.getRequestDispatcher("/WEB-INF/views/member/memberBoardList.jsp")
			.forward(request, response);
		
	}

}
