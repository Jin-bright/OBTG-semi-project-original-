<%@page import="com.sh.obtg.message.model.dto.Message"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Message> messages = (List<Message>)request.getAttribute("msgList");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberView.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/msgList.css" />
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
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
				<a href="<%= request.getContextPath() %>/member/memberBoardList">
					<img src="<%= request.getContextPath()%>/image/list.png" alt="" />
					<li>&nbsp;List</li>
				</a>
			</div>
			<div class="container-li">
				<a href="<%= request.getContextPath() %>/message/messageList">
					<img src="<%= request.getContextPath()%>/image/chat.png" alt="" />
					<li>&nbsp;Chat</li>
				</a>
			</div>
			<div class="container-li">
				<a href="<%= request.getContextPath() %>/member/memberOotdLike">
					<img src="<%= request.getContextPath()%>/image/like.png" alt="" />
					<li>&nbsp;Like</li>
				</a>
			</div>
		</ul>
	</div>
	<hr />
	<section id="msg-container">
		<h2>나에게 온 쪽지</h2>
		<table id="msg-wrap">
			<thead>
				<tr>
					<td colspan="4" style="border-style: none; float: left;"><button>삭제</button></th>
				</tr>
				<tr>
					<th id="check"><input type="checkbox" name="selectAll" id="selectAll" /></th>
					<th id="sen">보낸사람</th>
					<th id="tit">제목</th>
					<th id="reg">날짜</th>
				</tr>
			</thead>
			<tbody>
				<% if(messages.size() > 0){
					for(Message message : messages){
				%>
				<tr id="msg-content">
					<td>
						<input type="checkbox" name="selectMsg" id="selectMsg" />
					</td>
					<td class="msg"><%= message.getMessageSender() %></td>
					<td class="msg">
						<button id="msgBtn" 
							data-receiver=<%= message.getMessageReceiver() %>
							data-sender=<%= message.getMessageSender() %>
							data-title=<%= message.getMessageTitle() %>
							data-content=<%= message.getMessageContent() %>
							data-reg-date=<%= message.getMessageRegdate() %>>
							<%= message.getMessageTitle() %>
						</button>
					</td>
					<td class="msg"><%= message.getMessageRegdate() %></td>
				</tr>
				<% 	} 
			  	 }else{
				%>
				<tr>
					<td colspan="4">도착한 쪽지가 없어요!</td>
				</tr>	
				<% } %>
			</tbody>
		</table>
		<div id="pagebar">
			<%= request.getAttribute("pagebar") %>
		</div>
	</section>
</div>
<!-- 읽는 폼 -->
<form class="readFrm">
	<table id="msgTable" >
		<tr>
			<th class="msgtg"> 받는사람 </th>
			<td class="msgtd" ><input type="text" id="receiver" name="receiver" readonly="readonly"></td>
		</tr>
		<tr>
			<th  class="msgtg" > 보내는 사람 </th>
			<td class="msgtd" ><input type="text" id="sender" name="sender" readonly="readonly"></td>
		</tr>
		<tr>
			<th class="msgtg" > 제목 </th>
			<td class="msgtd" ><input type="text" id="msgTitle" name="msgTitle" readonly="readonly"></td>
		</tr>
		<tr>
			<th class="msgtg"> 보낸 시간 </th>
			<td class="msgtd" ><input type="text" id="msgDate" name="msgDate" readonly="readonly"></td>
		</tr>
		<tr>
			<th class="msgtg" > 내용 </th>
			<td class="msgtd" ><textarea id="msgContent" name="msgContent" readonly="readonly"></textarea></td>
		</tr>
		<tr>
			<td><button>답장하기</button></td>
			<td><button onclick="closeMsg();">닫기</button></td>
		</tr>
	</table>
</form>
<!-- 답장하는 폼 -->


<script>
document.querySelectorAll("#msgBtn").forEach((btn) => {
	btn.onclick = (e) => {
		const frm = document.querySelector(".readFrm");
		const receiver = document.querySelector("#receiver")
		const sender = document.querySelector("#sender")
		const msgTitle = document.querySelector("#msgTitle")
		const msgContent = document.querySelector("#msgContent")
		const msgDate = document.querySelector("#msgDate")
		
		receiver.value = e.target.dataset.receiver;
		sender.value = e.target.dataset.sender;
		msgTitle.value = e.target.dataset.title;
		msgContent.value = e.target.dataset.content;
		msgDate.value = e.target.dataset.regDate;
		
		frm.classList.toggle("showPopup");
	}
});

$(function(){

	$('.readFrm').draggable({'cancel':'#msgTable'});

});

const closeMsg = () => {
	const frm = document.querySelector(".readFrm");
	frm.classList.toggle("showPopup");
}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>