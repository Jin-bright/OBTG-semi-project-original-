<%@page import="com.sh.obtg.share.model.dto.ShareBoard"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<OotdBoard> ootdBoardList = (List<OotdBoard>)request.getAttribute("ootdBoardList");
	List<ShareBoard> shareBoardList = (List<ShareBoard>)request.getAttribute("shareBoardList");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberView.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberBoardList.css" />
<div class="main">
	<div class="container-menu">
		<ul>
			<div class="container-li">
				<a href="<%= request.getContextPath()%>/member/memberView">
					<img src="<%= request.getContextPath()%>/image/modify.png" alt="" />
					<li>&nbsp;Info</li>
				</a>
			</div>
			<div class="container-li">
				<a href="<%= request.getContextPath() %>/member/memberBoardList">
					<img src="<%= request.getContextPath()%>/image/list.png" alt="" />
					<li>&nbsp;List</li>
				</a>
			</div>
			<div class="container-li">
				<a href="">
					<img src="<%= request.getContextPath()%>/image/chat.png" alt="" />
					<li>&nbsp;Chat</li>
				</a>
			</div>
			<div class="container-li">
				<a href="">
					<img src="<%= request.getContextPath()%>/image/like.png" alt="" />
					<li>&nbsp;Like</li>
				</a>
			</div>
		</ul>
	</div>
	<hr />
	<section id="board-container">
		 <table id="boardList-wrap">
	        <thead>
	            <tr>
	                <th>No</th>
	                <th>제목</th>
	                <th>작성일</th>
	                <th>조회수</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<% 
	        		for(OotdBoard ob : ootdBoardList){
	        	%>
	            <tr>
	                <td style="padding: 10px;">OOTD<%= ob.getOotdNo() %></td>
	                <td><%= ob.getOOTDTitle() %></td>
	                <td><%= ob.getOOTDRegDate() %></td>
	                <td><%= ob.getOOTDReadCount() %></td>
	            </tr>
	            <% 
	        		} 
	        	%>
	        	<%
	        		for(ShareBoard sb : shareBoardList){
	        	%>
	        	<tr>
	        		<td style="padding: 10px;">Share<%= sb.getShareNo() %></td>
	        		<td><%= sb.getShareTitle() %></td>
	        		<td><%= sb.getShareRegDate() %></td>
	        		<td><%= sb.getShareReadCount() %></td>
	        	</tr>
	        	<%
	        		}
	        	%>
	        </tbody>
	    </table>
	    <div id='pagebar' style="text-align: center; padding-top: 10px;">
			<%= request.getAttribute("pagebar") %>
		</div>
	</section>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>