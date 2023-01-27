<%@page import="com.sh.obtg.faq.model.dto.faq"%>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 리스트 객체 -->
<%
	List<faq> faqList = (List<faq>) request.getAttribute("faqList");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faq.css" />


<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div id="wrap">
    	<h2>게시글 리스트</h2>
    	

    	<table>
    		<tr>
    	<input type="button" value="글쓰기" id="btn-add" onclick="location.href = '<%= request.getContextPath() %>/faq/faqEnroll';" />
    		</tr>
    		<tr>
    			<th>번호</th>
    			<th>제목</th>
    			<th>작성자</th>
    			<th>작성날짜</th>
    			<th>조회수</th>
    		</tr>
				<tr>
					<td><%= faq.g %></td>
					<td>${posting.title }</td>
					<td>${posting.name }</td>
					<td>${posting.writeDate }</td>
					<td>${posting.readCount }</td>
				</tr>
    	</table>
    </div>
</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>