<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../template/header.jsp" flush="true"/>
<link rel='stylesheet' type='text/css' href='./css/buyinglist.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" == "") {
		window.location.replace("getproducts");
	}

});
</script>
</head>
<body>
<table>
	<tr><td>제품번호</td><td>판매자</td><td>제목</td><td>가격</td></tr>
		<c:forEach items="${dto}" var="dto" varStatus="status">
			<tr><td>${dto.product_num}</td><td><a href="">${dto.user_name}</a></td><td><a href="">${dto.product_title}</a></td><td>${dto.product_price}</td></tr>
</c:forEach>
</table>
</body>
</html>