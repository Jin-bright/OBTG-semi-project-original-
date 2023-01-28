package com.sh.obtg.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		  try { 
			  
		  String memberId = request.getParameter("memberId"); 
		  String style = request.getParameter("style"); 
		  String name = request.getParameter("name");
		  String password = request.getParameter("password");
		  String email = request.getParameter("password");
		  String phone = request.getParameter("password");
		  String _birthday = request.getParameter("password");
		  String nickname = request.getParameter("password");
		  String _gender = request.getParameter("password");
		  /*String password = request.getParameter("password");
		  String password = request.getParameter("password");*/
				  
		  }catch(Exception e) {
				// 회원가입실패 메세지
				session.setAttribute("msg", "회원가입 실패했습니다.");

				// 예외로깅
				e.printStackTrace();
			}
			
			// 4. 리다이렉트 - /mvc/
			response.sendRedirect(request.getContextPath() + "/");
			
		}

}
