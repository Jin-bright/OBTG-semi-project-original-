<%@page import="com.sh.obtg.member.model.dto.Like"%>
<%@page import="com.sh.obtg.share.model.dto.ShareBoard"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Like> shareLikes = (List<Like>)request.getAttribute("shareLikes");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberView.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberLike.css" />
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
					<li>&nbsp;Message</li>
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
	<section id="like-container">
	<div id="like-nav">
		<span><a href="<%= request.getContextPath() %>/member/memberOotdLike">OOTD</a></span>
		<span style="font-weight: 900;"><a href="<%= request.getContextPath() %>/member/memberShareLike">SHARE</a></span>
	</div>
	<table id="like-wrap">
	<% 
		for(int i = 0; i < shareLikes.size(); i++) {
			if(i % 4 == 0 ){
	%>
		<tr>
		<% } %>
			<td>
				<a href="<%= request.getContextPath() %>/share/shareView?no=<%= shareLikes.get(i).getNo() %>">
					<img src="<%= request.getContextPath() %>/uploadshares/share/<%= shareLikes.get(i).getRenamed_filename() %>" alt="" />
					<p><%= shareLikes.get(i).getTitle() %></p>
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