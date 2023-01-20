<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdList.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<section id="board-container2">
	<h2 id = "ootdboardlist">게시판 </h2>
<input type="button" value="글쓰기" id="btn-add" style="margin-right : 450px"
	onclick="location.href='<%=request.getContextPath()%>/ootd/ootdEnroll';"/> <%-- get&post다있는데/ 로그인한 상태에서만 노출 되게 수정해야됨 --%> 
	<br />	<br />	<br />

<div class="containerForRows">
  <div class="row row-cols-4">
	<%-- 4열  --%>
	<div class="colFour">
	    <div class="cardsForootd" style="width: 18rem;">
			<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
			    <h5 class="card-title">Card title</h5>
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  <!--   <a href="#" class="btn btn-primary">Go somewhere</a>  -->
			</div>
		</div>
    </div>
    
    <div class="colFour">
	    <div class="cardsForootd" style="width: 18rem;">
			<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
			    <h5 class="card-title">Card title</h5>
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  <!--   <a href="#" class="btn btn-primary">Go somewhere</a>  -->
			</div>
		</div>
    </div>
    
    <div class="colFour">
	    <div class="cardsForootd" style="width: 18rem;">
			<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
			    <h5 class="card-title">Card title</h5>
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  <!--   <a href="#" class="btn btn-primary">Go somewhere</a>  -->
			</div>
		</div>
    </div>
    
    <div class="col">
	    <div class="card" style="width: 18rem;">
			<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
			    <h5 class="card-title">Card title</h5>
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  <!--   <a href="#" class="btn btn-primary">Go somewhere</a>  -->
			</div>
		</div>
    </div>
    
    
  </div>
</div>



	<div id='pagebar'></div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>