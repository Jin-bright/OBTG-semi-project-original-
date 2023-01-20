<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    
<style>
@import "compass/css3";

/* $body-bg: #c1bdba;
$form-bg: #13232f;
$white: #ffffff;

$main: #1ab188;
$main-light: lighten($main,5%);
$main-dark: darken($main,5%);

$gray-light: #a0b3b0;
$gray: #ddd;

$thin: 300;
$normal: 400;
$bold: 600;
$br: 4px; */

*, *:before, *:after {
  box-sizing: border-box;
}

html {
	overflow-y: scroll; 
}

body {
  background:$body-bg;
  font-family: 'Titillium Web', sans-serif;
}

#atag {
	margin-left: 85px;
  font-size : 35px;
  text-decoration:none;
  color:$main;
  transition:.5s ease;
  &:hover {
    color:$main-dark;
  }
}

  .tab {
	float: left;
	margin-bottom : 50px;
} 

/* .tab {
	float : right;
}  
*/

.form {
  background:rgba($form-bg,.9);
  padding: 40px;
  max-width:600px;
  margin: auto;
  border-radius:$br;
  box-shadow:0 4px 10px 4px rgba($form-bg,.3);
}

.tab-group {
  list-style:none;
  padding:0;
  margin:0 0 40px 0;
  
  &:after {
    content: "";
    display: table;
    clear: both;
  }
  .tab-group li{
  	display: inline;
  }
   .tab-group li a {
    display:inline-block;
    text-decoration:none;
    padding:15px;
    color:$gray-light;
    font-size:20px;
    float:left;
    width:50%;
    text-align:center;
    cursor:pointer;
    transition:.5s ease;
    &:hover {
      background:$main-dark;
      color:$white;
    }
  }
  .tab-group .active a {
    background:$main;
    color:$white;
  }
}

.tab-content > div:last-child {
  display:none;
}

label {
  position : relative;
 /*  transform:translateY(6px); */
  left:13px;
  color:rgba($white,.5);
  transition:all 0.25s ease;
  -webkit-backface-visibility: hidden;
  pointer-events: none;
  font-size:22px;
  .req {
  	margin:2px;
  	color:$main;
  }
}

label.active {
  transform:translateY(50px);
  left:2px;
  font-size:14px;
  .req {
    opacity:0;
  }
}

label.highlight {
	color:$white;
}
/* #top{
display: inline-block;
    margin-top: 50px;
} */
input, textarea {
  font-size:22px;
  display:block;
  width:100%;
  height:100%;
  padding:5px 10px;
  background:none;
  background-image:none;
  border:1px solid $gray-light;
  color:$white;
  border-radius:0;
  transition:border-color .25s ease, box-shadow .25s ease;
  &:focus {
		outline:0;
		border-color:$main;
  }
}
#check_label{
	display : inline-block;
}

textarea {
  border:2px solid $gray-light;
  resize: vertical;
}

.field-wrap {
  position:relative;
  margin-bottom:40px;
}
.check-wrap{
  position:relative;
  margin-bottom:40px;
  border: solid 2px black;
  border-radius: 30px;
}
.check-wrap div{
	display: inline-block;
	width: 90px;
	heigh: 50px;
}

.top-row {
  &:after {
    content: "";
    display: table;
    clear: both;
  }

  > div {
    float:left;
    width:48%;
    margin-right:4%;
    &:last-child { 
      margin:0;
    }
  }
}

.button {
  border:0;
  outline:none;
  border-radius:0;
  padding:15px 0;
  font-size:2rem;
  font-weight:$bold;
  text-transform:uppercase;
  letter-spacing:.1em;
  background:$main;
  color:$white;
  transition:all.5s ease;
  -webkit-appearance: none;
  &:hover, &:focus {
    background:$main-dark;
  }
}

.button-block {
  display:block;
  width:100%;
}

.forgot {
  margin-top:-20px;
  text-align:right;
}
</style>
<form name="memberEnrollFrm" method="POST" 
		action ="<%= request.getContextPath()%>/member/memberEnroll">
<div class="form">
      
      <ul class="tab-group">
        <li class="tab active"><a id="atag" href="#signup">Sign Up</a></li>
        <li class="tab"><a id="atag" href="#login">Log In</a></li>
      </ul>
      
      <div class="tab-content">
        <div id="signup">   
          <form action="/" method="post">
          
          <div class="top-row">
            <div class="field-wrap">
              <label id="top"  style= "position:absolute; margin-top:25px;" >
                ID<span class="req">*</span>
              </label>
              <input type="text"  autocomplete="off" />
            </div>
        
            <div class="field-wrap">
              <label>
                Password<span class="req">*</span>
              </label>
              <input type="password" autocomplete="off"/>
            </div>
          </div>

          <div class="field-wrap">
            <label>
              Password-Check<span class="req">*</span>
            </label>
            <input type="password" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Name<span class="req">*</span>
            </label>
            <input type="text" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
             Birthday <span class="req"></span>
            </label>
            <input type="date" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Email<span class="req">*</span>
            </label>
            <input type="email" autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Phone<span class="req">*</span>
            </label>
            <input type="text" autocomplete="off"/>
          </div>
          
          <label>
              Style<span class="req"></span>
            </label>
          <div class="check-wrap">
          <div>
            <label id="style-label">
              러블리<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              댄디<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              포멀<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              스트릿<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              걸리쉬<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              레트로<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              로맨틱<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              시크<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
            <div>
            <label id="style-label">
              아메카지<span class="req"></span>
            </label>
            <input type="checkbox" id="check_label" autocomplete="off"/> 
            </div>
          </div>          
          <button type="submit" class="button button-block"/>Sing up</button>          
          </form>
        </div>
        
        <div id="login">
          <form action="/" method="post">
            <div class="field-wrap">
            <label style= "position:absolute; margin-top:25px;">
              ID<span class="req"></span>
            </label>
            <input type="text"required autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Password<span class="req"></span>
            </label>
            <input type="password"required autocomplete="off"/>
          </div>
          
          
          <button class="button button-block"/>Log In</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->

</form>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/memberEnroll.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>