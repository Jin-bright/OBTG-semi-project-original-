package com.sh.obtg.report.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.report.model.dto.Reason;
import com.sh.obtg.report.model.dto.Report;
import com.sh.obtg.report.model.service.ReportService;

/**
 * Servlet implementation class ReportEnrollServlet
 */
@WebServlet("/report/reportEnroll")
public class ReportEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReportService reportService = new ReportService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력값
			String memberId = request.getParameter("reportedMemberId");
			
			// ootd게시판인지 share 게시판인지 구분용
			int _no = Integer.parseInt(request.getParameter("boardNo"));
			String n = String.valueOf(_no);
			int no = Integer.parseInt(n.substring(3));
			System.out.println("신고가 접수된 번호 = " + no);
			
			String _reason = request.getParameterValues("reason")[0];
			Reason reason = null;
			
			System.out.println("id = " + memberId 
					  +" no = " + no 
					  +" reason = " + _reason);
			
			switch (_reason) {
			case "R1":
				reason = Reason.R1;
				break;
			case "R2":
				reason = Reason.R2;
				break;
			case "R3":
				reason = Reason.R3;
				break;
			case "R4":
				reason = Reason.R3;
				break;
			case "R5":
				reason = Reason.R3;
				break;
			}

			Report report = new Report();
			report.setReportedUserId(memberId);
			report.setBoardNo(no);
			report.setReportReason(reason);
			
			// 업무로직 insert
			int result = reportService.insertReport(report);
			
			// view단 처리
			int board = Integer.parseInt(n.substring(0, 1));
			System.out.println("어느 게시판일까?(8 - ootd, 9 - share) " + board);
			
			if(board == 8) {
				response.sendRedirect(request.getContextPath() + "/ootd/ootdView?no=" + no);				
			}
			else if(board == 9) {
				response.sendRedirect(request.getContextPath() + "/share/shareView?no=" + no);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}

}
