<%@page import="org.apache.catalina.authenticator.NonLoginAuthenticator"%>
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
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	
	List<ShareAttachment> shareAttachments = (List<ShareAttachment>)request.getAttribute("shareAttachments");
	List<ShareBoard> shareboards = (List<ShareBoard> )request.getAttribute("shareboards");
%>
<br /><br /><br />
<section id="board-container">
<h2 id = "shareboardlist" > SHARE  </h2>
<h3 id="shareboardlist2"> 더이상 입지 않는 아이템을 다른 회원들에게 무료로 양도해보세요 </h3>

<%----  검색상자  --%>
<style>
 div#search-container {
	margin-left : 300px;
	margin-top : 35px;
 	width: 280px; 
 	padding:3px; 
 	background-color: white;
	float : left;
	font-family: 'Nanum Gothic Coding', monospace;		
	font-size : 17px;
	
 }
 
 div#search-memberId {
 	display: <%= searchType == null || "member_id".equals(searchType) ? "inline-block" : "none" %>; 
 }
 
 div#search-category{
 	display: <%= "share_category".equals(searchType) ?  "inline-block" :  "none" %> ; 
 }
 
 div#search-content{
 	display: <%= "sahre_content".equals(searchType) ?  "inline-block" :  "none" %> ; 
 }
 
 
 </style>
 
 <script> 
 window.addEventListener('load', () => {
	 document.querySelector("#searchType").addEventListener('change', (e) => {
		 console.log( e.target.value ); //여기 나오는 값이 : member_id, 스타일 
		 
		  document.querySelectorAll(".search-type").forEach( (div) => {
			 div.style.display = "none"; // 일단 다 감춰놓기 (모두숨김 )
		 }); 
		 
		 //현재 선택된 값에 상응하는 div만 노출시키기 
		 let id;
		 
		 switch(e.target.value){
		 case "member_id" : 
			 id = "search-memberId";
			 break;
			 
		 case "share_category" : 
			 id = "search-category";
			 break;
			 
		 case "sahre_content" :
			 id = "search-content";
			 break;
		 
		 default :
			 id = "search-memberId";
			 break;
		 }
		 
		
		 document.querySelector("#" + id ).style.display = "inline-block";
		
	 })
 })

 </script>

 <div id="search-container">
  		<img style="width:16px; height:16px; margin :0" src="<%=request.getContextPath()%>/uploadootds/o.png" alt="" />
        <label for="searchType" >검색타입 :</label> 
        <select id="searchType"  style="width:90px; margin-top:10px; height : 30px; border : 3px solid black" >
            <option value="member_id" <%= "member_id".equals(searchType) ? "selected" : "" %>  style="width:90px; line-height : 30px;"> 아이디</option>        
            <option value="share_category" <%= "share_category".equals(searchType) ? "selected" : ""%>  style="width:90px; line-height : 30px" > 카테고리 </option>
            <option value="sahre_content" <%= "sahre_content".equals(searchType) ? "selected" : ""%>  style="width:90px; line-height : 30px" > 내용 </option>
        </select>
<!-- 검색타입  : 체크박스 상자 -->        

        <div id="search-memberId" class="search-type"> <!-- 1.멤버아이디로검색 -->
<%--             <form name="findidFrm" id="form"  action="<%=request.getContextPath()%>/share/shareWholeListFind"  >--%>
            <div class="wrap">
			   <div class="search">
                <input type="hidden" name="searchType" id="searchType" value="member_id"/>
                <input type="text" name="searchKeywordID"  size="25" placeholder=" 검색할 아이디를 입력하세요. ex)cathj " id="searchKeywordID" style=" border: 3px solid black; width : 500px
                ; border-radius: 5px 0 0 5px; font-size : 15px;"  value = "<%= "member_id".equals(searchType) ? searchKeyword : "" %>"/>
                <button type="submit" class="searchButton" id="searchButton"><i class="fa fa-search"></i></button><!-- //검색버튼  -->
                </div>
             </div>   
<!--             </form>    -->
        </div>
        
        <div id="search-category" class="search-type">  <!-- 2. 카테고리로 검색 -->
            <div class="wrap">
		   		<div class="search">
	               <input type="hidden" name="searchType"  id="searchType" value="share_category" />
	               <input type="text" name="searchKeywordID" size="25" placeholder=" 카테고리를 검색해보세요  ex)상의, 하의, 악세서리   " id="searchKeywordID"  style=" border: 3px solid black; width : 500px;
	               border-radius: 5px 0 0 5px;  font-size : 15px;" value="<%= "share_category".equals(searchType) ? searchKeyword : ""%>"/>
	              <button type="submit" class="searchButton" id="searchButtoncate" ><i class="fa fa-search"></i></button><!-- //검색버튼  -->
             	</div>
            </div>   
        </div>
        
         <div id="search-content" class="search-type">  <!-- 3. 내용으로 검색 -->
            <div class="wrap">
		   		<div class="search">
	               <input type="hidden" name="searchType"  id="searchType" value="sahre_content" />
	               <input type="text" tabindex="1" name="searchKeywordID" size="25" placeholder=" 내용을 검색해보세요  ex)사이즈, 겨울, 등등   " id="searchKeywordID"  style=" border: 3px solid black; width : 500px;
	               border-radius: 5px 0 0 5px;  font-size : 15px;" value="<%= "sahre_content".equals(searchType) ? searchKeyword : ""%>"/>
	              <button tabindex="2"  type="submit" class="searchButton" id="searchButtoncnt" ><i class="fa fa-search"></i></button><!-- //검색버튼  -->
             	</div>
            </div>   
        </div>
