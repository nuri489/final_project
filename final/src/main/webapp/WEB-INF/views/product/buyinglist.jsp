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

});
</script>
</head>
<body>
<h1>구매목록</h1>
<table id="table1">

</table>
<h2>${buyinglist}</h1><hr>
<c:forEach items="${buyinglist}" var="dto1" varStatus="status">
	<c:forEach items="${thumbnail}" var="dto2" varStatus="status">
	${dto1.product_title}<br>
	${dto2.image_path }<br>
	</c:forEach>
</c:forEach>
</body>
</html>