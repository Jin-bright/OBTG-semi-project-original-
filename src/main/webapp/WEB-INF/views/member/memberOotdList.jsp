<%@page import="com.sh.obtg.member.model.dto.MyPost"%>
<%@page import="com.sh.obtg.share.model.dto.ShareBoard"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<MyPost> ootdBoardList = (List<MyPost>)request.getAttribute("ootdBoardList");
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
				<a href="<%= request.getContextPath() %>/member/memberOotdList">
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
				<a href="<%= request.getContextPath() %>/member/memberOotdLike">
					<img src="<%= request.getContextPath()%>/image/like.png" alt="" />
					<li>&nbsp;Like</li>
				</a>
			</div>
		</ul>
	</div>
	<hr />
	<section id="board-container">
		<div id="nav-container"> 
			<span style="font-weight: 900"><a href="<%= request.getContextPath() %>/member/memberOotdList">ootd</a></span>
			<span><a href="<%= request.getContextPath() %>/member/memberShareList">share</a></span>
		</div>
		<table id="boardList-wrap">
		<% 
			for(int i = 0; i < ootdBoardList.size(); i++) {
				if(i % 4 == 0 ){
		%>
			<tr>
			<% } %>
				<td>
					<a href="<%= request.getContextPath() %>/ootd/ootdView?no=<%= ootdBoardList.get(i).getNo() %>">
						<img src="<%= request.getContextPath() %>/uploadootds/ootd/<%= ootdBoardList.get(i).getRenamedFilename() %>" alt="" />
						<p id="b_title"><%= ootdBoardList.get(i).getTitle() %></p>
						<p id="b_txt"><%= ootdBoardList.get(i).getRegDate() %> | 조회수 : <%= ootdBoardList.get(i).getReadCount() %></p>
					</a>
				</td>
			<% if(i % 4 == 3){%>
			</tr>
		<% 
				}   	    
			}
		%> 
		</table>
	</section>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>