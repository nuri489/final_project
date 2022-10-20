<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script src="resources/js/jquery-3.6.0.min.js"></script>
<style type="text/css">
	table {
		width: 40%;
		border-top: 1px solid #444444;
		border-collapse: collapse;
		margin: auto;
	}
	
	th, td {
		border-bottom: 1px solid #444444;
		padding: 10px;
	}
	
	.d-flex {
		display: flex;
	}
	
	.ml-15 {
		margin-left: 15px;
	}
</style>
</head>
<body>
	<div class="d-flex">
		<h3>마이페이지</h3>
		<h3 class="ml-15"><a href="/wish/${user.user_num}">찜목록</a></h3>
		<h3 class="ml-15"><a href="#">판매내역</a></h3>
		<h3 class="ml-15"><a href="#">판매내역</a></h3>
	</div>
	<div>
		<div>
			<div>${user.user_id}(${user.user_name})</div>
			<div>보유머니 : ${user.user_money}</div>
			<div>연락처 : ${user.user_tel}</div>
			<div>이메일 : ${user.user_email}</div>
		</div>
	</div>	
</body>
</html>