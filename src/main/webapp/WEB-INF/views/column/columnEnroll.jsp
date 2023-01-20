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
                    <th style="text-align: center;">제목</th>
                    <td><input type="text" class="col" placeholder="제목을 입력해주세요." required></td>
                </tr>
                <tr>
                    <th style="text-align: center;">작성자</th>
                    <td><input type="text" class="col" name="col_writer" value="망고" readonly></td>
                </tr>
				<tr>
					<th style="text-align: center;">내용</th>
	                <!-- <textarea class="col_content" name="col_content" cols="70" rows="20" style="resize: none;" placeholder="내용을 입력해주세요." required></textarea> -->
	                <td  colspan="2" >
	           			<div class="container">
	               			<textarea colspan="2" id="summernote"  class="summernote" name ="col_content" cols="70" rows="10" style="resize: none;" placeholder="내용을 입력해주세요." required></textarea>    
	            		</div>
	                	<p style="text-align: right;"><span id="counter">0</span>/2000</p>	
            		</td>
	            </tr>
	            <tr>
	                <th style="text-align: center;">첨부파일</th>
	                <td><input type="file" name="col_file" required;></td>
	            </tr>
			</tbody>
	        <tfoot>
				<th colspan="2" style="text-align: center;">
					<input type="submit" value="저장" id="btn">
	                <input type="button" value="취소" id="btn">
	            </th>
			</tfoot>
		</table>
	</form>
</section>

<script>
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
		minHeight : null,
		maxHeight : null,
		focus : true,
		lang : 'ko-KR',
		toolbar : toolbar,
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

/* 글자수 제어 */
document.columnFrm.addEventListener("submit", (e) => {
	const content = document.querySelector("[name=col_content]");
	if(content.value.length >= 2000){
		e.preventDefault();
		alert("내용에 2000글자 이내로 입력해주세요.");
		return;
	}
});

document.querySelector("[name=col_content]").addEventListener("keyup", (e) => {
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