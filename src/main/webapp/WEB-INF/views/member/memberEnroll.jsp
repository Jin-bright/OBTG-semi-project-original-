<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    
<style>
@import url("https://fonts.googleapis.com/css?family=Fira+Sans");

	html,body {
	position: relative;
	min-height: 100vh;
	background-color: #E1E8EE;
	/* display: flex; */
	align-items: center;
	justify-content: center;
	font-family: "Fira Sans", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
} 

.form-structor {
	background-color: #222;
	border-radius: 15px;
	height: 550px;
	width: 450px;
	position: relative;
	overflow: hidden;
	margin:auto;
}
	 .signup::after
	 .logout::after {
		content: '';
		opacity: .8;
		position: inherit;
		top: 0;
		right:0;
		bottom:0;
		left:0;
		background-repeat: no-repeat;
		background-position: left bottom;
		background-size: 500px;
		background-image: url('https://images.unsplash.com/photo-1503602642458-232111445657?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=bf884ad570b50659c5fa2dc2cfb20ecf&auto=format&fit=crop&w=1000&q=100');
	
}

	 
	.signup {
		position: absolute;
		top: 42%;
		left: 50%;
		-webkit-transform: translate(-50%, -50%);
		width: 65%;
		z-index: 5;
		-webkit-transition: all .3s ease;
		
	}
		.signup.slide-up {
			top: 5%;
			-webkit-transform: translate(-50%, 0%);
			-webkit-transition: all .3s ease;
		}
		
		.signup.slide-up .form-holder,
		.signup.slide-up .submit-btn {
			opacity: 0;
			visibility: hidden;
		}
		
		.signup.slide-up .form-title {
			font-size: 1em;
			cursor: pointer;
		}
		
		.signup.slide-up .form-title span {
			margin-right: 5px;
			opacity: 1;
			visibility: visible;
			-webkit-transition: all .3s ease;
		}
		
		.form-title {
			color: #fff;
			font-size: 1.7em;
			text-align: center;
		}
			span {
				color :rgba(0,0,0,0.4);
				opacity: 0;
				visibility: hidden;
				-webkit-transition: all .3s ease;
			}

		
		.form-holder {
			border-radius: 15px;
			background-color: #fff;
			overflow: hidden;
			margin-top: 50px;
			opacity: 1;
			visibility: visible;
			-webkit-transition: all .3s ease;
		}
			.input {
				border: 0;
				outline: none;
				box-shadow: none;
				display: block;
				height: 30px;
				line-height: 30px;
				padding: 8px 15px;
				border-bottom: 1px solid #eee;
				width: 100%;
				font-size: 12px;
			}
				.input:last-child {
					border-bottom: 0;
				}
				.input::-webkit-input-placeholder {
					color: rgba(0,0,0,0.4);
				}
			
		
		.submit-btn {
			background-color: rgba(0,0,0,0.4);
			color: rgba(256,256,256,0.7);
			border:0;
			border-radius: 15px;
			display: block;
			margin: 15px auto; 
			padding: 15px 45px;
			width: 100%;
			font-size: 13px;
			font-weight: bold;
			cursor: pointer;
			opacity: 1;
			visibility: visible;
			-webkit-transition: all .3s ease;
		}
			.submit-btn:hover {
				transition: all .3s ease;
				background-color: rgba(0,0,0,0.8);
			}
		
	
	
	.login {
		position: absolute;
		top: 20%;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #fff;
		z-index: 5;
		-webkit-transition: all .3s ease;
	}
		.signup::before
		.login::before {
			content: '';
			position: absolute;
			left: 50%;
			top: -20px;
			-webkit-transform: translate(-50%, 0);
			background-color: #fff;
			width: 200%;
			height: 250px;
			border-radius: 50%;
			z-index: 4;
			-webkit-transition: all .3s ease;
		}
		
		.center {
			position: absolute;
			top: calc(50% - 10%);
			left: 50%;
			-webkit-transform: translate(-50%, -50%);
			width: 65%;
			z-index: 5;
			-webkit-transition: all .3s ease;
		}
			.center.form-title {
				color: #000;
				font-size: 1.7em;
				text-align: center;
			}
				span {
					color: rgba(0,0,0,0.4);
					opacity: 0;
			    visibility: hidden;
				  -webkit-transition: all .3s ease;
				}
			

			.form-holder {
				border-radius: 15px;
				background-color: #fff;
				border: 1px solid #eee;
				overflow: hidden;
				margin-top: 50px;
				opacity: 1;
				visibility: visible;
				-webkit-transition: all .3s ease;
			}

				.input {
					border: 0;
					outline: none;
					box-shadow: none;
					display: block;
					height: 30px;
					line-height: 30px;
					padding: 8px 15px;
					border-bottom: 1px solid #eee;
					width: 100%;
					font-size: 12px;
				}
					.input:last-child {
						border-bottom: 0;
					}
					.input::-webkit-input-placeholder {
						color: rgba(0,0,0,0.4);
					}
				

			.submit-btn {
				background-color: #6B92A4;
				color: rgba(256,256,256,0.7);
				border:0;
				border-radius: 15px;
				display: block;
				margin: 15px auto; 
				padding: 15px 45px;
				width: 100%;
				font-size: 13px;
				font-weight: bold;
				cursor: pointer;
				opacity: 1;
				visibility: visible;
				-webkit-transition: all .3s ease;
					}

				.submit-btn:hover {
					transition: all .3s ease;
					background-color: rgba(0,0,0,0.8);
				}
			
		
		.submit-btn.slide-up {
			top: 90%;
			-webkit-transition: all .3s ease;
		}
		
		.submit-btn.slide-up .center {
			top: 10%;
			-webkit-transform: translate(-50%, 0%);
			-webkit-transition: all .3s ease;
		}
		
		.submit-btn.slide-up .form-holder,
		.submit-btn.slide-up .submit-btn {
			opacity: 0;
			visibility: hidden;
			-webkit-transition: all .3s ease;
		}
		
		.submit-btn.slide-up .form-title {
			font-size: 1em;
			margin: 0;
			padding: 0;
			cursor: pointer;
			-webkit-transition: all .3s ease;
		}
		
		.submit-btn.slide-up .form-title span {
			margin-right: 5px;
			opacity: 1;
			visibility: visible;
			-webkit-transition: all .3s ease;
		}
</style>
<form name="memberEnrollFrm" method="POST" 
		action ="<%= request.getContextPath()%>/member/memberEnroll">
<div class="form-structor">
	<div class="signup">
		<h2 class="form-title" id="signup"><span>or</span>Sign up</h2>
		<div class="form-holder">
			<input type="text" class="input" placeholder="Id" />
			<input type="password" class="input" placeholder="Password" />
			<input type="password" class="input" placeholder="Password-Check" />
			<input type="text" class="input" placeholder="Name" />
			<input type="date" class="input" placeholder="birthday" />
			<input type="email" class="input" placeholder="Email" />	
			<input type="text" class="input" placeholder="phone" />
		</div>
		<button class="submit-btn">Sign up</button>
	</div>
	<div class="login slide-up">
		<div class="center">
			<h2 class="form-title" id="login"><span>or</span>Log in</h2>
			<div class="form-holder">
				<input type="email" class="input" placeholder="Email" />
				<input type="password" class="input" placeholder="Password" />
			</div>
			<button class="submit-btn">Log in</button>
		</div>
	</div>
</div>

</form>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/memberEnroll.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>