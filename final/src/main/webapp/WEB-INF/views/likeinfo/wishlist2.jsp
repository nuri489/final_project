<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../template/header.jsp" flush="true"/>
<link rel='stylesheet' type='text/css' href='./css/wishlist2.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" == "") {
		window.location.replace("getproducts");
	}
	
	
	$('#cancle-button').on('click',function(e){
		
		var tg =  $(this).html();
			$.ajax({
				url:'unlikeclickajax',
				data: {'product_num' : $(this).val()},
				type:"get",
				dataType:'json',
				success:function(server){
					alert("취소되었습니다");
					window.location.reload();
					//alert(server.result);
				}//success end
			}); //ajax end	
	});
});
</script>
</head>
<body>
<table id="wish-table">
	<tr><td colspan="5" id="wish-title">찜 목 록</td></tr>
	<tr><td class="head">제품번호</td><td class="head">판매자</td><td class="head">제목</td><td class="head">가격</td><td class="head">찜 취소</td></tr>
		<c:forEach items="${dto}" var="dto" varStatus="status">
			<tr>
			<td class="wish-td1">${dto.product_num}</td>
			<td class="wish-td2"><a href="/userreview?user_num=${dto.user_num}" class="wish-a1">${dto.user_name}</a></td>
			<td class="wish-td3"><a href="productdetail?product_num=${dto.product_num}" class="wish-a2">${dto.product_title}</a></td>
			<td class="wish-td4">${dto.product_price}</td>
			<td class="wish-td5"><button id="cancle-button" value="${dto.product_num}">X</button></td>
			</tr>
</c:forEach>
</table>
</body>
</html>
