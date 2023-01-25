<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	int totalPage = (int)request.getAttribute("totalPage");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/columnList.css" />
  
	<!-- 이부분은 나중에 관리자만 보일수 있도록 처리하자! -->
	<img src="<%= request.getContextPath() %>/image/quill-pen.png" alt="" class="pen" />
	<section id="col_container">
	</section>
    <div id='btn-more-container' style="text-align:center; margin-bottom: 1em;">
		<button id="btn-more" value="" >LOAD MORE POSTS(<span id="page"></span>/<span id="totalpage"><%= totalPage %></span>)</button>
	</div>

<script>
window.addEventListener('load', () => {
	// 첫페이지 내용 로드
	getPage(1);
});

document.querySelector("#btn-more").addEventListener('click', () =>{
	const page = document.querySelector("#page");
	
	getPage(Number(page.innerText) + 1); // Number("1") + 1 -> "2"
});

const getPage = (page) => {
	$.ajax({
		url : "<%= request.getContextPath() %>/column/morePage",
		data : {page},
		dataType : "json",		
		success(data){
			console.log(data);
			
			const container = document.querySelector("#col_container");
			
			data.forEach((column, index) => {
				
				const div1 = document.createElement("div");
				div1.classList.add('columns');
				
				const div2 = document.createElement("div");
				div2.classList.add('col_wrap');
				
				const a = document.createElement("a");
				a.href = "<%= request.getContextPath() %>/column/columnView?no=" + column.no;
				
				const img = document.createElement("img");
				img.src = "<%= request.getContextPath() %>/upload/column/" + column.renamedFilename;
				
				const hr = document.createElement("hr");
				hr.style.width = "100px";
				
				const div3 = document.createElement("div");
				div3.classList.add('col_txt');
				
				const h2 = document.createElement("h2");
				h2.append(column.title);
				h2.style.fontSize = "2.3em";
				h2.style.fontFamily = 'swipercons';
				
				const p1 = document.createElement("p");
				p1.append(column.subtitle);
				p1.style.fontFamily = 'swipercons';
				p1.style.fontSize = "1.2em";
				p1.style.paddingTop = ".5em";
				
				
				div3.append(h2, p1);
				a.append(img, div3);
				div2.append(a);
				div1.append(div2);
				
				container.append(div1); // DOM Tree 추가
				
			});
			
		}, // success
		error : console.log,
		// 마지막에 무조건 실행되는 코드!
		complete(){
			document.querySelector("#page").innerHTML = page;
			
			// 마지막페이지인 경우 더보기버튼 비활성화처리
			if(page === <%= totalPage %>){
				const button = document.querySelector("#btn-more");
				button.disabled = true; // 버튼 비활성화
				button.style.cursor = "not-allowed"; // 안된다는 커서 이미지
			}
		}
	});
};

document.querySelector(".pen").addEventListener("click", (e) => {
	location = "<%= request.getContextPath() %>/column/columnEnroll";
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>