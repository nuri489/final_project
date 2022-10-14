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
<a href="temp_product?product_num=1">일반 판매</a>
<%-- 
?product_num = ${product_num} 이라고 적어야 함.
board/list.jsp 참조. 지금은 그냥 1 값을 직접 줌

 --%>
 <a href="auctionpage?product_num=1">경매 판매</a><br>
 <a href="buyinglist?buyer_num=${sessionUser_num}">구매 목록(로그인 해야됨)</a>
<hr>
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a><br>
로그인한 사람의 user_num : ${sessionUser_num} // 버튼 위치 옮겨야 함
</div>
</body>
</html>