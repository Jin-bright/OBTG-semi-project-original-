<%@page import="com.sh.obtg.ootd.model.dto.OotdBoard"%>
<%@page import="com.sh.obtg.ootd.model.dto.OotdAttachment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdWholeList.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&family=Noto+Sans+KR:wght@900&display=swap" rel="stylesheet"><link rel="stylesheet" href="<%=request.getContextPath()%>/css/ootdEnroll.css" />
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> --%>

<%
//String msg = (String)session.getAttribute("msg");
//int totalPage = (int)request.getAttribute("totalPage");

//if( msg != null )
//	session.removeAttribute("msg");
// 리스트 가져오는거 필요함 
 List<OotdAttachment> ootdAttachments = (List<OotdAttachment>)request.getAttribute("ootdAttachments");
 OotdBoard ootdboard = (OotdBoard) request.getAttribute("ootdboard");
%>
<br /><br /><br />
<section id="board-container">
<h2 id = "ootdboardlist" > Outfit Of The Day </h2>
<h3 id="ootdboardlist2"> 오늘 입은 옷을 공유해보세요! </h3>
<br /><br /><br /><br />
<%----  검색상자  --%>
<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="스타일을 검색해보세요  ex)스트릿  ">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>


<% if(loginMember != null){ %>
<input type="button" value="글쓰기" id="btnAdd" 
	onclick="location.href='<%=request.getContextPath()%>/ootd/ootdEnroll';"/> <%-- get&post다있는데/ 로그인한 상태에서만 노출 되게 수정해야됨 --%> 
<% } %>
<table id="tblBoard">
  <tr> 
  <% for(int i=0; i<ootdAttachments.size(); i++){ %>
<%--   	<% if(i%5==0){%>
  		<tr>
  	<%} %>
  	<td class="maketd" style= "height : 300px; width:190px; padding:10px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
       <img  style="display : inline-block; height : 300px; width:190px" src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>"/></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getBoardNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
     </td>
     <% if(i%5==4){%>
  		</tr>
  	 <% } %> --%>
  
	<% if(i<5) { %>
     <td class="maketd" style= "height : 300px; width:190px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
       <img  id="eachimg" style="display : inline-block;" src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>"/></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getBoardNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
     </td>
	<% } else if(i == 5){ %> 
    </tr>
     <td class="maketd" style= "height : 300px; width:190px;">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
     <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
     </td>  
	<% } else if(i<9){%> 
     <td class="maketd" style= "height : 300px; width:190px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
     <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
    </td>	
	<% } else if(i==9){ %>
    <td class="maketd" style= "height : 300px; width:190px;">
    <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
    <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>	
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
 	</td>
	<% } else if(i==10){ %>
   <tr>
   <td class="maketd" style= "height : 300px; width:190px;">
    <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
    <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>	
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
 	</td>
	<% } else if(i<14){%> 
     <td class="maketd" style= "height : 300px; width:190px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
     <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
    </td>
 	<% } else if(i==14){%> 
     <td class="maketd" style= "height : 300px; width:190px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/ootd/ootdView?no=<%=ootdAttachments.get(i).getBoardNo() %>">
     <img src="<%=request.getContextPath()%>/uploadootds/ootd/<%=ootdAttachments.get(i).getRenamedFilename()%>" ></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=ootdAttachments.get(i).getAttachNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=ootdAttachments.get(i).getRegDate()%></span></p>
    </td>
    </tr>
	<% } %> 
<% } %>

</table>

</section>

<div id='pagebar' style = "background-color: orange" > <%=request.getAttribute("pagebar")%>
</div>

<script>
const atag = document.querySelectorAll(".atags");
const div  = document.querySelectorAll("td");


// Q.태그 하나하나에 어떻게 하지 ?
/* $('a').on('mouseenter', function(){
	$(div).css("background-color","gray");
})

atag.forEach( (a, index) => {
	a.addEventListener('mouseover', (e) => {
		div.forEach( (d, index) => {
			d.style.backgroundColor = "yellow";	
		})
		
	});		
}) */

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>