</div>
        
<%-- 
<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="스타일을 검색해보세요  ex)스트릿  ">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>
 --%>
 
<% if(loginMember != null){ %>
<input type="button" value="글쓰기" id="btnAdd"  style="margin-left : -600px"
	onclick="location.href='<%=request.getContextPath()%>/share/shareEnroll';"/> <%-- get&post다있는데/ 로그인한 상태에서만 노출 되게 수정해야됨 --%> 
<% } %>


<table id="tblBoard" >
  <% for(int i=0; i<shareAttachments.size(); i++){
   	 if(i%2==0){%>
	<tr >
	<%} %>
  	<td class="maketd" style="width:220px">
     <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=<%=shareAttachments.get(i).getBoardNo()%>">
       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px;  margin-left:-3px" src="<%=request.getContextPath()%>/uploadshares/share/<%=shareAttachments.get(i).getRenamedFilename()%>"/></a><br/>
		<p class="non">NO <span style="color : black; font-weight : light"><%=shareAttachments.get(i).getBoardNo()%></span></p>
		<p class="non">N  <span style=" color : black; font-weight : light"><%=shareAttachments.get(i).getRegDate()%></span></p>
	</td>
	<td class ="detailtd" style="width:220px">
		<img class="carrots"src="<%=request.getContextPath()%>/uploadshares/carrot.png" alt="carrot" style=" width:16px; height:16px;  margin-left:-5px" />
		<p  id="buttonglow"><%=shareboards.get(i).getShareState()%></p>			
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
function styleback(){
	const img  = document.querySelectorAll(".maketd");
	
	img.forEach( (i, index) => {
		i.addEventListener('mouseenter', (e) => {
			i.style.backgroundColor = "#db0d36";	
		})
	});
};

/* window.onload{
	styleback();
} */

</script>


<script>
// 1. id로 검색 
const searchButton	= document.querySelector("#searchButton");
searchButton.addEventListener('click', () => {
		
	$.ajax({
			url : "<%=request.getContextPath()%>/share/shareWholeListFind",
			method : "get",
			data : {
				searchType :  document.getElementById("searchType").value,
				searchKeywordID : document.getElementById("searchKeywordID").value
			},
			dataType : "json",
		
			success(data){
				console.log ( data ); 
				
				const table = document.querySelector("#tblBoard")
				table.innerHTML = "";
				pagebar.innerHTML = "";
				
				const tbody = document.createElement("tbody")
				table.append(tbody);
				
				const tr = document.createElement("tr")
				tbody.append(tr);
				
				//foreach
				data.forEach( (e, index) => {
					
				if(data==0){
					alert("검색결과가 없습니다 😣");
					return;
				}
				
			
			tr.innerHTML	+= 
	`<td class="maketd" style="width:220px;">
       <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=\${e.ShareNo}">
       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px;  margin-left:-3px" src="<%=request.getContextPath()%>/uploadshares/share/\${e.renamedFilename}"/></a><br/>
        <p class="non">NO <span style="color : black; font-weight : light">\${e.ShareNo}</span></p>
        <p class="non">N  <span style=" color : black; font-weight : light">\${e.ShareRegDate}</span></p>
    </td>`;
    
				});
			//	table.innerHTML += data;
			},
			error : console.log,
			complete(){
				//const table =  document.querySelector("#tblBoard");				
				//table.innerHTML  += "";
			}
			
	});//ajax
});//

</script>

<!-- 카테고리로 검색  -->
<script>
const searchButtoncate = document.querySelector("#searchButtoncate");
searchButtoncate.addEventListener('click', () => {
	
	const keyword = document.getElementsByName("searchKeywordID");

	$.ajax({
			url : "<%=request.getContextPath()%>/share/shareWholeListFind",
			method : "get",
			data : {
				searchType :  document.getElementById("searchType").value,
				searchKeywordID : keyword[1].value
			},
			dataType : "json",
		
			success(data){
				console.log ( data ); 
				
				const table = document.querySelector("#tblBoard")
				table.innerHTML = "";
				pagebar.innerHTML = "";
				
				const tbody = document.createElement("tbody")
				table.append(tbody);
				
				const tr = document.createElement("tr")
				tbody.append(tr);
				
				//foreach
				data.forEach( (e, index) => {
					
				if(data==0){
					alert("검색결과가 없습니다 😣");
					return;
				}
				
			
			tr.innerHTML	+= 
	`<td class="maketd" style="width:220px;">
       <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=\${e.ShareNo}">
       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px;  margin-left:-3px" src="<%=request.getContextPath()%>/uploadshares/share/\${e.renamedFilename}"/></a><br/>
        <p class="non">NO <span style="color : black; font-weight : light">\${e.ShareNo}</span></p>
        <p class="non">N  <span style=" color : black; font-weight : light">\${e.ShareRegDate}</span></p>
    </td>`;
    
				});
			//	table.innerHTML += data;
			},
			error : console.log,
			complete(){
				//const table =  document.querySelector("#tblBoard");				
				//table.innerHTML  += "";
			}	
	});//ajax
});//
</script>


<!-- 3.내용에따라검색 
<script>
const searchButtoncnt = document.querySelector("#searchButtoncnt");
searchButtoncnt.addEventListener('click', () => {
	
	const keyword = document.getElementsByName("searchKeywordID");

	$.ajax({
			url : "<%=request.getContextPath()%>/share/shareWholeListFind",
			method : "get",
			data : {
				searchType :  document.getElementById("searchType").value,
				searchKeywordID : keyword[2].value
			},
			dataType : "json",
		
			success(data){
				console.log ( data ); 
				
				const table = document.querySelector("#tblBoard")
				table.innerHTML = "";
				pagebar.innerHTML = "";
				
				const tbody = document.createElement("tbody")
				table.append(tbody);
				
				const tr = document.createElement("tr")
				tbody.append(tr);
				
				//foreach
				data.forEach( (e, index) => {
					
				if(data==0){
					alert("검색결과가 없습니다 😣");
					return;
				}
				
			
			tr.innerHTML	+= 
	`<td class="maketd" style="width:220px;">
       <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=\${e.ShareNo}">
       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px;  margin-left:-3px" src="<%=request.getContextPath()%>/uploadshares/share/\${e.renamedFilename}"/></a><br/>
        <p class="non">NO <span style="color : black; font-weight : light">\${e.ShareNo}</span></p>
        <p class="non">N  <span style=" color : black; font-weight : light">\${e.ShareRegDate}</span></p>
    </td>`;
    
				});
			//	table.innerHTML += data;
			},
			error : console.log,
			complete(){
				//const table =  document.querySelector("#tblBoard");				
			}	
	});//ajax
});//
</script>
-->

<%-- 혜진 코드 실험 0201 -- 내용따라검색 --%>
<script>
const searchButtoncnt = document.querySelector("#searchButtoncnt");
searchButtoncnt.addEventListener('click', () => {
	
	const keyword = document.getElementsByName("searchKeywordID");

	$.ajax({
			url : "<%=request.getContextPath()%>/share/shareWholeListFind",
			method : "get",
			data : {
				searchType :  document.getElementById("searchType").value,
				searchKeywordID : keyword[2].value
			},
			dataType : "json",
		
			success(data){
			//	console.log ( data ); 
				
				const table = document.querySelector("#tblBoard")
				table.innerHTML = "";
				pagebar.innerHTML = "";
				
				const tbody = document.createElement("tbody")
				table.append(tbody);
				
				const tr = document.createElement("tr");
				
			//	const tr = document.createElement("tr")
			//  tbody.append(tr);
				
//////////////////////////////////////////////////////foreach
				if(data==0){
					alert("검색결과가 없습니다 😣");
					return;
				}
				
				else{
				
					for(let i=0; i<data.length; i++){
						if(i%5==0){
							console.log( i + "i%5인경우(나머지0)");
						
							tbody.append( tr ); ///////jkjkjjk
						
						}
						/// if문에 해당하지않는다면 ///
						console.log("일반에해당 "+ i)
						
					const tds  = 
							`<td class="maketd" style="width:220px;">
						       <a class="atags" style="display :inline;" href="<%=request.getContextPath()%>/share/shareView?no=\${data[i].ShareNo}">
						       <img id="eachimg"  style="display : inline-block; height : 200px; width:190px;  margin-left:-3px" src="<%=request.getContextPath()%>/uploadshares/share/\${data[i].renamedFilename}"/></a><br/>
						        <p class="non">NO <span style="color : black; font-weight : light">\${data[i].ShareNo}</span></p>
						        <p class="non">N  <span style=" color : black; font-weight : light">\${data[i].ShareRegDate}</span></p>
						    </td>`;
						    tr.insertAdjacentHTML('beforebegin',tr);  ///////jkjkjjk
					  ///////////////////////
						if(i%5==4){
							console.log( i + "나머지가4인경우");
						//	tbody.innerHTML += `</tr>`;
						//	console.log( tbody );
							  tds.insertAdjacentHTML('afterend', tr);  ///////jkjkjjk 
						}
					//	console.log( data[i] );
					}
				}//end-els문	
				console.log( tbody );
			},	//	end - success
			error : console.log,
			complete(){
				//const table =  document.querySelector("#tblBoard");				
			}	
	});//ajax
});//
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
