<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board2.css" />
<section id="board-container">



	<h2>FAQ 작성</h2>
	<form
		name="faqEnrollFrm"
		action="<%=request.getContextPath() %>/faq/faqEnroll" 
		method="post">
		<table id="tbl-board">
		<tr>
			<th>제 목</th>
			<td><input type="text" name="title" required></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer" readonly/>
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><textarea rows="5" cols="40" name="content"></textarea></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="등록하기" class="submit-button">
			</th>
		</tr>
	</table>
	</form>
</section>
<script>
/**
* faqEnrollFrm 유효성 검사
*/
document.faqEnrollFrm.onsubmit = (e) => {
	const title = e.target.title;
	const content = e.target.content;
	console.log(title, content);
	
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test(title.value)){
		alert("제목을 작성해주세요.");
		title.select();
		return false;
	}
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^(.|\n)+$/.test(content.value)){
		alert("내용을 작성해주세요.");
		content.select();
		return false;
	}
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
