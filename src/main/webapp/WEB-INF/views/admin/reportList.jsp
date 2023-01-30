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
	height: 810px;
	text-align:center; 
	padding-left: 200px; 
	/* margin-bottom: 70px; */
}
#report_wrap, #report_wrap td, #report_wrap th {
	border-collapse: collapse;
}
#report_wrap {
	width: 85%;
    margin: 0 0 10px 35px;
    padding: 3px;
}
#report_wrap thead tr{
    border-bottom: 1px solid #ECEEF1;
}
#report_wrap tbody tr{
    border-bottom: 1px solid #ECEEF1;
}

#report_wrap th {
	border: 0;
	padding: 12px 4px;
}

#report_wrap td {
	padding: 12px 4px;
}
</style>
<section id="report-container">
	<br /><br /><br /><br />
	<h1>신고관리</h1>
	<br /><br /><br />
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
