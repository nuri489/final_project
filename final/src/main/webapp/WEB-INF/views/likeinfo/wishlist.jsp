<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="/WEB-INF/views/template/header.jsp" />
<meta charset="UTF-8">
<title>찜 목록</title>
<c:forEach items="${dto}" var="dto" varStatus="status">
	<h1>${dto.user_num}</h1>

</c:forEach>
</head>
<body>
	<hr />
	<h2>찜 목록</h2>
	<c:choose>
		<c:when test="${map.count == 0 }">			
        찜 목록 비었습니다.
    </c:when>
		<c:otherwise>						
			<table border="1" style="width: 100%;">			
										
				<tr><th style="text-align: left; vertical-align: middle;">상품명 : </th></tr>
				<tr><th style="text-align: left; vertical-align: middle;">수량 : </th></tr>
				<tr><th style="text-align: left; vertical-align: middle;">총 금액 : </th></tr>										
					<c:forEach var="row" items="${map.list}">
						<tr>
							<td>${row.product_name}</td>
							<td><fmt:formatNumber value="${row.price}"
									pattern="#,###,###" /></td>							
							<td><input type="number" name="amount" style="width: 30px;"
								value="<fmt:formatNumber value="${row.amount}"
                            	pattern="#,###,###" />">										
							</td>											
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6" align="left">찜 목록 금액 합계 : <fmt:formatNumber
								value="${map.sumMoney}" pattern="#,###,###" /><br>
								배송료 :${map.fee}<br>
								총합계 : <fmt:formatNumber value="${map.sum}" pattern="#,###,###" />
						</td>
					</tr>
				</table>
				<button type="button" id="btnDelete">비우기</button><hr>					
		</c:otherwise>
	</c:choose>
</body>
</html>
