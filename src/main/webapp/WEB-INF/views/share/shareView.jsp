<%@page import="com.sh.obtg.share.model.dto.ShareBoard"%>
<%@page import="com.sh.obtg.share.model.dto.ShareBoardEntity"%>
<%@page import="com.sh.obtg.share.model.dto.ShareAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shareView.css" />
<%
	ShareBoard shareBoard = (ShareBoard)request.getAttribute("shareBoard");
	List<ShareAttachment> shareAttachments = (List<ShareAttachment>)request.getAttribute("shareAttachments");
// ★★★★★★★★ 이걸로 난중에닉네임빼기
    Member membmer = (Member) request.getAttribute("membmer");
//	Member loginMember = (Member) session.getAttribute("loginMember"); //object -> member  			
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
	if(! shareBoard.getShareAttachments().isEmpty()) {
		for(ShareAttachment shareAttachment : shareBoard.getShareAttachments()  ){
	%>
	<tr>
		<td>
			<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
		<img src="<%=request.getContextPath()%>/uploadshares/share/<%=shareAttachment.getRenamedFilename()%>" style="width:400px; height : 400px" >
		</td>
	</tr>	
	<% 
		}
	} 
	%>
  </div>
  <div class="box2">
	<table id="tblboardview">
		<tr>
 			<th>아이디</th>
			<td><%= shareBoard.getMemberId() %></td>
 
<%-- 			<th>닉네임</th>
 <% if( shareBoard.getMemberId()!= null &&  shareBoard.getMemberId() == membmer.getMemberId() ){ %> 			
			<td><%=membmer.getNickname() %></td>
	<% } %> --%>
 		</tr>
		<tr>
			<th>제 목</th>
			<td><%= shareBoard.getShareTitle() %></td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td><%= shareBoard.getShareCategory()  %></td>
		</tr>
		<tr>
			<th>구매시기</th>
			<td><%= shareBoard.getShareBuyDate()  %></td>
		</tr>
		<tr>
			<th>상품상태</th>
			<td><%= shareBoard.getShareState()  %></td>
		</tr>

		<tr>
			<th>조회수</th>
			<td><%= shareBoard.getShareReadCount() %></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%= shareBoard.getShareRegDate() %></td>
		</tr>
		
			<tr>
			<th>스타일</th>
			<% if ( (shareBoard.getStyleNo().toString()).equals("S1")) { %>
			<td class="styleinfo"> #로맨틱</td>
			<% } else if( (shareBoard.getStyleNo().toString()).equals("S2")) {%>
			<td class="styleinfo"> #댄디 </td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S3")) {%>
			<td class="styleinfo"> #포멀</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S4")) {%>
			<td class="styleinfo"> #스트릿</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S5")) {%>
			<td class="styleinfo"> #걸리쉬</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S6")) {%>
			<td class="styleinfo" > #레트로</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S7")) {%>
			<td class="styleinfo"> #로맨틱</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S8")) {%>
			<td class="styleinfo"> #시크</td>
			<% } else if( shareBoard.getStyleNo().toString().equals("S9")) {%>
			<td class="styleinfo"> #아메카지</td>	
			<% } %>		
		</tr>
		
	</table><br />
	<div id="contents" > <p style="float:left; margin-left : 30px; font-weight:bolder">CONTENT</p><br />
		<div id="contentsbox" ><%= shareBoard.getShareContent() %></div>	
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
	<br /><br /><br /><br /><br />
<script>
// 프로필 & 
jQuery(document).ready(function (e) {
    function t(t) {
        e(t).bind("click", function (t) {
            t.preventDefault();
            e(this).parent().fadeOut()
        })
    }
    e(".dropdown-toggle").click(function () {
        var t = e(this).parents(".button-dropdown").children(".dropdown-menu").is(":hidden");
        e(".button-dropdown .dropdown-menu").hide();
        e(".button-dropdown .dropdown-toggle").removeClass("active");
        if (t) {
            e(this).parents(".button-dropdown").children(".dropdown-menu").toggle().parents(".button-dropdown").children(".dropdown-toggle").addClass("active")
        }
    });
    e(document).bind("click", function (t) {
        var n = e(t.target);
        if (!n.parents().hasClass("button-dropdown")) e(".button-dropdown .dropdown-menu").hide();
    });
    e(document).bind("click", function (t) {
        var n = e(t.target);
        if (!n.parents().hasClass("button-dropdown")) e(".button-dropdown .dropdown-toggle").removeClass("active");
    })
});
</script>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>