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

	
	if("${sessionUser_num}" == "" || "${sessionUser_num}" == "${temp_dto.user_num}") {
		
		$("#request-form").css("display","none");
	}
	
	if("${temp_dto.user_num}" != "${sessionUser_num}") {
		
		$("#accept-button").css("display","none");
	}
	// 경매요청 및 취소와 경매로 바꾸기 버튼에 대한 표시
		
	$("#request-button").on('click',function(e){
		$.ajax({
			url : 'auction_request',
			data : {'product_num': ${temp_dto.product_num}, 'user_num': "${sessionUser_num}" },
			type : 'post',
			dataType : 'text',
			success : function(s) {
				
				if(${request_num} == s) {
					alert("이미 요청함");
					// 이미 요청했다면 기존의 값과 리턴된 s 값이 같으므로..
				}
				else {
					$("#request-val").html(s);
				}
			}
		});
	});
	// 경매 요청 및 횟수 확인 ajax
	// product_num 값에 대하여 나중에 설정해야 함. 지금은 무조건 1로 줌
	// 마찬가지로 user_num 값에 대해서도 
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
	}
	
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
	
	$("#accept-button").on('click',function(){
		
		if(${request_num} < 1) {
			alert("경매 요청이 5회 이상이어야 경매로 변경 가능합니다");
		}
		else {
			location.replace('request_accepting?product_num=${temp_dto.product_num}');
		}
	});
	// 경매로 바꾸기 버튼에 대한 기능
	
	
	
});
</script>
</head>
<body>
<h1>임시 일반 판매 상품 페이지</h1><hr>
<table>
	<tr><td>글 제목</td><td>${temp_dto.product_title}</td></tr>
	<tr><td>물품 번호</td><td>${temp_dto.product_num}</td></tr>
	<tr><td>판매자 고유번호</td><td>${temp_dto.user_num}</td></tr>
	<tr><td>등록 날짜</td><td>${temp_dto.product_time}</td></tr>
	<tr><td>경매 물품 번호</td><td>${temp_dto.detail_num}</td></tr>
	<tr><td>판매가</td><td>${temp_dto.product_price}</td></tr>
	<tr><td>경매 요청 횟수</td><td><div id="request-val">${request_num}</div></td></tr>
</table><hr>
<form id="request-form">
<input type=button id="request-button" value="경매 요청">
<input type=button id="cancle-button" value="경매 요청 취소"><br>
경매 요청 버튼은 sessionID가 다른 유저한테만 보일 예정. 요청 취소는 요청 했을때만? <hr>
</form>
<input type=button id="accept-button" value="경매로 바꾸기"><br>
게시글 id와 sessionID가 같은 유저한테만 보임. 경매 요청 값이 5 이상이면 활성화(색상을 바꾼던가 해서?)
<hr>
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a><br>
로그인한 사람의 user_num : ${sessionUser_num} // 버튼 위치 옮겨야 함
</div>
</body>
</html>