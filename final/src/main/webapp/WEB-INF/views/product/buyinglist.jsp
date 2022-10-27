<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/buyinglist.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {


});
</script>
</head>
<body>
<jsp:include page="../template/header.jsp" flush="true"/><hr>
<h1>구매목록</h1>
<table id="list-table">
<tr><td class="head">상품번호</td><td class="head">제목</td><td class="head">판매자</td><td class="head">가격</td></tr>
<c:forEach items="${buyinglist}" var="product_dto" varStatus="status">
<tr>
<td>${product_dto.product_num}</td>
<td><a href="productdetail?product_num=${product_dto.product_num}" class="a">${product_dto.product_title}</a><div class="img-div"><img class="thumbnail" src="${product_dto.image_path}" onerror="this.src=null; this.src='/serverimg/none.png'"></div></td>
<td><a href="" class="a">${product_dto.user_name}</a></td>
<td>${product_dto.product_price}원</td></tr>
</c:forEach>
</table>
<script src='./js/buyinglist.js'></script>
</body>
</html>