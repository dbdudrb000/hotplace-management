<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>


<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/login.css">

</head>

<body bgcolor = "#ff7f00">
<form name = "loginform" action = "loginLogic" method="post">
	<div align = "center" style = "color: #00FFFF ;"	>
		<caption><h1>로그인페이지</h1></caption>
	</div>
	<table align = "middle">
	<div class="login">
    	<input type="text" placeholder="email 입력" id="email" name="email">  
 	    <input type="password" placeholder="password 입력" id="password" name="password">  
 			 <a href="#" class="forgot">사랑합니다 고객님</a>
 	 	<input type="button" value="로그인" onclick = "login()">
 	 	<input type = "button" value = "회원가입" onclick = "location.href = '/joinView'">
 		<input type = "button" value = "메인으로" onclick = "location.href = '/kakao'">
	</div>
		
<div class="shadow"></div>
</table>
</form>

<script>
	function login(){
		var email = document.getElementById("email").value;
		var pw = document.getElementById("password").value;
		
		if(email=="" || pw ==""){
			alert("아이디혹은 비밀번호를 입력해주세요.");
		}else{						
			loginform.submit();		
		}		
		
	}
</script>

</body>

</html>

