<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' type='text/css' href='./css/NormalPage.css'>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script src="js/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
		
	}
	
	if("${sessionUser_num}" == "") {
		
		$("#chat-button").on('click',function(){
			event.preventDefault();
			window.location.replace("loginform");
		});
	}
	
	if("${sessionUser_num}" != "${product_dto.user_num}") {
		
		$("#list-button").css('display','none');
	}
	else {
		
		$("#chatting-form1").css('display','none');

		$.ajax({
			url : 'roomchecking',
			data : {'seller_num':"${sessionUser_num}" , 'product_num':${product_dto.product_num}},
			type : 'post',
			dataType : 'text',
			success : function(s) {
				
				if(s == 0) {
					$("#chatting-button2").on('click',function(){
						alert("채팅 목록이 존재하지 않습니다");
						event.preventDefault();
					});
				}
			}
		});
		// 채팅 목록에 대한 ajax
	}
	
	if(${product_dto.product_status1} == 0) {
		$("#statu1").html("개봉여부 : 미개봉");
	}
	else {
		$("#statu1").html("개봉여부 : 개봉");
	}
	
	if(${product_dto.product_status2} == 0) {
		$("#statu2").html("공식여부 : 비공식");
	}
	else {
		$("#statu2").html("공식여부 : 공식");
	}
	
	if(${product_dto.product_status3} == 0) {
		$("#statu3").html("단종여부 : 비단종");
	}
	else {
		$("#statu3").html("단종여부 : 단종");
	}
	if(${product_dto.product_status5} == 0) {
		$("#statu5").html("구성품 포함");
	}
	else {
		$("#statu5").html("구성품 미포함");
	}
	// 상품 상태
	
	if("${product_dto.safe_trade}" == 0) {
		$("#safe-trade").html("불가능");
	}
	else {
		$("#safe-trade").html("가능");
	}
	
	
	var count = ${count};
	// 이미지 갯수
	
	var img = $(".img-list:eq(0)").attr("src");
	$("#main-img").attr("src",img);
	var i;

	
	for(var i=0; i<count; i++) {
		
		$(".img-list:eq("+i+")").on('click',function(){
			var img = $(this).attr("src");
			$("#main-img").attr("src",img);
			$(this).css("border-color","red");
			$(".img-list").not(this).css("border-color","black");
		});
	}
});
</script>
</head>
<body>
<div id="main-div">
	<table id="info-table">
		<tr>
		<td rowspan="6" id="img-td" class="img"><img id="main-img" src="" onerror="this.src=null; this.src='/serverimg/none.png'"></td>
		<td class="head">경매물품</td><td class="info">${detail_name}</td></tr>
		<tr><td class="head">판매자</td><td class="info"><a href="/userreview?user_num=${product_dto.user_num}" id="user-id">${user_id}</a></td></tr>
		<tr><td class="head">물품번호</td><td class="info">${product_dto.product_num}</td></tr>
		<tr><td class="head">경매요청횟수</td><td class="info">${request_num}</td></tr>

		<tr><td class="head">안전거래</td><td class="info"><div id="safe-trade"></div></td></tr>
		<tr>
				<tr><td rowspan="2" class="img">
			    <c:forEach var="image" items="${images}">
				<li><img class="img-list" src="/final/${image}" onerror="this.src=null; this.src='/serverimg/none.png'"></li>
				</c:forEach>
		</td>
		<td class="head" id="statu-td">물품 상태</td>
		<td>
			<table id="statu-table">
				<tr><td id="statu1"></td></tr>
				<tr><td id="statu2"></td></tr>
				<tr><td id="statu3"></td></tr>
				<tr><td id="statu4">상태 : ${product_dto.product_status4}</td></tr>
				<tr><td id="statu5"></td></tr>
			</table>
		</td></tr>
	</table>
	
	<div id="bid-div">

		<table class="bid-table">
			<tr>
			<td>
			<td class="button-td">
			<form action="chatting1" method="post" id="chatting-form1">
				<input type=hidden name="buyer_num" value="${sessionUser_num}">
				<input type=hidden name="seller_num" value="${product_dto.user_num}">
				<input type=hidden name="product_num" value="${product_dto.product_num}">
				<input type=hidden name="auction_check" value="${product_dto.auction_check}">
				<input type=submit id="chat-button" class="chatting-button" value="채팅하기"><br>
			</form>
			<a href="#list-modal" rel="modal:open"><input type=button id="list-button" class="chatting-button" value="채팅목록"></a>
			</td></tr>
		</table><hr>
		<div id="product_contents">
			${product_dto.product_contents}
		</div>
	</div>
</div>
<div id="list-div">
	<div id="list-modal" class="modal">
		<h1>채 팅 목 록</h1><hr id="chat-hr1">
		  <table id="list-table">
			<c:forEach items="${chattinglist}" var="chat" varStatus="status">
			<tr><td class="buyer-name">
			<form action="chatting2" method="post" id="list-form">
			<input type=hidden value="${chat.product_num}" name="product_num">
			<input type=hidden value="${chat.buyer_num}" name="buyer_num">
			<input type=hidden value="${chat.buyer_name}" name="buyer_name">
			<input type=hidden value="${chat.seller_num}" name="seller_num">
			<input type=hidden value="${chat.roomNumber}" name="roomNumber" id="roomNumber">
			<input type=submit value="${chat.buyer_name}" id="go-chat">
			</form></td>
			<td><div id="chat">${chat.last_chat}</div></td></tr>
			</c:forEach>
			</table>
	</div>
</div>
</body>
</html>