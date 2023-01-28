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
	
	int likeCnt = (int)request.getAttribute("likeCnt");
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
			<td><%= shareBoard.getShareProductStatus()  %></td>
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
		<% if(loginMember == null || likeCnt == 0) { %>
		<img src="<%= request.getContextPath() %>/image/heart.png" class="shareLike" alt="좋아요"/>
		<% } else { %>
		<img src="<%= request.getContextPath() %>/image/heart _over.png" class="shareLike" alt="좋아요" />
		<% } %>
		<%
			boolean canEdit = loginMember != null && 
								(loginMember.getMemberRole() == MemberRole.A ||
									loginMember.getMemberId().equals(shareBoard.getMemberId()));
			if(canEdit){
		%>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			
				<button class ="sharemodidel" type="submit" onclick="updateBoard()"> 수정하기 </button>
				<button class ="sharemodidel"  type="submit"  onclick="deleteBoard()"> 삭제하기 </button>

		<% 
			} else {
		%>
				<img src="<%= request.getContextPath() %>/image/siren.png" alt="" id="siren" onclick="reportFrm()"/>
			
		
		<% } %>
	</div>
	<br /><br /><br /><br /><br />
<!-- 게시글 삭제하기 히든폼 ( 관리자 & 작성자에게만 노출 ) -->	
<form action="<%=request.getContextPath()%>/share/shareDelete" name = "boardDeleteFrm" method="post">
	<input type="hidden" name="no" value="<%= shareBoard.getShareNo() %>" />
</form>

<!-- 신고하기 폼(누르면 나타나용) -->
<% if(loginMember != null){ %>
<form 
	class="report_container"
	name="reportEnrollFrm"
	method="post"
	action="<%= request.getContextPath() %>/report/reportEnroll">
	<span class="close-button" onclick="closeFrm()">&times;</span>
    <h2 style="text-align: center; margin: 5px;" >신고하기</h2>
    <hr />
    <table id="report_wrap">
        <thead>
            <tr>
                <th><label for="">신고자</label></th>
                <td><input type="text" value="<%= loginMember.getMemberId() %>" name="reportedMemberId" readonly="readonly"/></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th><label for="">게시글 번호</label></th>
                <td><input type="text" value="222<%= shareBoard.getShareNo() %>" name="boardNo" readonly="readonly"/></td>
            </tr>
            <tr>
                <td colspan="2"><hr style="width: 95%;" /></td>
            </tr>
        </tbody>
    </table>
    <span style="margin-left: 1em; font-weight: bold;">사유선택</span>
    <table id="reason_wrap">
        <tbody>
            <tr>
                <th><input type="checkbox" name="reason" value="R1" onclick="checkOnlyOne(this)"></th>
                <td>스팸홍보/도배글입니다.</td>
            </tr>
            <tr>
                <th><input type="checkbox" name="reason" value="R2" onclick="checkOnlyOne(this)"></th>
                <td>불법정보를 포함하고있습니다.</td>
            </tr>
            <tr>
                <th><input type="checkbox" name="reason" value="R3" onclick="checkOnlyOne(this)"></th>
                <td>욕설/생명경시/혐오/차별적 표현입니다.</td>
            </tr>
            <tr>
                <th><input type="checkbox" name="reason" value="R4" onclick="checkOnlyOne(this)"></th>
                <td>개인정보 노출 게시물입니다.</td>
            </tr>
            <tr>
                <th><input type="checkbox" name="reason" value="R5" onclick="checkOnlyOne(this)"></th>
                <td>불쾌한 표현이 있습니다.</td>
            </tr>
        </tbody>
    </table> <!-- end reason_wrap -->
    <div style="text-align: center;">
        <input type="submit" value="신고하기">
    </div>
</form>
<% } %>
	
<script>
// 게시글 수정 / 삭제 
const deleteBoard = () => { 
	if(confirm("정말 게시글을 삭제하시겠습니까? ")){
	  document.boardDeleteFrm.submit();	
	}	
};

const updateBoard = () => { 
	location.href = "<%=request.getContextPath()%>/share/shareUpdate?no=<%=shareBoard.getShareNo()%>";
}

const loginAlert = () => {
	alert("로그인 후 이용할 수 있습니다.");
	document.querySelector("#loginSignup").focus();
};
</script>	
	
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

<script>
/* 좋아요 */
document.querySelector(".shareLike").addEventListener("click", (e) => {
	<% if(loginMember == null){ %>
		 loginAlert();
	<% } else { %>
		$.ajax({
			url: "<%= request.getContextPath() %>/share/shareLike?no=<%= shareBoard.getShareNo() %>",
			method: "post",
			dataType: "json",
			success(data){
				if(data === 1) e.target.src="<%= request.getContextPath() %>/image/heart _over.png"
				else e.target.src="<%= request.getContextPath() %>/image/heart.png"
			},
			error: console.log
			});
	<% } %>
});

/* 신고 */
const reportFrm = () => {
	const frm = document.querySelector(".report_container");
	<% if(loginMember != null){ %>
	frm.classList.toggle("showPopup");
	<% } else { %>
	loginAlert();
	<% } %>
}

const closeFrm = () => {
	const frm = document.querySelector(".report_container");
	frm.classList.toggle("showPopup");
}

const checkOnlyOne = (e) => {
    const checkbox = document.getElementsByName("reason");

    checkbox.forEach((cb) => {
        cb.checked = false;
    })

    e.checked = true;
} 

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>