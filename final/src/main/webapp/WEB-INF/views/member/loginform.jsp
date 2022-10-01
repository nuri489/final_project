<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
$("#login-button").on('click',function(e){
	
	var ref = document.referrer;
		
		$.ajax({
			url : 'login',
			data : {'id':$("#id").val() , 'password':$("#password").val()},
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				
				if(s==1) {
					window.location.href = ref;
				}
				else {
					alert("아이디 또는 비밀번호가 옳지 않습니다.");
				}
				
			}
		});
	});
	// 로그인 버튼에 대한 ajax

});
</script>
</head>
<body>
<h1>로그인 폼</h1>
<form action="">
<input type=text id="id" placeholder="아이디를 입력하시오"><br>
<input type=password id="password" placeholder="비밀번호를 입력하시오"><br>
<input type=button id="login-button" value="로그인">
</form>
</body>
</html>