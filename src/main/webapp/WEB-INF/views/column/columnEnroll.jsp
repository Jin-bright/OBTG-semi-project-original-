<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/columnEnroll.css" />

<section id="col_enroll">
	<h2 style="text-align: center; padding: 20px">컬럼 작성폼</h2>
	<form 
		name="columnFrm"
		action="<%= request.getContextPath() %>/column/columnEnroll" 
		enctype="multipart/form-data"
		method="post"		
	>
		<table>
			<tbody>
				<tr>
                    <th>제목</th>
                    <td><input type="text" class="col" placeholder="제목을 입력해주세요." required></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><input type="text" class="col" name="col_writer" value="망고" readonly></td>
                </tr>
				<tr>
					<th>내용</th>
	                <td>
	                	<textarea class="col_content" name="col_content" cols="70" rows="20" style="resize: none;" placeholder="내용을 입력해주세요." required></textarea>
	                	<p style="text-align: right;"><span id="counter">0</span>/2000</p>	
	                </td>
	            </tr>
	            <tr>
	                <th>첨부파일</th>
	                <td><input type="file" name="col_file"></td>
	            </tr>
			</tbody>
	        <tfoot>
				<th colspan="2">
					<input type="submit" value="저장">
	                <input type="button" value="취소">
	            </th>
			</tfoot>
		</table>
	</form>
</section>

<script>

/* 글자수 제어 */
document.columnFrm.addEventListener("submit", (e) => {
	const content = document.querySelector(".col_content");
	if(content.value.length >= 2000){
		e.preventDefault();
		alert("내용에 2000글자 이내로 입력해주세요.");
		return;
	}
});

document.querySelector(".col_content").addEventListener("keyup", (e) => {
	const len = e.target.value.length;
	const counter = document.querySelector("#counter");
	
	counter.innerHTML = len;
	if(len >= 2000){
		counter.innerText = len;
		counter.classList.add('red');
	}
	else {
		counter.innerText = len;
		counter.classList.remove('red');
	}
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>