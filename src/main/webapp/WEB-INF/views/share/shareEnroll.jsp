<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 글꼴  -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shareEnroll.css" />
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
<%-- <%
	Member loginMember=(Member) session.getAttribute("loginMember");
    String msg = (String) session.getAttribute("msg");  
%>
 --%>
<br />

<section id="board-container">
	<h2 id="sharewrite"> SHARE 게시글 작성</h2>
	<form
		name="shareBoardEnrollFrm"
		action="<%=request.getContextPath()%>/share/shareEnroll" 
		enctype ="multipart/form-data"
		method="post">
		<table id="tbl-board-view">
		
		<tr >
			<th style ="padding-top:20px; font-size : 24px">제 목</th>
			<td style ="padding-top:20px" >
				<input style="width : 550px" class="inputtext" type="text" name="ShareTitle" placeholder="제목을 입력해주세요." required>
				<input class="satustext" type="text" name="ShareState" value="거래전" readonly />	
			</td>
		</tr>
		
		<tr>
			<th>아이디</th>
			<td>
				<input type="text"  class="inputtext" name="memberId" value="<%=loginMember.getMemberId() %>" readonly required/>
			</td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td><select name="ShareCategory" >
			    <option name="ShareCategory"  value="상의" > 상의 </option>
			    <option name="ShareCategory"  value="하의" > 하의 </option>
			    <option name="ShareCategory" value="악세서리" > 악세서리 및 기타 </option>
			</select></td>
		</tr>
		<tr>
			<th>구매시기</th>
			<td>
				<input type="date"  class="inputdate" name="ShareBuyDate" value="2000-08-08" required/>
				<span style="font-size : 12px; color : red;">&nbsp;&nbsp; ※ 대략적인 날짜를 기재하셔도 좋습니다 😊 </span>
			</td>
		</tr>
		<tr>
			<th>상품상태</th>
			<td>
				<input type="checkbox" name="ShareProductStatus" id="P1" value="상" onclick='checkOnlyOneTwo(this)' ><label for="P1"> 상 &nbsp;</label>		
				<input type="checkbox" name="ShareProductStatus" id="P2" value="중" onclick='checkOnlyOneTwo(this)' ><label for="P2"> 중 &nbsp;</label>		
				<input type="checkbox" name="ShareProductStatus" id="P3" value="하" onclick='checkOnlyOneTwo(this)' ><label for="P3"> 하 &nbsp;</label>
			</td>
		<tr>
			<th>스타일</th>
			<td>
				<input type="checkbox" name="style" id="S1" value="러블리" onclick='checkOnlyOne(this)'  ><label for="S1">러블리 &nbsp;</label>		
				<input type="checkbox" name="style" id="S2" value="댄디" onclick='checkOnlyOne(this)'  ><label for="S2">댄디 &nbsp;</label>		
				<input type="checkbox" name="style" id="S3" value="포멀" onclick='checkOnlyOne(this)'  ><label for="S3">포멀 &nbsp;</label>		
				<input type="checkbox" name="style" id="S4" value="스트릿" onclick='checkOnlyOne(this)'  ><label for="S4">스트릿 &nbsp;</label>		
				<input type="checkbox" name="style" id="S5" value="걸리쉬" onclick='checkOnlyOne(this)'  ><label for="S5">걸리쉬 &nbsp;</label>		
				<input type="checkbox" name="style" id="S6" value="레트로" onclick='checkOnlyOne(this)'  ><label for="S6">레트로 &nbsp;</label>	
				<input type="checkbox" name="style" id="S7" value="로맨틱" onclick='checkOnlyOne(this)'  ><label for="S7">로맨틱 &nbsp;</label>	
				<input type="checkbox" name="style" id="S8" value="시크" onclick='checkOnlyOne(this)'  ><label for="S8">시크&nbsp;</label>	
				<input type="checkbox" name="style" id="S9" value="아메카지" onclick='checkOnlyOne(this)' ><label for="S9">아메카지</label>	
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>			
				<input type="file" name="upFile1"  id="upFile1" accept="image/*"  required>
			</td>
		</tr>
		<tr>
			<th>미리보기</th>
			<td style="width:100px; height:100px; ">
				<div id="col_img">
					<img id="col_img_viewer" style="width : 100px">
				</div>
			</td>
		</tr>
		<tr>
			<th  colspan="2" >
			<div class="summernotecontainer">
			  <textarea colspan="2" id="summernote"  class="summernote" name ="editordata"></textarea>
			</div>
			</th>
		</tr>
		<tr>
			<th colspan="2">
				<input style="margin-left : 120px"  class ="inputbuttons"  type="submit" value="SUBMIT">
				<input class ="inputbuttons"  type="button" value="CANCEL" onclick="history.go(-1);"/>
			</th>
		</tr>
	</table>
	</form>
</section>
<br />
<br />
<br />

<script>
/* 첨부파일 이미지 미리보기 */
document.querySelector("#upFile1").addEventListener('change', (e) => {
	const img = e.target;
	
	if(img.files[0]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[0]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer").src = e.target.result; 
		};
	}
	else {
		// 파일 선택 취소한 경우
		document.querySelector("#col_img_viewer").src = "";
	}
});
</script>

<script>
// 체크박스들 하나만 선택되게 하기 
function checkOnlyOne(element) {
	  
	  const checkstyleboxes = document.getElementsByName("style");
	  
	  checkstyleboxes.forEach((cb) => {
	    cb.checked = false;
	  })
	  
	  element.checked = true;
}


function checkOnlyOneTwo(element) {
	  
	  const checkboxes 
	      = document.getElementsByName("ShareProductStatus");
	  
	  checkboxes.forEach((cb) => {
	    cb.checked = false;
	  })
	  
	  element.checked = true;
}

function checkOnlyOneTwoThree(element) {
	  
  const checkboxes = document.getElementsByName("ShareCategory");
  
  checkboxes.forEach((cb) => {
    cb.checked = false;
  })
  
  element.checked = true;
}
</script>

<script>	
	$(document).ready(function() {

		var toolbar = [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['clear', 'bold', 'italic', 'underline','strikethrough']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			 //   ['insert',['picture','link','video']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview','fullscreen', 'help']]
			  ];

		var setting = {
	            height : 300,
	            width : 760,
	            minHeight : null,
	            maxHeight : null,
	            focus : true,
	            lang : 'ko-KR',
	            fontSize : 16,
	            fontWeight : 'normal',
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
</script>


<script>
/**
* shareBoardEnrollFrm 유효성 검사
*/
document.shareBoardEnrollFrm.onsubmit = (e) => {
	const title = e.target.ShareTitle;
	const content = e.target.editordata;
	const upload = e.target.upFile1;
	
	console.log(title, content);
	
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test(title.value)){
		alert("제목을 작성해주세요");
		title.select();
		return false;
	}
						   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.|\n+$/.test(content.value)){ // \n은 따로 추가해줘야됨 (왜냐면 .애는 개행이 포함안되서 ) 
		alert("내용을 작성해주세요");
		content.select();
		return false;
	}
	
	if( !upload ){ // \n은 따로 추가해줘야됨 (왜냐면 .애는 개행이 포함안되서 ) 
		alert("사진을 첨부해주세요");
		upload.select();
		return false;
	}
}
</script>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>