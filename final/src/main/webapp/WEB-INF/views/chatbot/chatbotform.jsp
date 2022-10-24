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
$(document).ready(function(){
	var now = new Date();
	var date = now.getFullYear()+"."+(now.getMonth()+1)+"."+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
	$.ajax({
		url:'chatbotresultajax',
		data: {'request' : $("#input_message").val() , 'event': 'open' },
		type:"get",
		dataType:'json',
		success:function(server){
			var welcome_msg = server.bubbles[0].data.description;
			welcome_msg = welcome_msg.replace(/\n/gi, '<br>');
/* 			alert(welcome_msg);
 */			$('#chatbot_message').html("<div class='msg_box'><div id='sender'><div id='sender_text'>"+welcome_msg+"</div><div class='msg_time'>"+date+"</div></div></div>");
			
		}//success end
	}); //ajax end	
	
	$('#sendbtn').on('click',function(event){
		var now = new Date();
		var date = now.getFullYear()+"."+(now.getMonth()+1)+"."+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
		$.ajax({
			url:'chatbotresultajax',
			data: {'request' : $("#input_message").val() , 'event': $(this).val() },
			type:"get",
			dataType:'json',
			success:function(server){
				/* alert(server); */
				var input_msg = $('#input_message').val();
				var result_msg = server.bubbles[0].data.description;
				$('#chatbot_message').append("<div class='msg_box'><div id='reciever'><div id='reciever_text'>"+input_msg+"</div></div><div class='msg_time' id='msg_time_r'>"+date+"</div></div>");
				$('#input_message').val("");
				//시세 확인할래 질문받을 시
				if(input_msg.includes('시세확인')||input_msg.includes('시세 확인')||input_msg.includes('시세')){
					result_msg = '';
					$.ajax({
						url:'quotecheck',
						data: {'detail_name' : input_msg},
						type:"get",
						dataType:'json',
						success:function(server){
							result_msg = '해당 물품의 현재 시세는 ';
							result_msg+=server+'원 입니다.';
							//var welcome_msg = server.bubbles[0].data.description;
							//welcome_msg = welcome_msg.replace(/\n/gi, '<br>');
				 			$('#chatbot_message').append("<div class='msg_box'><div id='sender'><div id='sender_text'>"+result_msg+"</div><div class='msg_time'>"+date+"</div></div></div>");
				 			$('#chatbot_message').scrollTop($('#chatbot_message')[0].scrollHeight);
			           		$('#chatbot_message').animate({
			            		scrollTop: $('#chatbot_message')[0].scrollHeight
			           		}, 4000);
							
						}//success end
					}); //ajax end	
				}
				//현재 판매중인 아이돌 굿즈 10개 가져오기
				if(result_msg.includes('현재 판매중인')){
					var idol_name = server.bubbles[0].slot[0].value;
					var category_name= server.bubbles[0].slot[1].value;
					$.ajax({
						url:'forsale',
						data: {'idol_name' : idol_name , 'category_name': category_name },
						type:"get",
						dataType:'json',
						success:function(server){
							var forsale_msg = "";
							for(let i=0;i<server.length;i++){
								forsale_msg+=(i+1)+". "+server[i]+"<br>";
							}
							$('#chatbot_message').append("<div class='msg_box'><div id='sender'><div id='sender_text'>"+forsale_msg+"</div><div class='msg_time'>"+date+"</div></div></div>");
						}//success end
					}); //ajax end	
					
				}
				result_msg = result_msg.replace(/\n/gi, '<br>');
				if(result_msg!=""){
					$('#chatbot_message').append("<div class='msg_box'><div id='sender'><div id='sender_text'>"+result_msg+"</div></div><div class='msg_time'>"+date+"</div></div>");
					/* $('#chatbot_message').scrollTop($('#chatbot_message')[0].scrollHeight); */
					$('#chatbot_message').scrollTop($('#chatbot_message')[0].scrollHeight);
	           		$('#chatbot_message').animate({
	            		scrollTop: $('#chatbot_message')[0].scrollHeight
	           		}, 4000);
				}
			}//success end
		}); //ajax end	
	}); //sendbtn click end
	
/* 	$('#nav_btn').on('click',function(){
		$('#chatbot_item1').css("display","none");
		$('#chatbot_item2').css("display","block");
	}); //nav btn end
	
	$('#nav_back_btn').on('click',function(){
		$('#chatbot_item1').css("display","block");
		$('#chatbot_item2').css("display","none");
	}); //nav back btn end */
	
	
});//ready end
</script>
<style type="text/css">

