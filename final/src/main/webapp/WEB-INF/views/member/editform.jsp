<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<link rel='stylesheet' type='text/css' href='./css/editform.css'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" == "") {
		window.location.replace("getproducts");
	}
	

	$("#edit-button").on('click',function(){
		
    	$.ajax({
			url: "editdone",
			type: "post",
			data: {'user_num' : "${sessionUser_num}", 'user_name':$("#user_name").val(), 'user_email':$("#user_email").val(), 'user_tel':$("#user_tel").val()},
			success: function(e){		
				
				alert(e);
			}
		});
	});
	
	
	$("#button2").on('click',function(){

			
		$.ajax({
			url : 'passwordChange1',
			data : {'user_id':"${dto.user_id}" ,'user_email':"${dto.user_email}"},
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				
				$("#check2").html("이메일로 인증번호가 발송되었습니다");
				$("#key1").attr("value", s);
				$("#key2").focus();
		
			}
		});
	});
	
	$("#button3").on('click',function(){
		
		if($("#key1").val() != "") {
			if($("#key1").val() == $("#key2").val()) {
				
				if($("#password-change").val() != "") {
					$.ajax({
						url : 'passwordChange2',
						data : {'user_num':"${sessionUser_num}" , 'user_password':$("#password-change").val()},
						type : 'post',
						dataType : 'text',
						success : function(s) {
							
							$("#check2").html("비밀번호 변경이 완료되었습니다");
							
						}
					});	
				}
				else {
					$("#check2").html("변경하실 비밀번호를 입력하세요");
					$("#password-change").focus();
				}
				
			}
			else {
				$("#check2").html("인증번호가 일치하지 않습니다");
				$("#key2").focus();
			}
		}
		else {
			$("#check2").html("인증번호를 먼저 발급 받아야 합니다");
		}
	});
	

});
</script>
</head>
<body>
<table id="edit-table">
	<tr><td colspan="2" id="title">회원정보 수정</td></tr>
	<tr><td class="head">아이디</td><td class="child">${dto.user_id}</td></tr>
	<tr><td class="head">비밀번호</td><td class="child"><a href="#password-modal" rel="modal:open">비밀번호 수정은 인증이 필요합니다</a></td>
	<tr><td class="head">닉네임</td><td class="child"><input type=text value="${dto.user_name}" id="user_name"></td></tr>
	<tr><td class="head">이메일</td><td class="child"><input type=email value="${dto.user_email}" id="user_email"></td></tr>
	<tr><td class="head">전화번호</td><td class="child"><input type=tel value="${dto.user_tel}" id="user_tel"></td></tr>
</table>
<input type=button value="수정완료" id="edit-button">

<div id="password-modal" class="modal">
	<table class="password-table" id="password-table1">
		<tr><td class="modal-head"><input type="text" id="user_email2" value="${dto.user_email}" readonly="readonly"></td>
		<td rowspan="3" class="modal-child"><input type=button value="이메일로 인증번호 전송" id="button2" class="button"></td></tr>
	</table>

	<table class="password-table" border="2" id="password-table2">
	<tr><td class="modal-head"><input type=hidden id="key1"><input type=text id="key2" class="input" placeholder="인증번호를 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='인증번호를 입력하세요'"></td>
	<td rowspan="2" class="modal-child"><input type=button id="button3" class="button" value="인증 및 비밀번호 변경"></td>
	<tr><td class="modal-head"><input type=text id="password-change" placeholder="변경하실 비밀번호를 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='변경하실 비밀번호를 입력하세요'"></td></tr>
	</table>
	<div id="check2">인증번호를 발급받고 비밀번호를 변경하세요</div>
</div>
</body>
</html>