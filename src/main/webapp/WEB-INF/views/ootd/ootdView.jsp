<%@page import="com.sh.obtg.ootd.model.dto.OotdBoardComment"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="java.util.List"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdAttachment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdView.css" />
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&family=Solitreo&display=swap" rel="stylesheet">
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> --%>

<%
//String msg = (String)session.getAttribute("msg");
//int totalPage = (int)request.getAttribute("totalPage");

//if( msg != null )
//	session.removeAttribute("msg");
// 리스트 가져오는거 필요함 
 OotdBoard ootdboard = (OotdBoard) request.getAttribute("ootdboard");
 List<OotdAttachment> ootdAttachments = (List<OotdAttachment>)request.getAttribute("ootdAttachments");
 List<OotdBoardComment> comments  = (List<OotdBoardComment>)request.getAttribute("comments");
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
			<td class="styleinfo"> #러블리</td>
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
	<div id="contents" > <p style="float:left; margin-left : 30px; font-weight:bolder">CONTENT</p><br />
		<div id="contentsbox" ><%= ootdboard.getOOTDContents() %></div>	
		<% if(likeCnt == 0) { %>
		<img src="<%= request.getContextPath() %>/image/heart.png" class="heart" alt="좋아요"/>
		<% } else { %>
		<img src="<%= request.getContextPath() %>/image/heart _over.png" class="heart" alt="좋아요" />
		<% } %>
		
		<%
			boolean canEdit = loginMember != null && 
								(loginMember.getMemberRole() == MemberRole.A ||
									loginMember.getMemberId().equals(ootdboard.getOotdWriter()));
			if(canEdit){
		%>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
				<button class ="ootdmodidel" type="submit" onclick="updateBoard()"> 수정하기 </button>
				<button class ="ootdmodidel"  type="submit"  onclick="deleteBoard()"> 삭제하기 </button>
		<% 
			}
		%>
	</div>
<!-- content modi del 좋아요  -->
  </div>
</div> <!-- <div class="imgNtableContainer"> ?  -->
<br /><br />
<!-- comment -->
 <hr style="margin-top:30px; border :none" />    
   <div class="comment-container">
    <div id="cmttitle" style = "font-weight:bolder; color:white"> COMMENT </div>
	<div class="comment-editor">
       <form action="<%=request.getContextPath()%>/ootd/ootdCommentEnroll" method="post" name="boardCommentFrm">  <!-- 댓글등록폼 -->
         <input type="hidden" name="boardNo" value="<%= ootdboard.getOotdNo() %>" />
    	 <input type="hidden" name="writer" value="<%= loginMember != null ? (loginMember.getMemberId()) : ""%>" /> 
         <input type="hidden" name="commentLevel" value="1" />
         <input type="hidden" name="commentRef" value="0" />    
         <textarea id="cmtcontent" name="content" cols="60" rows="3"></textarea>
         <button type="submit" id="btn-comment-enroll1">등록</button>
       </form>
     </div>
<!--  댓 --------- table#tbl-comment        -->
       <%
       	if(!comments.isEmpty() ){
       %>
            <table id="tbl-comment">
            <%
            	for(OotdBoardComment bc : comments){
            		if(bc.getCmtLevel() == 1 ){
            %>
            <%-- 댓글인 경우 tr.level1 --%>
            <tr class="level1">
                <td>
                    <sub class="comment-writer" style="font-weight:bolder"><b><%=bc.getMemberId() %></b></sub>
                    <sub class="comment-date" style="font-weight:bolder" ><b><%=bc.getCmtRegDate()%></b></sub>
                    <br />
                    <%-- 댓글내용 --%>
                    <%=bc.getCmtContent()%>
                </td>
                <td>
                    <button class="btn-reply" value="<%= bc.getCmtNo()%>" >답글</button>
                    <% if( loginMember != null && 
	                		 ( ( loginMember.getMemberId()).equals( bc.getMemberId()) || (loginMember.getMemberRole() == MemberRole.A ))) {%>
                 	<button class="btn-delete" value="<%= bc.getCmtNo() %>" >삭제</button>
					<% } %>  	
                </td>
            </tr>
            <%
          		}  else {
            %>
            <%-- 대댓글인 경우 tr.level2 --%>
            <tr class="level2">
                <td>
                    <sub class=comment-writer><b><%=bc.getMemberId()%></b></sub>
                    <sub class=comment-date><b><%=bc.getCmtRegDate()%></b></sub>
                <br />
                    <%-- 대댓글 내용 --%>
                    <%=bc.getCmtContent()%>
                </td>
                <td> 
	                <% if( loginMember != null && 
	                		 ( ( loginMember.getMemberId()).equals( bc.getMemberId()) || (loginMember.getMemberRole() == MemberRole.A ))) {%>
						<button class="btn-delete"  value="<%= bc.getCmtNo()%>"> 삭제</button>
				<	<% } %>   	
				</td>
            </tr>
            <%
          			}
            	}
            %>
  		
        </table>
        <%
        	}
        %>
