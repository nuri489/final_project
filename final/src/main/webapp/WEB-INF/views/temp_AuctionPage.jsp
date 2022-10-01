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

	$("#confirm-button").on('click',function(){
			
		if($("#auction-time").val() > 36 || $("#auction-time").val() < 12) {
			
			alert("시간 제대로 설정하셈 >> 나중에 말풍선으로 교체");
		}
		
		else {	
			var really = confirm("경매로 변경하시겠습니까? 다시 일반 판매로 변경하실 수 없습니다.");
			
			if(really) {
				$("#auction-form").attr('action','request_accepted').submit();
			}
			else {	
			}
		}
	});
	// 경매로 바꾸기 버튼에 대한 기능

	$("#cancle-button").on('click',function(){
		location.replace('temp_product?product_num=${dto.product_num}');
	});
	
	
	/* 
	request_accepted로 넘어가야 할 값은?
	1. auction_check 값을 1로 바꿔야 하므로 product_num
	2. auction_info 테이블에 여러가지 값 넘거야 하므로 dto ?
		-> dto는 해당 컨트롤러 안에서 불러올 수 있으므로 굳이 jsp에서 직접 안넘겨줘도 됨?
		-> (product_num , end_time , bid_unit , auction_method)
	*/

});
</script>
</head>
<body>
<h1>경매 설정 페이지</h1>
<form id="auction-form" method="get">
	<table border="1">
		<tr><td>물품번호</td><td><input type="text" name="product_num" value="${dto.product_num}" readonly style="border:none"></td></tr>
		<tr><td>판매자</td><td><input type="text" value="${user_id}" readonly style="border:none"></td></tr>
		<tr><td>경매시간</td><td><input type="number" name="end_time" value=12 min=12 max=36 step=1 pattern="[12-36]+" id="auction-time" title="경매 시간은 최소 12시간에서 최대 36시간입니다"></td></tr>
		<tr><td>경매물품</td><td>${detail_name}</td></tr>
		<tr><td>시작가</td><td><input type="text" name="final_price" value="${dto.product_price}" readonly style="border:none"></td></tr>
		<tr><td>입찰단위</td><td>
			<select id="bid_unit" name="bid_unit">
				<option value="1000">1,000원</option>
				<option value="2000">2,000원</option>
				<option value="3000">3,000원</option>
				<option value="4000">4,000원</option>
				<option value="5000">5,000원</option>
				<option value="6000">6,000원</option>
				<option value="7000">7,000원</option>
				<option value="8000">8,000원</option>
				<option value="9000">9,000원</option>
				<option value="10000">10,000원</option>
			</select>
		</td></tr>
		<tr><td>입찰방식</td><td>
			<select id="auction-method" name="auction_method">
				<option value=0>공개</option>
				<option value=1>비공개*</option>
			</select>
		</td></tr>
	</table><br>
	<input type=button id="confirm-button" value="경매로 전환하기">
	<input type=button id="cancle-button" value="취소">
	<input type=number name="user_num" value="${dto.user_num}" hidden="true">
</form>
<div>
비공개* 경매는 비딩 방식으로 진행 됩니다.<br>
가장 높은 금액을 제시한 입찰자가 낙찰되며, 최종 낙찰가는 2순위 입찰자가 제시한 금액 + 판매자가 설정한 입찰단위 금액입니다.<br>
단, 최종 낙찰가는 1순위 입찰자가 제시한 금액보다 커질 수 없습니다.<br>
경매가 종료되고 제시 금액과 최종 금액의 차액만큼 자동으로 환불처리가 됩니다.<br>
예) 1순위는 5만원, 2순위는 4만원을 제시하였고 입찰단위가 3천원이라면 1순위 제시자는 4만3천원을 지불해야 합니다.<br>
1순위가 입찰을 하며 차감된 5만원 중, 7천원은 자동 환불됩니다.
</div>
</body>
</html>