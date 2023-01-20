<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/columnList.css" />
  
	<section class="col_container">
   
		<!-- for문으로 각각의 컬럼들을 꺼내오자! -->
		<div class="columns">
        	<div class="col_wrap">
          		<a href="<%= request.getContextPath() %>/column/columnView">
	          		<img src="<%= request.getContextPath() %>/image/test.png" alt="">
	          		<div class="col_txt">
	            		<h2>제목이 들어갈 자리입니다.</h2>
	            		<p>내용 일부가 들어갈 자리입니다.어쩌고저쩌고
	            		어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고
	            		</p>
	          		</div> <!-- end col_txt -->
	          	</a>
        	</div> <!-- end col_wrap -->
      	</div> <!-- end col_columns -->
		<div class="columns">
        	<div class="col_wrap">
          		<a href="">
	          		<img src="<%= request.getContextPath() %>/image/test.png" alt="">
	          		<div class="col_txt">
	            		<h2>제목이 들어갈 자리입니다.</h2>
	            		<p>내용 일부가 들어갈 자리입니다.어쩌고저쩌고
	            		어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고어쩌고저쩌고
	            		</p>
	          		</div> <!-- end col_txt -->
	          	</a>
        	</div> <!-- end col_wrap -->
      	</div> <!-- end col_columns -->
      
      <!-- 이부분은 나중에 관리자만 보일수 있도록 처리하자! -->
		<img src="<%= request.getContextPath() %>/image/quill-pen.png" alt="" class="pen" />
	</section>

<script>
document.querySelector(".pen").addEventListener("click", (e) => {
	location = "<%= request.getContextPath() %>/column/columnEnroll";
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>