<form action="<%= request.getContextPath() %>/ootd/ootdCommentDelete"  name="boardCommentDelFrm" method="POST">
	<input type="hidden" name="no" />
	<input type="hidden" name="boardNo" value="<%=ootdboard.getOotdNo() %>"/>
</form>
<br/><br /><br />
<script>
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
// 댓글 
// 이벤트 버블링을 통해 부모요소에서 이벤트핸들링 -- 이벤트전파 js에서 배운거,, 
document.body.addEventListener('submit', (e) => {

	console.log( "타켓" + e.target.value );
	if(e.target.name === 'boardCommentFrm'){

		<% if(loginMember == null ){%>
			loginAlert();
			e.preventDefault();
			return; // 조기리턴
		<% } %>
			
		//유효성검사 
		const content = e.target.content;
		if(!/^(.|\n)+$/.test(content.value)){
			e.preventDefault();
			alert("내용을 작성해주세요");
			content.focus();
		}	
	}
	
});


//textarea에대한 핸들링 

document.boardCommentFrm.content.addEventListener('focus', (e) => {
	<% if(loginMember == null ){%>
		loginAlert();		
	<% } %>
});

const loginAlert = () => {
	alert("로그인 후 이용할 수 있습니다.");
	document.querySelector("#loginSignup").focus();
};
</script>



<script>
//대댓글
document.querySelectorAll(".btn-reply").forEach((button) => {
button.onclick = (e) => {
	console.log(e.target.value);

	<% if(loginMember == null){ %>
		loginAlert();
	<% } else { %>

	
	const tr = `
	<tr>
		<td colspan="2" style="text-align:left">
			<form
				action="<%=request.getContextPath()%>/ootd/ootdCommentEnroll" method="post" name="boardCommentFrm">
                <input type="hidden" name="boardNo" value="<%= ootdboard.getOotdNo() %>" />
	            <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" /> 
                <input type="hidden" name="commentLevel" value="2" />
                <input type="hidden" name="commentRef" value="\${e.target.value}" />    
				<textarea id="cmtcmtcontent"  name="content" cols="58" rows="1"></textarea>
                <button type="submit" class="btn-comment-enroll2">등록</button>
            </form>
      	</td>
    </tr>
	`;
	
	const target = e.target.parentElement.parentElement; // tr
	//e.target찾기 
	console.log( e.target );
	// tr 타겟찾기 콘솔에 한글이랑 같이치면절대안나옴 ^^
	console.log( target);
	target.insertAdjacentHTML('afterend', tr);
	
	button.onclick = null; // 이벤트핸들러 제거

 	<% } %>  
	};
});

//삭제
document.querySelectorAll(".btn-delete").forEach((button) => {
	button.onclick = (e) => {
		if(confirm("해당 댓글을 삭제하시겠습니까?")){
			const frm = document.boardCommentDelFrm;
			frm.no.value = e.target.value;
			frm.submit();
		};
	}; 
});	


</script>
<%--
<% if(canEdit){  %> --%>
<form action="<%=request.getContextPath()%>/ootd/ootdDelete" name = "boardDeleteFrm" method="post">
	<input type="hidden" name="no" value="<%= ootdboard.getOotdNo()%>" />
</form>
<script>
// 게시글 수정 / 삭제 
const deleteBoard = () => { 
	if(confirm("정말 게시글을 삭제하시겠습니까? ")){
	  document.boardDeleteFrm.submit();	
	}	
};

const updateBoard = () => { 
	location.href = "<%=request.getContextPath()%>/ootd/ootdUpdate?no=<%=ootdboard.getOotdNo()%>";
}
</script>
<%--  <% } %> --%>

<script>
/* 좋아요 */
document.querySelector(".heart").addEventListener("click", (e) => {
	<% if(loginMember == null){ %>
		 loginAlert();
	<% } else { %>
		$.ajax({
			url: "<%= request.getContextPath() %>/ootd/OotdLike?no=<%= ootdboard.getOotdNo() %>",
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
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>