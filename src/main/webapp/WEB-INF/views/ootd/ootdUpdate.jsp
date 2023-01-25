<%@page import="com.sh.obtg.ootd.model.dto.OotdBoardComment"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="java.util.List"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdAttachment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdView.css" />
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&family=Solitreo&display=swap" rel="stylesheet">

<%
//String msg = (String)session.getAttribute("msg");
//int totalPage = (int)request.getAttribute("totalPage");

//if( msg != null )
//	session.removeAttribute("msg");
// 리스트 가져오는거 필요함 
 OotdBoard ootdboard = (OotdBoard) request.getAttribute("ootdboard");
 List<OotdAttachment> ootdAttachments = (List<OotdAttachment>)request.getAttribute("ootdAttachments");
 List<OotdBoardComment> comments  = (List<OotdBoardComment>)request.getAttribute("comments");
 
%>


<section id="board-container" >
<br /><br /><br /><br /><br /><br /><br />
	<p id="informationsp" > INFORMATION  <span id="styleinfo" ">스타일 정보</span></p>
<ul class="ootdnav">
	<li class="button-dropdown">
	   	<a id="firsta" href="javascript:void(0)" class="dropdown-toggle">
	    <img id="profileimg" src="<%=request.getContextPath()%>/uploadootds/ootd/profile.png" alt="profileimg" /> </a>
	    
	    <ul class="dropdown-menu">
	      <li><a href="#">프로필보기</a></li>
	      <li><a href="#">채팅걸기</a></li>
	    </ul>
   </li>
</ul>
  
<div class="imgNtableContainer">
 <div class="box">
	<% 
	if(!ootdboard.getOotdAttachments().isEmpty()) {
		for(OotdAttachment ootdAttachment : ootdboard.getOotdAttachments() ){
	%>
	<tr>
		<td>
			<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
		<img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachment.getRenamedFilename()%>" style="width:400px; height : 650px" >
		</td>
	</tr>	
	<% 
		}
	} 
	%>
  </div>
  <div class="box">
	<table id="tblboardview">
		<tr>
			<th>아이디</th>
			<td><%= ootdboard.getOotdWriter() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= ootdboard.getOOTDTitle() %></td>
		</tr>
		<tr>
			<th>상 의</th>
			<td><%= ootdboard.getOOTDTop()  %></td>
		</tr>
		<tr>
			<th>하 의</th>
			<td><%= ootdboard.getOOTDBottom()  %></td>
		</tr>
		<tr>
			<th>신 발</th>
			<td><%= ootdboard.getOOTDShoes()  %></td>
		</tr>
		<tr>
			<th>기 타</th>
			<td><%= ootdboard.getOOTDEtc()  %></td>
		</tr>
		
		
	
		<tr>
			<th>조회수</th>
			<td><%= ootdboard.getOOTDReadCount() %></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%= ootdboard.getOOTDRegDate() %></td>
		</tr>
		
			<tr>
			<th>스타일</th>
			<% if ( ootdboard.getStyleNo().toString().equals("S1")) { %>
			<td class="styleinfo"> #로맨틱</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S2")) {%>
			<td class="styleinfo"> #댄디</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S3")) {%>
			<td class="styleinfo"> #포멀</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S4")) {%>
			<td class="styleinfo"> #스트릿</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S5")) {%>
			<td class="styleinfo"> #걸리쉬</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S6")) {%>
			<td class="styleinfo" > #레트로</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S7")) {%>
			<td class="styleinfo"> #로맨틱</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S8")) {%>
			<td class="styleinfo"> #시크</td>
			<% } else if( ootdboard.getStyleNo().toString().equals("S9")) {%>
			<td class="styleinfo"> #아메카지</td>	
			<% } %>		
		</tr>
		
	</table><br />
	<div id="contents" > <p style="float:left; margin-left : 30px">CONTENT</p><br />
		<div id="contentsbox" ><%= ootdboard.getOOTDContents() %></div>	
		<img id="ootdlikes" src="<%=request.getContextPath()%>/uploadootds/heart.png" alt="좋아요" />
		<%
			//boolean canEdit = loginMember != null && 
			//					(loginMember.getMemberRole() == MemberRole.A ||
			//						loginMember.getMemberId().equals(board.getWriter()));
			//if(canEdit){
		%>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
				<button class ="ootdmodidel" type="submit" onclick="updateBoard()"> 수정하기 </button>
				<button class ="ootdmodidel"  type="submit"  onclick="deleteBoard()"> 삭제하기 </button>
		<% 
//			}
		%>
	</div>
<!-- content modi del 좋아요  -->
  </div>
</div> <!-- <div class="imgNtableContainer"> ?  -->
<br /><br />