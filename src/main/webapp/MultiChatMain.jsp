<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Hi+Melody&family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet"> <!-- for korean -->
<link href="https://fonts.googleapis.com/css2?family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@300..700&family=Hi+Melody&family=Lobster&family=Shantell+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>WebSocket Chat</title>
<style>
body{
	background-color:#D8ECFA;
	font-family: "Hi Melody", sans-serif ;  /*for korean*/
	font-family: "Shantell Sans", cursive; 
}
.talkcontainer{
	position:relative;
	width:80%;
}
.ryan{
	position:absolute;
	left:400px;
	top:400px;
}
.talktalk img{
	position:absolute;
	left:1120px;
	top:110px;
	width:300px;
}
h2{
	position:absolute;
	left:1150px;	
	margin-top:65px;
	width:270px;
	color:#9BA4DE;
}

#chatID{
	margin-left:950px;
	margin-top:410px;
	width:305px;
	position:absolute;
	font-size:20px;
}

container{
	margin-top:25%;
	margin-left:60%;
	position:relative;
}
button{
	margin-left:1130px;
	margin-top:410px;
	position:absolute;
	background-color:#94D5F3 !important;
	color:#fff !important;
	width:125px;
	font-size:20px !important;
}
button:hover{
    transform: translateY(-3px); 
    border-color: #2995E3; 
    box-shadow: 0 5px 5px rgba(159, 191, 208, 0.8);
    outline:none;
}
button:focus{
	border-color: #2995E3;
    background-color:rgba(108, 193, 255, 0.5) !important; 
    outline: none;
}
</style>
</head>
<body>
	<script>
	function chatWinOpen(){
		var id= document.getElementById("chatID");
		if (id.value==""){
			alert("Please enter your username to open the chat window.");
			id.focus();
			return;
		}
		if (id.value.length>10){
			alert("The username can be up to 10 characters long.");
			id.focus();
			return;
		}
		window.open("ChatWindow.jsp?chatId="+id.value,"","width=400,height=550");
		id.value="";
		}
	</script>
	<div class="talkcontainer">
		<div><h2> WebSocket chat </h2></div>
		<div class="talktalk">
			<img src="img/talktalk.png" alt="talk-img">
		</div>
		<div class="container ">
		<div class= "input-group">
			<div class="w-25 me-1"><input type= "text" id="chatID" class="form-control" placeholder="Enter username"/></div>
			<div><button class="btn" onclick="chatWinOpen();">Join chat</button></div>
		</div>
		</div>
		<div class="ryan">
			<img src="img/ryan.png" alt="ryan-image">
		</div>
	</div>	
</body>	
</html>	