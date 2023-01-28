<%@page import="com.sh.obtg.faq.model.dto.faqComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sh.obtg.faq.model.dto.faq"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	faq faq  = (faq) request.getAttribute("faq");
	List<faqComment> comments = (List<faqComment>) request.getAttribute("comments"); 
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board2.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%= faq.getNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= faq.getTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= faq.getWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= faq.getReadCount() %></td>
		</tr>
<%-- 		<% 
			if(!faq.getAttachments().isEmpty()) {
				for(Attachment attach : board.getAttachments()){
		%>
		<tr>
			<th>첨부파일</th>
			<td>
				첨부파일이 있을경우만, 이미지와 함께 original파일명 표시
				<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
				<a href="<%= request.getContextPath() %>/board/fileDownload?no=<%= attach.getNo() %>"><%= attach.getOriginalFilename() %></a>
			</td>
		</tr>
		
		<% 
				}
			} 
		%> --%>
		<tr>
			<th>내 용</th>
			<td><%= faq.getContent()%></td>
		</tr>
		<% 
			boolean canEdit = loginMember != null && 
								(loginMember.getMemberRole() == MemberRole.A ||
									loginMember.getMemberId().equals(faq.getWriter()));
			if(canEdit){
		%>
		<tr>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard()">
				<input type="button" value="삭제하기" onclick="deleteBoard()">
			</th>
		</tr>
		<% 
			}
		%>
	</table>
	
	<hr style="margin-top:30px;" />	
    
	<div class="comment-container">
        <div class="comment-editor">
            <form
			action="<%=request.getContextPath()%>/board/boardCommentEnroll" method="post" name="boardCommentFrm">
                <input type="hidden" name="boardNo" value="<%= faq.getNo() %>" />
                <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
                <input type="hidden" name="commentLevel" value="1" />
                <input type="hidden" name="commentRef" value="0" />    
				<textarea name="content" cols="60" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
        </div>
		<!--table#tbl-comment-->
		<%
			if(!comments.isEmpty()){
		%>
		
		<table id="tbl-comment">
		<%
				for(faqComment fc : comments){
					boolean canRemove = 
							loginMember != null && 
							(
							  loginMember.getMemberId().equals(fc.getWriter())
							  || loginMember.getMemberRole() == MemberRole.A 
							);

					if(fc.getCommentLevel() == 1){
		%>
			
			<%-- 댓글인 경우 tr.level1 --%>
			<tr class="level1">
				<td>
					<sub class=comment-writer><%= fc.getWriter() %></sub>
					<sub class=comment-date><%= fc.getRegDate() %></sub>
					<br />
					<%-- 댓글내용 --%>
					<%= fc.getContent() %>
				</td>
				<td>
					<button class="btn-reply" value="<%= fc.getNo() %>">답글</button>
					<% if(canRemove){ %>
					<button class="btn-delete" value="<%= fc.getNo() %>">삭제</button>
					<% } %>

				</td>
			</tr>
		<%
					} else {
		%>
			<%-- 대댓글인 경우 tr.level2 --%>
			<tr class="level2">
				<td>
					<sub class=comment-writer><%= fc.getWriter() %></sub>
					<sub class=comment-date><%= fc.getRegDate() %></sub>
				<br />
					<%-- 대댓글 내용 --%>
					<%= fc.getContent() %>
				</td>
				<td>
					<% if(canRemove){ %>
					<button class="btn-delete" value="<%= fc.getNo() %>">삭제</button>
					<% } %>

				</td>
			</tr>
		<%
					} // if...else
				} // for
		%>
		</table>
		
		<%
			}
		%>
	</div>
	
	
</section>
<form 
	action="<%= request.getContextPath() %>/faq/faqCommentDelete" 
	name="faqCommentDelFrm"
	method="POST">
	<input type="hidden" name="no" />
	<input type="hidden" name="boardNo" value="<%= faq.getNo() %>"/>
</form>

   <script>
document.querySelectorAll(".btn-delete").forEach((button) => {
	button.onclick = (e) => {
		if(confirm("해당 댓글을 삭제하시겠습니까?")){
			const frm = document.faqCommentDelFrm;
			frm.no.value = e.target.value;
			frm.submit();
		}
	}; 
});	
</script>

<script>
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
						action="<%=request.getContextPath()%>/faq/faqCommentEnroll" method="post" name="faqCommentFrm">
		                <input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
		                <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
		                <input type="hidden" name="commentLevel" value="2" />
		                <input type="hidden" name="commentRef" value="\${e.target.value}" />    
						<textarea name="content" cols="58" rows="1"></textarea>
		                <button type="submit" class="btn-comment-enroll2">등록</button>
		            </form>
		      	</td>
		    </tr>
			`;
			
			const target = e.target.parentElement.parentElement; // tr
			console.log(target);
			target.insertAdjacentHTML('afterend', tr);
			
			button.onclick = null; // 이벤트핸들러 제거
		
		<% } %>
	};
});


/**
 * 이벤트버블링을 통해 부모요소에서 이벤트 핸들링
 */
document.body.addEventListener('submit', (e) => {
	console.log(e.target);
	
	if(e.target.name === 'faqCommentFrm'){
		
		<% if(loginMember == null){ %>
			loginAlert();
			e.preventDefault();
			return; // 조기리턴
		<% } %>
				
		// 유효성검사
		const content = e.target.content;
		if(!/^(.|\n)+$/.test(content.value)){
			e.preventDefault();
			alert('내용을 작성해주세요');
			content.focus();
		}
	}
	
	
});

// textarea
document.faqCommentFrm.content.addEventListener('focus', (e) => {
	<% if(loginMember == null){ %>
		loginAlert();
	<% } %>
});

const loginAlert = () => {
	alert("로그인 후 이용할 수 있습니다.");
	document.querySelector("#memberId").focus();
};

</script>

<% if(canEdit){ %>
<form action="<%= request.getContextPath() %>/faq/faqDelete" name="faqDeleteFrm" method="POST">
	<input type="hidden" name="no" value="<%= faq.getNo() %>" />
</form>
<script>
const updateBoard = () => {
	location.href = "<%= request.getContextPath() %>/faq/faqUpdate?no=<%= faq.getNo() %>";
};
const deleteBoard = () => {
	if(confirm("정말 게시글을 삭제하겠습니까?")){
		document.faqDeleteFrm.submit();
	}
};
</script>
<% } %>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
