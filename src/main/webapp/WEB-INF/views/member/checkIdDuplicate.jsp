<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	String memberId = request.getParameter("memberId");
	boolean available = (boolean) request.getAttribute("available");
	 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디중복검사</title>
</head>
<body>
	<div id="checkId-container">
	<% if(available) {%>
	<p>
	<span id="available"><%= memberId %></span>]는 사용가능합니다.
	</p>
	<p>
		<input type="button" value="닫기" onclick="closePopup();"/>
	</p>
	<%} else { %>
	<p>
	<span id="available"><%= memberId %></span>]는 이미 사용중입니다.
	</p>
	<form action="<%= request.getContextPath() %>/member/checkIdDuplicate"name="checkIdDuplicateFrm">
	<input type="hidden" name="memberId" id="memberId" placeholder="새로운 아이디를 입력해주세요."/>
	<input type="submit" value="제출" />
	</form>
	<%} %>
	</div>
	<script>
	<% if(!available){ %>
	document.checkIdDuplicateFrm.onsubmit = (e) => {
		const memberId = document.querySelector("#memberId");
		if(!/^[A-Za-z0-9]{4,}$/.test(memberId.value)){
			alert("아이디는 영문자/숫자 4글자 이상이어야 합니다.");
			memberId.select();
			return;
		};
	};
	<%}%>
	const closePopup=()=>{
		const parentFrm = opener.document.memberEnrollFrm;
		parentFrm.memberId.value = "<%=memberId%>";
		parentFrm.idValid.value = "1";
		self.close();
	}
	</script>
	}
</body>
</html>