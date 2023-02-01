<%@ page import="com.sh.obtg.member.model.dto.Member" %>
<%@ page import="com.sh.obtg.member.model.dto.MemberRole" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Member loginMember=(Member) session.getAttribute("loginMember");
	String msg = (String)session.getAttribute("msg");
	System.out.println(msg);
	if(msg != null) session.removeAttribute("msg");
%>
<!doctype html>

<head>
<meta charset="UTF-8" />

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>OBTG Semi-Project</title>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" /> 
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">
<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/index.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.6.1.js"></script>
<% if(loginMember != null){ %>
<script src="<%= request.getContextPath() %>/js/ws.js"></script>
<% } %>
</head>
<body>
<header style="hight:263.67px;">
<!--   메뉴바 -->
<br /> <br />
<table id="tdloginSignup">
<% if(loginMember == null) { %>
 <tr>
 	<td><button id="loginSignup" value="로그인/회원가입" onclick="location.href = '<%= request.getContextPath() %>/member/memberEnroll';">LOGIN / SIGN UP</button></td>
 </tr>	
 
</table>
<% } else { %>

				 <table id="login" style="margin-left:50%; text-align:right;">
					<tr>
						<td>
						<nav id="colorNav">
    						<ul>
       						 <li class="green">
            					<a href="#" class="fa fa-windows"><img id="defaultimg" src="<%=request.getContextPath()%>/image/default.png" alt="defaultimg" style="width:30px; height:30px;"/></a>
 							<% if(loginMember.getMemberRole() == MemberRole.A) { %>
            						<ul>
						                <li><a href="<%= request.getContextPath() %>/admin/memberList;">관리자페이지</a></li>
						                <li><a href="<%= request.getContextPath() %>/member/logout;">로그아웃</a></li>
							            </ul>
							        </li>
							    </ul>
							</nav>
 							 <%--<ul class="dd-menu">
	      						<li><a href="<%= request.getContextPath() %>/admin/memberList;">관리자페이지</a></li>
	      						<li><a href="<%= request.getContextPath() %>/member/logout;">로그아웃</a></li>
	    					</ul>--%>
 							<% } else{ %>
							<ul class="dd-menu">
	      						<li><a href="<%= request.getContextPath() %>/member/memberView;">My Page</a></li>
	      						<li><a href="<%= request.getContextPath() %>/member/logout;">로그아웃</a></li>
	    					</ul>
							<%} %>
							<%= loginMember.getNickname() %>님
							<i style="position: absolute;"><img src="<%= request.getContextPath() %>/image/notification.png" alt="알림" class="bell bell-hiden" /></i>
							<div id="report_wrap"></div>
						</td>
					</tr>
				<%-- 	<tr>
						 <td>
							<input type="button" value="Logout" style="border: 0px; padding: 5px; background-color: lightpink; cursor: pointer;"onclick="location.href = '<%= request.getContextPath() %>/member/logout';"/>
						</td>
					</tr> --%>
				</table> 
			
			<% } %>
			<a href="<%=request.getContextPath()%>" >
				<h1  class="main-title"  style="margin : 0 auto ">O B T G</h1>
			</a>
