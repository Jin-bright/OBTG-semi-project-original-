<%@page import="com.sh.obtg.report.model.dto.Report"%>
<%@page import="java.util.List"%>
<%@ page import="com.sh.obtg.member.model.dto.Member" %>
<%@ page import="com.sh.obtg.member.model.dto.MemberRole" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%
	List<Report> reports = (List<Report>)request.getAttribute("reports");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/adminView.jsp" %>
<style>
#report-container {
	height: -webkit-fill-available;
	text-align:center; 
	padding-left: 200px; 
	margin-bottom: 70px;
}
#report_wrap, #report_wrap td, #report_wrap th {
	border: 1px solid black;
	border-collapse: collapse;
}
#report_wrap {
	width: 850px;
	border-collapse: collapse;
	margin-bottom: 24px;
}
</style>
<section id="report-container">
	<br /><br /><br /><br /><br />
	<h2>신고관리</h2>
	<table id="report_wrap">
		<thead>
			<tr>
				<th>No</th>
				<th>신고자</th>
				<th>게시번호</th>
				<th>신고사유</th>
				<th>신고날짜</th>
				<th>처리상태</th>
			</tr>
		</thead>
		<tbody>
			<% if(reports != null){
				for(Report report : reports) {
			%>
			<tr>
				<td><%= report.getReportNo() %></td>
				<td><%= report.getReportedUserId() %></td>
				<% 
					String no = report.getBoardNo();
					String board = no.substring(0, 1);
					int num = Integer.parseInt(no.substring(1));
				%>
				<td>
				<% if(board.equals("O")) { %>
					<a href="<%= request.getContextPath() %>/ootd/ootdView?no=<%= num %>"><%= report.getBoardNo() %></a>
				<% } else { %>
					<a href="<%= request.getContextPath() %>/share/shareView?no=<%= num %>"><%= report.getBoardNo() %></a>
				<% } %>
				</td>
				<%
				String reason = null;
				switch(report.getReportReason()){
				case R1:
					reason = "스팸홍보/도배글입니다.";
					break;
				case R2:
					reason = "불법정보를 포함하고있습니다.";
					break;
				case R3:
					reason = "욕설/생명경시/혐오/차별적 표현입니다.";
					break;
				case R4:
					reason = "개인정보 노출 게시물입니다.";
					break;
				case R5:
					reason = "불쾌한 표현이 있습니다.";
					break;
				}
				%>
				<td><%= reason %></td>
				<td><%= report.getRegDate() %></td>
				<td><%= report.getReportStatus() %></td>
			</tr>
			<% 	} 
			   }else{
			%>
			<tr>
				<td colspan="6">조회된 신고내역이 없습니다.</td>
			</tr>	
			<% } %>
		</tbody>
	</table>
	<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
