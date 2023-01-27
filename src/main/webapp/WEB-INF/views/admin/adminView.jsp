<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sh.obtg.member.model.dto.Member"%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp" %> --%>
<html>
  <head>
   <style type="text/css">
 a:link { color: unset; text-decoration: none;}
 a:visited { color: unset; text-decoration: none;}
 a:hover { color: unset; text-decoration: underline;}
</style>
    <meta charset="utf-8">
<!--     <title>Locatielezen Administrator page</title> -->
    <link rel="stylesheet" href="normalize.css" charset="utf-8" />
    <link rel="stylesheet" href="admin--test.css" charset="utf-8" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/adminView.css"/> 
  </head>
  <body class="admin">

    <header class="admin__statusbar flex--center">
      <a href="<%= request.getContextPath() %>/admin/adminView"><span class="home"><i class="fa fa-home"></i>Home</span></a>
      <span id="username"><i class="fa fa-user"></i>관리자</span>
    </header>

    <nav class="admin__sidepanel">
      <ul>
        <li>
          <%-- <a class="fa fa-file-text-o" href="<%= request.getContextPath() %>/admin/memberList">회원관리</a> --%>
         <a href="<%= request.getContextPath() %>/admin/memberList"><i class="fa fa-file-text-o"></i>회원관리</a>
        </li>
        <li>
          <i class="fa fa-pencil-square-o"></i>게시글 목록 조회
        </li>
        <li>
          <i class="fa fa-times-circle-o"></i>문의 내역
        </li>
        <li>
          <i class="fa fa-plus-square-o"></i> 신고 내역 
        </li>
      </ul>
    </nav>

  </body>
</html>