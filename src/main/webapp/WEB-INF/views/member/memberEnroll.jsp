<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memberEnroll.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/memberEnroll.js"></script>

<% if(loginMember != null){ %>
<script src = "<%=request.getContextPath()%>/js/ws.js"></script>
<% } %>

<script>
window.addEventListener('load',()=>{
	<%if(msg != null){%>
	alert("<%= msg %>");
	<%} %>
	
	<%if(loginMember == null) { %>
		document.loginFrm.addEventListener('submit', (e)=> {
			const memberId = document.querySelector("#memberId");
			const password = document.querySelector("#password");
			
			if(!/^\w{4,}$/.test(memberId.value)){
				alert("유효한 아이디를 입력하세요.");
				memberId.select();
				e.preventDefault();
				return ;				
			}
			if(!/^\w{4,}$/.test(password.value)){
				alert("유효한 비밀번호를 입력하세요");
				password.select();
				e.preventDefault();
				return ;
			}
		});
	<% } %>
		
});
</script>

<div class="form">
      <ul class="tab-group">
        <li class="tab active"><a id="atag" href="#signup">Sign Up</a></li>
        <li class="tab"><a id="atag" href="#login">Log In</a></li>
      </ul>
      <div class="tab-content">
      <div id="login">
          <form id="loginFrm" name="loginFrm" action="<%= request.getContextPath() %>/member/login" method="post">
            <div class="field-wrap">
            <label>
              ID<span class="req"></span>
            </label>
            <input type="text" name="memberId" id="memberId" value="<%= saveId != null? saveId: "" %>" required />
          </div>
          <div class="field-wrap">
            <label>
              Password<span class="req"></span>
            </label>
            <input type="password" name="password" id="password" required/>
          </div>
          <div>
          <input type="checkbox" name="saveId" id="saveId" <%= saveId != null ? "checked" : "" %> style="width:20px; display:inline-block;"/>
          <label for="saveId" style="font-size:15px;">아이디 저장</label>
          </div>
          <%-- <input type="button" class="button button-block" onclick="location.href='<%=request.getContextPath()%>/member/memberEnroll';"/>Log In --%>
          </form>
        </div>
        <!-- login form 끝 -->
      
        <div id="signup">   
          <form name="memberEnrollFrm" method="POST" action ="<%= request.getContextPath()%>/member/memberEnroll">
          <div class="top-row">
            <div class="field-wrap">
              <label class="top">
                ID<span class="req">*</span>
              </label>
              
              <input type="text"  name="memberId" id="memberId" autocomplete="off"/>
              <input type="button" value="ID 중복검사" onclick = "checkIdDuplicate();" style="margin-top: 5px; background-color: lightpink; border: 0px; cursor: pointer;"/>
			  <input type = "hidden" id = "idValid" name="idValid" value= "0"/>
			  
            </div>
            </div>
            <div class="field-wrap">
              <label>
                Password<span class="req">*</span>
              </label>
              <input type="password" name="password" id="password" autocomplete="off"/>
            </div>
          <div class="field-wrap">
            <label>
              Password-Check<span class="req">*</span>
            </label>
            <input type="password" id="passwordCheck" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Name<span class="req">*</span>
            </label>
            <input type="text" name="name" id="name" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
             Birthday <span class="req"></span>
            </label>
            <input type="date" name="birthday" id="birthday" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Email<span class="req">*</span>
            </label>
            <input type="email" name="email" id="email" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Phone<span class="req">*</span>
            </label>
            <input type="text" name="phone" id="phone" autocomplete="off"/>
          </div>
          
  <button type="submit" class="button button-block"/>Sing up</button>          
  </form>
</div>
        
        
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->



<%@ include file="/WEB-INF/views/common/footer.jsp" %>