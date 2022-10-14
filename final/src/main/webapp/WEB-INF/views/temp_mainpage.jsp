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
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
	}
	// 로그인 및 로그아웃 버튼에 대한 표시
	
	$("#logout-button").on('click',function(e){
		
		$.ajax({
			url : 'logout',
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				location.reload();
			}
		});
	});
	// 로그아웃 버튼에 대한 ajax


});
</script>
</head>
<body>
경매 확인용 메인 페이지<br>
<a href="productdetail_normal">일반 판매</a>
<a href="productdetail_auction">경매 판매</a>
<a href="sellproductlist">판매글모아보기</a>
<hr>
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a><br>
로그인한 사람의 user_num : ${sessionUser_num} // 버튼 위치 옮겨야 함
</div>
</body>
</html>