<br /> <br />
<hr style="border: solid 1px black; margin:0;">
<nav class="menu">
	<a class="menu__item" id="i-0" href="<%=request.getContextPath()%>/index.jsp"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGZp%0D%0AbGw9IiNmZmZmZmYiIGlkPSJzdmdfMSIgZD0ibTIwLDQwbDAsLTEybDgsMGwwLDEybDEwLDBsMCwt%0D%0AMTZsNiwwbC0yMCwtMThsLTIwLDE4bDYsMGwwLDE2bDEwLDB6Ii8+CiA8L2c+Cjwvc3ZnPg=="/><span class="menu__text">HOME</span></a>	
	<a class="menu__item" id="i-1" href="<%=request.getContextPath()%>/ootd/ootdWholeList"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGZp%0D%0AbGw9IiNmZmZmZmYiIGlkPSJzdmdfMSIgZD0ibTI0LDhjLTQuNDIsMCAtOCwzLjU4IC04LDhjMCw0%0D%0ALjQxIDMuNTgsOCA4LDhzOCwtMy41OSA4LC04YzAsLTQuNDIgLTMuNTgsLTggLTgsLTh6bTAsMjBj%0D%0ALTUuMzMsMCAtMTYsMi42NyAtMTYsOGwwLDRsMzIsMGwwLC00YzAsLTUuMzMgLTEwLjY3LC04IC0x%0D%0ANiwtOHoiLz4KIDwvZz4KPC9zdmc+"/><span class="menu__text">OOTD</span></a>
	<a class="menu__item" id="i-2" href="<%=request.getContextPath()%>/share/shareWholeList"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGlk%0D%0APSJzdmdfMSIgZmlsbD0ibm9uZSIgZD0ibTAsMGw0OCwwbDAsNDhsLTQ4LDBsMCwtNDh6Ii8+CiAg%0D%0APHBhdGggZmlsbD0iI2ZmZmZmZiIgaWQ9InN2Z18yIiBkPSJtMjQsNDIuN2wtMi45LC0yLjYzYy0x%0D%0AMC4zLC05LjM1IC0xNy4xLC0xNS41MiAtMTcuMSwtMjMuMDdjMCwtNi4xNyA0LjgzLC0xMSAxMSwt%0D%0AMTFjMy40OCwwIDYuODIsMS42MiA5LDQuMTdjMi4xOCwtMi41NSA1LjUyLC00LjE3IDksLTQuMTdj%0D%0ANi4xNywwIDExLDQuODMgMTEsMTFjMCw3LjU1IC02LjgsMTMuNzIgLTE3LjEsMjMuMDdsLTIuOSwy%0D%0ALjYzeiIvPgogPC9nPgo8L3N2Zz4="/><span class="menu__text">SHARES</span></a>
	<%-- <a class="menu__item" id="i-3" href="<%=request.getContextPath()%>/about/aboutList"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGlk%0D%0APSJzdmdfMSIgZmlsbD0ibm9uZSIgZD0ibTAsMGw0OCwwbDAsNDhsLTQ4LDBsMCwtNDh6Ii8+CiAg%0D%0APHBhdGggZmlsbD0iI2ZmZmZmZiIgaWQ9InN2Z18yIiBkPSJtMjAsNDBsOCwwbDAsLTMybC04LDBs%0D%0AMCwzMnptLTEyLDBsOCwwbDAsLTE2bC04LDBsMCwxNnptMjQsLTIybDAsMjJsOCwwbDAsLTIybC04%0D%0ALDB6Ii8+CiA8L2c+Cjwvc3ZnPg=="/><span class="menu__text" style="width : 100px" >ABOUT US</span></a> --%>
	<a class="menu__item" id="i-4" href="<%= request.getContextPath() %>/column/columnList"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGlk%0D%0APSJzdmdfMSIgZmlsbD0ibm9uZSIgZD0ibTAsMGw0OCwwbDAsNDhsLTQ4LDBsMCwtNDh6Ii8+CiAg%0D%0APHBhdGggZmlsbD0iI2ZmZmZmZiIgaWQ9InN2Z18yIiBkPSJtMjAsNDBsOCwwbDAsLTMybC04LDBs%0D%0AMCwzMnptLTEyLDBsOCwwbDAsLTE2bC04LDBsMCwxNnptMjQsLTIybDAsMjJsOCwwbDAsLTIybC04%0D%0ALDB6Ii8+CiA8L2c+Cjwvc3ZnPg=="/><span class="menu__text">COLUMN</span></a>
	<%-- <a class="menu__item" id="i-5" href="<%= request.getContextPath() %>/faq/faqList"><img class="menu__icon" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAw%0D%0AL3N2ZyI+CgogPGc+CiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPgogIDxyZWN0IGZpbGw9Im5v%0D%0AbmUiIGlkPSJjYW52YXNfYmFja2dyb3VuZCIgaGVpZ2h0PSI0MDIiIHdpZHRoPSI1ODIiIHk9Ii0x%0D%0AIiB4PSItMSIvPgogPC9nPgogPGc+CiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPgogIDxwYXRoIGlk%0D%0APSJzdmdfMSIgZmlsbD0ibm9uZSIgZD0ibTAsMGw0OCwwbDAsNDhsLTQ4LDBsMCwtNDh6Ii8+CiAg%0D%0APHBhdGggZmlsbD0iI2ZmZmZmZiIgaWQ9InN2Z18yIiBkPSJtMjAsNDBsOCwwbDAsLTMybC04LDBs%0D%0AMCwzMnptLTEyLDBsOCwwbDAsLTE2bC04LDBsMCwxNnptMjQsLTIybDAsMjJsOCwwbDAsLTIybC04%0D%0ALDB6Ii8+CiA8L2c+Cjwvc3ZnPg=="/><span class="menu__text">INFO</span></a> --%>



  <div id="active"></div>
  <div id="active-2"></div>
  <div id="active-3"></div>
</nav>
<hr style="border: solid 1px black; margin:0;">
</header>
<script>
window.addEventListener('load', () => {
	<% if(msg != null){ %>
		alert("<%= msg %>");
	<%} %>
});

const item = document.querySelectorAll(".menu__item");

/* */
// window.addEventListener("load", mainFunc);


const icon = document.querySelectorAll(".menu__icon");
const text = document.querySelectorAll(".menu__text");
const active = document.querySelector("#active");
const active2 = document.querySelector("#active-2");
const active3 = document.querySelector("#active-3");
//let colors = ["#c6a700","#c25e00", "#b91400","#5c007a" ,"black"];

let colors = ["black"];



let getIcon = (event) =>{
    for (var i = 0; i < icon.length; i++) {
        icon[i].classList.remove("is-icon-visible");
    }
    for (var i = 0; i < text.length; i++) {
        text[i].classList.remove("is-text-visible");
    }
}

</script>
<script>
$('.dropdown-toggle').dropdown()
</script>