</style>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
#chatbot_contents{
	position: relative;
	display: flex;
	flex-flow: column;
	width: 100%;
	height: 80vh;
	align-items:center;
	justify-content:center;
	/* border: 1px solid black; */
	padding: 20px 0 20px 0;
}
#chatbot_box{
	position: relative;
	display: flex;
	flex-flow: column;
	width: 450px;
	height: 100%;
	align-items:center;
	justify-content:space-between;
	/* border: 1px solid black; */
	border-radius: 0 0 8px 8px;
	background-color: #f0f2f6;
}
#chatbot_message{
	position:relative;
	display:flex;
	flex-flow:column;
	/* border: 1px solid black; */
	/* height: 90%; */
	width: 410px;
	padding: 15px;
	/* text-align: center; */
}
#chatbot_message #sender{
	position:relative;
	display:flex;
	flex-flow:column;
	align-content:flex-start;
	flex-wrap:wrap;
	/* text-align:left; */
	/* padding:2px 5px 2px 5px; */
	/* min-height: 25px; */
	/* max-width:300px; */
	/* flex-wrap:wrap; */
	/* border: 1px solid black; */
}
#chatbot_message #sender #sender_text{
	display:flex;
	flex-flow:column; 
	word-break: break-word;
	min-height:25px;
	max-width:260px;
	/* border: 1px solid black; */
	padding:7px 10px 2px 10px;
	/* padding:12px 10px 2px 10px; */
	border-radius: 8px; 
	background-color: white;
}
#chatbot_message #reciever{
	/* display:inline; */
	position:relative;
	display:flex;
	flex-flow:column;
	/* justify-content:flex-end; */
	align-content:flex-end;
	text-align:right;
	/* padding:2px 5px 2px 5px; */
	flex-wrap:wrap;
	border-radius: 8px; 
	/* border: 1px solid black; */
	margin: 10px 0 2px 0;
}
#chatbot_message #reciever #reciever_text{
	display:flex;
	flex-flow:column wrap;
	word-break: break-word;
	min-height:25px;
	max-width:300px;
	padding:7px 10px 2px 10px;
	border-radius: 8px; 
	/* border: 1px solid black; */
	background-color: #ced6f7;
	
}
#chatbot_input_box{
	/* border: 1px solid black; */
	background-color:#a2b1f1;
	height: 50px;
	width: 100%;
	padding: 5px 0 0 0;
	text-align:center;
	align-items:center;
	border-radius: 0 0 8px 8px;
}
#chatbot_input_box #input_message{
	margin:4px 0 0 2px;
	width: 378px;
	height: 30px;	
	border-radius: 8px;
	padding-left:5px;
	border:none;
}
#chatbot_input_box #sendbtn{
	margin:2px 4px 0 0;
	width: 50px;
	height: 35px;
	background-color: #5C75E6;
	border: 1px solid #5C75E6;
	border-radius: 8px;
	color: white;
}
#chatbot_input_box #sendbtn:hover{
	cursor:pointer;
	background-color:  #6973db;
}
@keyframes fadeInUp {
        0% {
            opacity: 0;
            transform: translate3d(0, 100%, 0);
        }
        to {
            opacity: 1;
            transform: translateZ(0);
        }
}
.msg_box {
    position: relative;
    animation: fadeInUp 1.5s;
}
.msg_time{
	/* border:1px solid black; */
	margin-top:2px;
	font-size: 14px;
	color: #a2b1f1;
}
#msg_time_r{
	margin-top:0px;
	text-align: right;
	margin-bottom: 10px;
}
#chatbot_nav{
	width:450px;
	height:30px;
	background-color:#a2b1f1;
	border-radius:8px 8px 0 0 ;
/* 	border:1px solid black; */
	
}
#chatbot_nav #nav_btn, #nav_back_btn{
	height: 30px;
	border-radius:8px 0 0 0;
	background-color: #5C75E6;
	border: 1px solid #5C75E6;
	color: white;
	display: none;
}
</style>
<body>
<div id="chatbot_contents">
	<div id="chatbot_title" style="margin-bottom: 20px;">간단한 질문은 챗봇을 통해 해결해보세요! </div>
	<div id="chatbot_item1">
	<div id="chatbot_nav"><button id="nav_btn">시세확인</button></div>
	<div id="chatbot_box">
		<div id="chatbot_message" style="overflow-y: scroll; height:550px;">
			<!-- <div id="sender"><div id="sender_text">안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요
				</div>
				
			</div>
			<div id="reciever"><div id="reciever_text">반갑습니다.</div></div> -->

		</div>
		<div id="chatbot_input_box">
			<input id="input_message" type="text" name="input_message">
			<button id="sendbtn" value="input_message">전송</button>
		</div>
	</div>
	</div>
	
</div>
</body>
</html>