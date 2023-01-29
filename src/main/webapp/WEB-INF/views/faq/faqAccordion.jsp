<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faqArc.css"/>

<div class="faq-header">FAQ</div>

<div class="faq-content">
  <div class="faq-question">
    <input id="q1" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q1" class="panel-title"> 옷을 나눔하고 싶어요</label>
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
    <label for="q3" class="panel-title"> 나의 패션 센스를 뽐내고 싶어요 </label>
    <div class="panel-content"> ootd 게시판을 이용해보세요! </div>
  </div>
  
  <div class="faq-question">
    <input id="q4" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q4" class="panel-title"> 옷 나눔을 받았는데 마음에 들지 않아요 </label>
    <div class="panel-content"> 해당 회원과 협의해보세요 </div>
  </div>

	<div class="faq-question">
	    <input id="q5" type="checkbox" class="panel">
	    <div class="plus">+</div>
	    <label for="q5" class="panel-title"> 비회원은 share 게시판을 이용할 수 없나요? </label>
	    <div class="panel-content"> 해당 서비스는 회원 대상을 중심으로 이용 가능합니다. </div>
	</div>

	<div class="faq-question">
	    <input id="q6" type="checkbox" class="panel">
	    <div class="plus">+</div>
	    <label for="q6" class="panel-title"> 문의사항이 있어요 </label>
	    <div class="panel-content"> 페이지 좌측 하단에 INFO를 클릭해주세요! </div>
	</div>

	<div class="faq-question">
	    <input id="q7" type="checkbox" class="panel">
	    <div class="plus">+</div>
	    <label for="q7" class="panel-title"> 비회원은 share 게시판을 이용할 수 없나요? </label>
	    <div class="panel-content"> 해당 서비스는 회원 대상을 중심으로 이용 가능합니다. </div>
	</div>

  <div class="faq-question">
    <input id="q8" type="checkbox" class="panel">
    <div class="plus">+</div>
    <label for="q8" class="panel-title"> 나눔을 받을 주소(배송지) 등록은 어떻게 하나요? </label>
    <div class="panel-content"> 마이페이지에서 정보 등록이 가능합니다. </div>
  </div>
</div>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>