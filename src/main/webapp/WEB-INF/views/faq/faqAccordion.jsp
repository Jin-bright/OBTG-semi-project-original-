<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faq.css" />

<div class="faq-header">FAQ</div>

<div class="faq-content">
  <div class="faq-question">
    <input id="q1" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q1" class="panel-title"> 옷 나눔을하고 싶어요</label>
    <div class="panel-content"> SHARE게시판을 이용해보세요! </div>
  </div>
  
  <div class="faq-question">
    <input id="q2" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q2" class="panel-title"> 이상한 회원을 발견했어요 </label>
    <div class="panel-content"> 신고 기능을 적극 이용바랍니다! </div>
  </div>
  
  <div class="faq-question">
    <input id="q3" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q3" class="panel-title"> 배고파요 </label>
    <div class="panel-content"> 당신 코딩 실력에 밥먹을 시간이 있나요? </div>
  </div>
</div>

<div class="faq-question">
    <input id="q4" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q4" class="panel-title"> 졸려요 </label>
    <div class="panel-content"> 당신 코딩 실력에 잠이 오시나요? </div>
  </div>
</div>

<div class="faq-question">
    <input id="q5" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q5" class="panel-title"> 힘들어요 </label>
    <div class="panel-content"> 포기하세요! </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>