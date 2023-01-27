<%@page import="com.sh.obtg.share.model.dto.ShareBoard"%>
<%@page import="com.sh.obtg.share.model.dto.ShareBoardEntity"%>
<%@page import="com.sh.obtg.share.model.dto.ShareAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shareWholeList.css" />
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<%
	List<ShareAttachment> shareAttachments = (List<ShareAttachment>)request.getAttribute("shareAttachments");
	List<ShareBoard> shareboards = (List<ShareBoard> )request.getAttribute("shareboards");
%>
<br /><br /><br />
<section id="board-container">
<h2 id = "shareboardlist" > SHARE  </h2>
<h3 id="shareboardlist2"> 더이상 입지 않는 아이템을 다른 회원들에게 무료로 양도해보세요 </h3>

<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="스타일을 검색해보세요  ex)스트릿  ">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>



<input type="button" value="글쓰기" id="btnAdd" 
	onclick="location.href='<%=request.getContextPath()%>/share/shareEnroll';"/> <%-- get&post다있는데/ 로그인한 상태에서만 노출 되게 수정해야됨 --%> 


<table id="tblBoard" >
  <% for(int i=0; i<shareAttachments.size(); i++){
   	 if(i%2==0){%>
	<tr >
	<%} %>
  	<td class="maketd" >
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=<%=shareAttachments.get(i).getBoardNo() %>">
       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px; margin-left:-170px" src="<%=request.getContextPath()%>/uploadshares/share/<%=shareAttachments.get(i).getRenamedFilename()%>"/></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=shareAttachments.get(i).getBoardNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=shareAttachments.get(i).getRegDate()%></span></p>
	</td>
	<td class ="detailtd" >
		<img class="carrots"src="<%=request.getContextPath()%>/uploadshares/carrot.png" alt="carrot" style=" width:16px; height:16px" />
		<p id="deal"><%=shareboards.get(i).getShareState()%></p>			
		<div id="detaildiv">
		<span class="datailtitle"  ><b>제목 </b></span>    <span class="boarddetails"><%= shareboards.get(i).getShareTitle()%></span><br/><br/>
		<span class="datailtitle" ><b>카테고리 </b></span>  <span class="boarddetails"><%= shareboards.get(i).getShareCategory()%></span><br/><br/>
		<span class="datailtitle"  ><b>구매시기 </b></span> <span class="boarddetails"><%= shareboards.get(i).getShareBuyDate()%></span><br/><br/>
		<span class="datailtitle"  ><b>상품상태 </b></span> <span class="boarddetails"><%= shareboards.get(i).getShareProductStatus()%></span><br />
		</div>
	</td>
	<td style="width:100px"></td>
	
     <% if(i%2==1){%>
  		</tr>
  	 <% }   	    
  	 }%> 
  	
</table>
</section>

<div id='pagebar' style = "background-color: orange" > <%=request.getAttribute("pagebar")%></div>
<script>

//const img  = document.querySelectorAll("#eachimg");
function styleback{
	const img  = document.querySelectorAll(".maketd");
	
	img.forEach( (i, index) => {
		i.addEventListener('mouseenter', (e) => {
			i.style.backgroundColor = "#db0d36";	
		})
	});
}

window.onload{
	styleback();
}

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
