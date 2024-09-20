<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<html>
<head>
<title>WebSocket Chat</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@300..700&family=Hi+Melody&family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

<!-- <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">				for english
 -->
 <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet"> <!-- for korean -->

<script>
	var webSocket; 
	var chatWindow, chatMessage, chatId;
		
	window.onload=function(){
		chatWindow=document.getElementById("chatWindow");
		chatMessage=document.getElementById("chatMessage");
		chatId=document.getElementById('chatId').value;

		webSocket = new WebSocket("ws://192.168.182.1:8181/ChatingServer"); 

		webSocket.onopen=function(event){
			chatWindow.innerHTML +="<div class='system-msg'>Enjoy the conversation<br>Whisper: /w username message</div>";
		}
		webSocket.onclose=function(event){
			chatWindow.innerHTML +="<div class='system-msg'>You have been disconnected from the chat room.</div>";
		}
		webSocket.onerror = function(event){
			alert(event.data);
			chatWindow.innerHTML +="<div class='system-msg'>An error occurred during the chat.<div>";
		}
		webSocket.onmessage = function(event){
			var message = event.data.split("|");
			var sender = message[0];
			var content = message[1];
			if (content != "") {
				if(content.match(/^\/w\s+/i)){
					if(content.match(new RegExp("^\/w\\s"+chatId+"\\s+","i"))){
						var temp = content.replace("/w "+chatId, "<b>[Whisper] </b>");
						chatWindow.innerHTML += "<div class='chat-msg whisper'><b>"+sender+"</b>: "+temp+"</div>";
					}
				} else {
					chatWindow.innerHTML += "<div class='chat-msg'><b>"+sender+"</b>: "+content+"</div>";
				}
			}
			chatWindow.scrollTop = chatWindow.scrollHeight;
		}
	}
	
	function sendMessage(){
		if(chatMessage.value == "") return;
		chatWindow.innerHTML += "<div class='my-msg'>" + chatMessage.value+ "</div>";
		webSocket.send(chatId + '|' + chatMessage.value);
		chatMessage.value = "";
		chatWindow.scrollTop = chatWindow.scrollHeight;
	}
	
	function disconnect(){
		webSocket.close();
	}
	
	function enterKey() {
		if(window.event.keyCode == 13) sendMessage();
	}

</script>
<style> 
    body {
   		background: url('img/KAKAOBG.png') no-repeat center center;
   		background-size:cover;
   		height:450px;
   		font-family: "Shantell Sans", cursive; /*for english*/
     	font-family: "Hi Melody", sans-serif !important;  /*for korean*/
  		font-size:30px;
        
    }
 	#chatWindow {
		width: 100%;
		height:100%;
		background-size:contain;
		overflow-y: scroll;
		background: url('') no-repeat center center; 
		background-size: contain; 
		padding: 15px;
		border-radius: 10px;
		border:none;
	} 

	.system-msg {
		text-align: center;
		color: gray;
		font-size: 17px;
		margin: 10px 0;
	}

	.chat-msg {
		display: block;
		background-color: #fff;
		border-radius: 10px;
		padding: 6px;
		margin: 5px 0;
		max-width: 60%;
		clear: both;
		border: 2px solid #FFD63B;
		font-size:17px;
	}

	.whisper {
		background-color: #FFAC73;
		border:none;
		color:white;
	}

	.my-msg {
		display: block;
		background-color: rgba(255,214,59,0.6);
		border-radius: 10px;
		padding: 6px;
		margin: 5px 0;
		max-width: 60%;
		clear: both;
		text-align: right;
		float: right;
		font-size:17px;
	}
	#sendBtn {
	    background-color: #FFD63B; 
	    color: #3F3F3F; 
	    border: none;
	    border-radius: 10px;
	    padding: 10px;
	    transition: all 0.3s ease; 
	    box-shadow: 2px 3px 4px rgba(255, 172, 115, 0.8); 
	}

	#sendBtn:hover {
	    background-color: #FBC02D; 
	    transform: translateY(-5px); 
	    box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.5); 
	    transition: 0.3s ease;
	}
	
	#sendBtn:active {
	    transform: translateY(0); 
	    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); 
	}
	#chatMessage {
	    border: 2px solid #FFD63B; 
	    border-radius: 10px; 
	    transition: border-color 0.3s ease, box-shadow 0.3s ease; 
	    font-size:20px;
	}

	#chatMessage:hover {
	    border-color: rgb(108, 193, 255);
	    box-shadow: 0 4px 5px rgba(108, 193, 255, 0.5); 
	}
	
	#chatMessage:focus {
	    border-color: #2995E3; 
	    box-shadow: 0 0 5px rgba(159, 191, 208, 0.8); 
	    outline: none; 
	}
	.chatId{
		color:#6474D9;
  		font-family: "Fira Code", monospace;
  		font-family: "Hi Melody", sans-serif !important;  /*for korean*/
  		
	}
	.chat{
		margin-left:70px !important;
	}
	#closeBtn{
		border: 1px solid rgba(23, 118, 168, 0.8);
		border-radius:10px;
	}
	#closeBtn:hover{
		border-color: #2995E3; 
	    box-shadow: 0 5px 5px rgba(159, 191, 208, 0.8);
	    outline:none;
	}
	#closeBtn:focus {
	    border-color: #2995E3;
	    background-color:rgba(108, 193, 255, 0.5); 
	    box-shadow: 0 0 5px rgba(159, 191, 208, 0.8);
	    outline: none;
</style>
</head>
<body>
	<div class="input-group d-flex justify-content-between mt-4 px-3">
	    <div><input type="hidden" id="chatId" value="${param.chatId }"></div>
	    <div class="chat"><span class="chatId">${param.chatId}</span><span style="font-size:17px;">'s chat room</span></div> 
		<button id="closeBtn" class="btn" onclick="disconnect();">Disconnect</button>
	</div>
	
	<div id="chatWindow" class="form-control mx-auto mt-0 py-2">
	</div>
	
	<div class="input-group justify-content-end mt-1 px-4">
		<input type="text" id="chatMessage" class="form-control onkeyup="enterKey();" placeholder="kind and lovely words">
		<button id="sendBtn" class="btn" onclick="sendMessage();" style="width:18%;">
			<i class="fa-solid fa-location-arrow"></i>
		</button>
	</div>
</body>
</html>
