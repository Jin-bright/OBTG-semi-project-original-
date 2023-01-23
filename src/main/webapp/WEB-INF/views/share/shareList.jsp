<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shareList.css" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<section id="board-container2">
<input type="button" value="글쓰기" id="btn-add" style="margin-right : 450px"
	onclick="location.href='<%=request.getContextPath()%>/share/shareEnroll"/>
	<br />	<br />	<br />

        <div class="product-list">
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225">
                <div class="product-name"  id="overlay">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다. 아 제발...에러 멈춰!
                </div>
            </a>

            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
               <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>

            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
                <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>

            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
                <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>

            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
                <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>

            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
               <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>

            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
               <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>
            
            <a href="#" class="product">
                <img src="https://pds.joongang.co.kr/news/component/joongang_sunday/202111/26/4c5aeae5-3b28-4785-9e50-7097139afc8e.jpg" width="225" >
                <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>
            </a>
            
            <a href="#" class="product">
                <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
               <div class="product-name">
                    힘들어요...
                </div>
                <div class="product-price">
                    옷 나눔 합니다...
                </div>      
            </a>
            <div class="clearfix"></div>
        </div>




	<div id='pagebar'></div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>