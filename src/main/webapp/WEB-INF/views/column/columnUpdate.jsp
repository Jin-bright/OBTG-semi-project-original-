<%@page import="com.sh.obtg.column.model.dto.Column"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/columnEnroll.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="<%=request.getContextPath()%>/summernote/summernote-lite.js"></script>
<script src="<%=request.getContextPath()%>/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/summernote/summernote-lite.css">
<%
	Column column = (Column)request.getAttribute("column");
%>
<section id="col_update">
	<h2 style="text-align: center; padding: 20px; font-weight: bold">컬럼 수정폼</h2>
	<form 
		name="columnUpdateFrm"
		action="<%= request.getContextPath() %>/column/columnUpdate?no=<%= column.getNo() %>" 
		enctype="multipart/form-data"
		method="post"		
	>
		<table>
			<tbody>
				<tr>
                    <th style="text-align: center;">제목</th>
                    <td style="padding: .7em;">
                    	<input type="text" class="col_txt" name="col_title" value="<%= column.getTitle() %>" required>
                    </td>
                </tr>
				<tr>
                    <th style="text-align: center;">소제목</th>
                    <td style="padding: .7em;">
                    	<input type="text" class="col_txt" name="col_subtitle" value="<%= column.getSubtitle() %>" required>
                    </td>
                </tr>
                <tr>
                    <th style="text-align: center;">작성자</th>
                    <td style="padding: .7em;"><input type="text" class="col_txt" name="col_writer" value="<%= column.getWriter() %>" readonly></td>
                </tr>
                <tr>
	                <th style="text-align: center;">첨부파일</th>
	                <td style="padding: .7em;">
	                	<span id="current_img_name"><%= column.getOriginalFilename() %></span><input type="button" value="삭제" id="delBtn" style="margin-left: 6px; background: darkgrey; color: white; padding: 1px 5px;" onclick="delImg()"/> 
	                	<input type="file" id="col_file" name="col_file" accept="image/*" style="display: none;" value="">
	                </td>
	            </tr>
	            <tr>
					<th>미리보기</th>
					<td style="padding: .7em 8.8em;">
						<div id="col_img">
							<img src="<%= request.getContextPath() %>/upload/column/<%= column.getRenamedFilename() %>" id="col_img_viewer" width="350px">
						</div>
					</td>
				</tr>
				<tr>
					<th style="text-align: center;">내용</th>
	                <td  colspan="2" style="padding: .7em;">
	           			<div class="container">
	               			<textarea id="summernote"  class="summernote" name ="col_content" cols="70" rows="10" style="resize: none;" required><%= column.getContent() %></textarea>    
	            		</div>
	                	<p style="text-align: right;"><span id="counter">0</span>/2000</p>	
            		</td>
	            </tr>
			</tbody>
	        <tfoot>
				<td colspan="2" style="text-align: center; padding: .7em;">
					<input type="submit" value="저장" id="btn">
	                <input type="button" value="취소" id="btn" onclick="history.go(-1);">
	            </td>
			</tfoot>
		</table>
	</form>
</section>
<script>
/* 현재 이미지 삭제 */
const delImg = () => {
	const img = document.querySelector("#col_img_viewer");
	const imgName = document.querySelector("#current_img_name");
	const delBtn = document.querySelector("#delBtn");
	const addFile = document.querySelector("#col_file");
	
	if(confirm("정말 해당 사진을 삭제하겠습니까?")){
		img.src = "";
		imgName.style.display = "none";
		delBtn.style.display = "none";
		addFile.style.display = "unset";
	};
};

/* 첨부파일 이미지 미리보기 */
document.querySelector("#col_file").addEventListener('change', (e) => {
	const img = e.target;
	
	if(img.files[0]){
		// 파일 선택한 경우
		const fr = new FileReader(); // html5 api
		fr.readAsDataURL(img.files[0]); // 비동기처리 - 언제끝날지 몰라 백그라운드에서 작업함
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer").src = e.target.result; // result속성은 dataUrl임
		};
	}
	else {
		// 파일 선택 취소한 경우
		document.querySelector("#col_img_viewer").src = "";
	}
});

/* 유효성검사 - 글자수제어하기 성공하면 같이 넣어 놓자,,, */
document.columnUpdateFrm.addEventListener('submit', (e) => {
	const title = e.target.col_title; // name 값을 입력해줘야하나보다
	const content = $('#summernote').summernote('code');  // 이거 어케 지정하는거지..?
	const img = document.querySelector("#col_img_viewer");
	
	// 제목을 작성하지 않은 경우 폼제출 불가
	if(!/^.+$/.test(title.value)){
		alert("제목을 작성해주세요."); /* 이거 왜 안나옴...? */
		title.focus();
		return false;
	}
	
	// 내용을 작성하지 않은 경우 폼제출 불가
	if(!/^(.|\n)+$/.test(content.value)){
		alert("내용을 작성해주세요.");
		return false;
	}
	
	// 이미지를 등록하지 않은 경우 폼제출 불가 - 이것도 왜 안되는데,,,,
	if(img.src = ""){
		alert("이미지를 등록해주세요.");
		return false;
	}
	
	if(content.value.length >= 2000){
		alert("내용에 2000글자 이내로 입력해주세요.");
		return false;
	}
});


/* 써머노트 */
$(document).ready(function() {
	var toolbar = [
		// 글꼴 설정
		['fontname', ['fontname']],
		// 글자 크기 설정
		['fontsize', ['fontsize']],
		// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		// 글자색
		['color', ['forecolor','color']],
		// 표만들기
		['table', ['table']],
		// 글머리 기호, 번호매기기, 문단정렬
		['para', ['ul', 'ol', 'paragraph']],
		// 줄간격
		['height', ['height']],
		// 그림첨부, 링크만들기, 동영상첨부
		['insert',['picture','link','video']],
		// 코드보기, 확대해서보기, 도움말
		['view', ['codeview','fullscreen', 'help']]
	];

	var setting = {
		width : 600,
		height : 300,
		lang : 'ko-KR',
		toolbar : toolbar,
		placeholder : "내용을 입력해주세요.",
		callbacks : { //여기 부분이 이미지를 첨부하는 부분
			onImageUpload : function(files, editor,
			welEditable) {
				for (var i = files.length - 1; i >= 0; i--) {
					uploadSummernoteImageFile(files[i],
					this);
				}
			}
		}
	};

	$('#summernote').summernote(setting);
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>