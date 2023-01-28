<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.sh.obtg.member.model.dto.Gender"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memberView.css">
<div class="main">
<div class="container-menu">
	 <ul>
	 <div class="container-li">
	 <a href="<%= request.getContextPath()%>/member/memberView">
	 <img src="<%= request.getContextPath()%>/image/modify.png" alt="" />
	 	<li>&nbsp;Info</li>
	 </a>
	 </div>
	 <div class="container-li">
	 <a href="">
	 <img src="<%= request.getContextPath()%>/image/list.png" alt="" />
	 	 <li>&nbsp;List</li>
	 </a>
	 </div>
	 <div class="container-li">
	 <a href="">
	 <img src="<%= request.getContextPath()%>/image/chat.png" alt="" />
	 	<li>&nbsp;Chat</li>
	 </a>
	 </div>
	 <div class="container-li">
	 <a href="">
	 <img src="<%= request.getContextPath()%>/image/like.png" alt="" />
	 	<li>&nbsp;Like</li>
	 </a>
	 </div>
	 </ul>
</div>
<hr />
<script src = "<%=request.getContextPath()%>/js/ws.js"></script>
<div class="form">
<h2 style="text-align: center;">개인 정보</h2>
<br />
          
          <form name="memberView" method="POST" action ="<%= request.getContextPath()%>/member/memberUpdate">
          <div class="container-main">
            <div class="field-wrap">
              <label class="top">
                ID<span class="req">*</span>
              </label>
              <input type="text" name="memberId" id="memberId" value="<%= loginMember.getMemberId() %>" readonly/>		  
            </div>
             </div>
            <!--<div class="field-wrap">
              <label>
                Password<span class="req">*</span>
              </label>
              <input type="password" name="password" id="password"/>
            </div>
          <div class="field-wrap">
            <label>
              Password-Check<span class="req">*</span>
            </label>
            <input type="password" id="passwordCheck"/>
            <button class="button password-change" onclick="updatePassword();">비밀번호 변경</button>
          </div> -->
          
          <div class="field-wrap">
            <label>
              Name<span class="req">*</span>
            </label>
            <input type="text" name="name" id="name" value="<%= loginMember.getName() %>" required/>
          </div>
          
          <div class="field-wrap">
            <label>
              Nick Name<span class="req">*</span>
            </label>
            <input type="text" name="nickname" id="nickname" value="<%= loginMember.getNickname() %>" required/>
          </div>
          
           <div class="field-wrap">
            <label>
              Gender<span class="req"></span>
            </label>
					<input type="radio" name="gender" id="gender0" value="M" <%= loginMember.getGender() == Gender.M ? "checked" : "" %>>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F" <%= loginMember.getGender() == Gender.F ? "checked" : "" %>>
					<label for="gender1">여</label>
			</div>	
			
          <div class="field-wrap">
            <label>
             Birthday <span class="req"></span>
            </label>
            <input type="date" name="birthday" id="birthday" value="<%= loginMember.getBirthday() %>"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Email<span class="req">*</span>
            </label>
            <input type="email" name="email" id="email" value="<%= loginMember.getEmail() %>" required/>
          </div>
          
          <div class="field-wrap">
            <label>
              Phone<span class="req">*</span>
            </label>
            <input type="text" name="phone" id="phone" value="<%= loginMember.getPhone() %>" required/>
          </div>
          
          <div class="field-wrap">
            <label>
              Introduce<span class="req"></span>
            </label>
            <input type="text" name="introduce" id="introduce" value="<%= loginMember.getIntroduce() %>"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Profile-file<span class="req"></span>
            </label>
            <input type="file" name="upFile" id="upFile" value="<%= loginMember.getOriginal() %>"/>
          </div>
        <%
	String style = loginMember.getStyle(); // nullable
	List<String> styleList = null;
	if(style != null){
		styleList = Arrays.asList(style.split(","));		
	}
	
%>
          <fieldset class="checkbox-group">
	<legend class="checkbox-group-legend">Choose your Style *</legend>
	<tr id="check-box" required>
		<td>
			<input type="checkbox" name="style" id="S1" value="러블리"<%= styleList != null && styleList.contains("러블리") ? "checked" : "" %>><label for="S1">lovely</label>	
		</td>
		<td>
			<input type="checkbox" name="style" id="S2" value="댄디"<%= styleList != null && styleList.contains("댄디") ? "checked" : "" %>><label for="S2">Dandy</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S3" value="포멀"<%= styleList != null && styleList.contains("포멀") ? "checked" : "" %>><label for="S3">Formal</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S4" value="스트리트"<%= styleList != null && styleList.contains("스트리트") ? "checked" : "" %>><label for="S4">Street</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S5" value="걸리쉬"<%= styleList != null && styleList.contains("걸리쉬") ? "checked" : "" %>><label for="S5">Girlish</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S6" value="레트로"<%= styleList != null && styleList.contains("레트로") ? "checked" : "" %>><label for="S6">Retro</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S7" value="로맨틱"<%= styleList != null && styleList.contains("로맨틱") ? "checked" : "" %>><label for="S7">Romantic</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S8" value="시크"<%= styleList != null && styleList.contains("시크") ? "checked" : "" %>><label for="S8">Chic</label>
		</td>
		<td>
			<input type="checkbox" name="style" id="S9" value="아메카지"<%= styleList != null && styleList.contains("아메카지") ? "checked" : "" %>><label for="S9">Amekaji</label>
		</td>
	</tr>
</fieldset>
          <button type="submit" class="button button-modify"/>수정</button>          
          <button type="submit" class="button button-remove"/>비밀번호 변경</button>          
          <button type="submit" class="button button-delete" onclick="deleteMember();"/>탈퇴</button>          
          </form>
        </div>
        </div>
     <!-- /form -->
<form action="<%= request.getContextPath() %>/member/memberDelete" method="POST" name="memberDeleteFrm"></form>
<script>
	const deleteMember = () => {
		if(confirm('정말 회원탈퇴하시겠습니까?')){
			document.memberDeleteFrm.submit();
		}
	};
	
<%-- 	const updatePassword = () => {
		location.href = "<%= request.getContextPath()%>/member/updatePassword";
	}; --%>
	
	document.memberUpdateFrm.onsubmit = (e) => {
		const memberName = document.querySelector("#memberName");
		const email = document.querySelector("#email");
		const phone = document.querySelector("#phone");
		const nickname = document.querySelector("#nickname");
		
		// 이름 - 한글 2글자이상
		if(!/^[가-힣]{2,}$/.test(memberName.value)){
			alert("이름은 한글 2글자 이상이어야 합니다.");
			memberName.select();
			return false;
		}
		
		// 전화번호는 숫자 01012345678 형식
		if(!/^010[0-9]{8}$/.test(phone.value)){
			alert("전화번호가 유효하지 않습니다.");
			phone.select();
			return false;
		}
	}
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>