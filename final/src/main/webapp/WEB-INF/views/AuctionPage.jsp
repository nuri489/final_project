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
	
	if("${sessionUser_num}" != "${dto2.user_num}") {
		
		$.ajax({
			url : 'my_bid',
			data : {'auction_num': ${dto1.auction_num} , 'user_num':${sessionUser_num}},
			type : 'post',
			dataType : 'text',
			success : function(s) {
				if(s == 0) {
					$("#my-bid").html("");
				}
				else {
					$("#my-bid").html(s+"원");
				}
			}
		});
	}
	else {
		$("#my-bid").html("내 경매 상품입니다.");
	}
	
	
	

	if(${dto1.auction_method} == 1) {
		$("#auction-method").html("비공개(비딩)");
		
		$("#final_price").html("비공개");
		$("#bid-unit").html("1호가");
		
		$("#bid-button").on('click',function(){
			
			if("${sessionUser_num}" == "${dto2.user_num}") {
				
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else {
					var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
						
					if(really) {
						
						$.ajax({
							url : 'private_bid',
							data : {'auction_num': ${dto1.auction_num} , 'user_num':${sessionUser_num} , 'bid_price':$("#bid-price").val() , 'product_num':${dto1.product_num}},
							type : 'post',
							dataType : 'text',
							success : function(s) {
								
								if(s == 0) {
									
									var really = confirm("보유 머니가 부족합니다! 충전하시겠습니까?");
									
									if(really) {
										window.location.replace("temp_main");
										// 보유 머니 충전 페이지로 바꾸자@@@@@@@@@@@@@@@@@@@@@@@@@@@@
									}
									else { }
			
								}
								// 충전머니 부족할 때
								else if(s == 1) {
									alert("상위 입찰 완료")	
								}
								// 이미 입찰함
								else if(s == 3) {
									alert("이전 입찰 금액보다 낮은 금액으로 입찰하실 수 없습니다.");
								}
								else {
									alert("입찰 완료");
								}
								// 입찰 완료
							}
						});
					}
					else {	}
			}
		});
	}
	else if(${dto1.auction_method} == 0) {
		
		$("#auction-method").html("공개");
		
		$("#bid-button").on('click',function(){
			
			
			if(${sessionUser_num} == ${dto2.user_num}) {
				
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else {
					var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
						
					if(really) {
						
						$.ajax({
							url : 'open_bid',
							data : {'auction_num': ${dto1.auction_num} , 'user_num':${sessionUser_num} , 'bid_price':$("#bid-price").val(), 'product_num':${dto1.product_num}},
							type : 'post',
							dataType : 'text',
							success : function(s) {
								
								if(s == 0) {
									
									var really = confirm("보유 머니가 부족합니다! 충전하시겠습니까?");
									
									if(really) {
										window.location.replace("temp_main");
										// 보유 머니 충전 페이지로 바꾸자@@@@@@@@@@@@@@@@@@@@@@@@@@@@
									}
									else { }
			
								}
								// 충전머니 부족할 때
								else if(s == 1) {
									alert("고객님의 입찰이 가장 최신 입찰 입니다.")
									
								}
								// 이미 입찰하였고, 아직 최고가가 경신 안됨
								else {
									alert("입찰 완료");
								}
								// 입찰 완료
							}
						});
					}
					else {	}
			}
		});
	}	
});
</script>
</head>
<body>
<h1>경매장 페이지</h1><hr>
<table border="2">
<tr><td>물품번호</td><td>${dto1.product_num}</td></tr>
<tr><td>경매번호</td><td>${dto1.auction_num}</td></tr>
<tr><td>판매자</td><td>${user_id}</td></tr>
<tr><td>경매기간</td><td>${dto1.end_time} 까지 + 남은 시간</td></tr>
<tr><td>경매물품</td><td>${detail_name}</td></tr>
<tr><td>입찰방식</td><td><div id="auction-method"></div></td></tr>
<tr><td>입찰 수</td><td><input type=button id="bid_detail" value="경매기록보기"></td></tr>
</table><br>
<table border="2">
<tr><td>시작가</td><td>${dto2.product_price}원</td></tr>
<tr><td><div id="bid-unit">입찰단위</div></td><td>${dto1.bid_unit}원</td></tr>
<tr><td>현재가격</td><td><div id="final_price">${dto1.final_price}원</div></td></tr>
<tr><td>내 제시가</td><td><div id="my-bid"></div></td></tr>
<tr><td>입찰금액</td><td><input type=number step=1000 id="bid-price" name="bid_price" min="${dto1.final_price}" value="${dto1.final_price}"></td></tr>
<tr><td colspan="2"><input type="button" id="bid-button" value="입찰하기"></td></tr>
</table>
</body>
</html>