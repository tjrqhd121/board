<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Ryan SignUp</title>
<style>
 body {
	background-image:url(/../../resources/images/background6.jpg);
	background-repeat:no-repeat;
	background-size:100%;
}

form {
    width: 320px;
    padding: 60px 25px 80px;
    margin: 50px auto;
    background: #f8d348;
    display: flex;
    flex-direction: column;
}

svg {
    width: 70%;
    border-radius: 50%;
    background: #fff;
    margin-bottom: 40px;
    align-self: center;
    transform-style: preserve-3d;
}

input {
    font-size: 16px;
    border: 0;
    border-radius: 5px;
    outline: 0;
    padding: 10px 15px;
    margin-top: 15px;
}

@keyframes lookaway-up {
    from {
        transform: rotate3d(.2, 0, -.01, 20deg);
    }

    to {
        transform: rotate3d(.2, -.05, -.01, 20deg);
    }
}

@keyframes lookaway-down {
    0% {
        transform: rotate3d(-.2, 0, -.01, 20deg);
    }

    100% {
        transform: rotate3d(-.2, -.05, .01, 20deg);
    }
}

.ears {
    transform-origin: 50% 50% 5px;
}

.eyes {
    transform-origin: 50% 50% -40px;
}

.muzzle {
    transform-origin: 50% 50% -44px;
}

.ears, .eyes, .muzzle {
    transition: transform .5s;
}

.focused {
    transition: transform .1s;
}

.look-away .ears,
.look-away .eyes,
.look-away .muzzle {
    transition-duration: .3s;
    animation: 3s infinite alternate;
}

.look-away.up .ears,
.look-away.up .eyes,
.look-away.up .muzzle {
    transform: rotate3d(.2, 0, 0, 20deg) !important;
}

.look-away.down .ears,
.look-away.down .eyes,
.look-away.down .muzzle {
    transform: rotate3d(-.2, 0, 0, 20deg) !important;    
}

.look-away.playing.up .ears,
.look-away.playing.up .eyes,
.look-away.playing.up .muzzle {
    animation-name: lookaway-up;
}

.look-away.playing.down .ears,
.look-away.playing.down .eyes,
.look-away.playing.down .muzzle {
    animation-name: lookaway-down;
} 
</style>
</head>
<body>
    <form action="/login/check2" method="post">
        <svg id="ryan" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,150 C0,65 120,65 120,150" fill="#e0a243" stroke="#000" stroke-width="2.5" />
            <g class="ears">
                <path d="M46,32 L46,30 C46,16 26,16 26,30 L26,32" fill="#e0a243" stroke="#000" stroke-width="2.5" stroke-linecap="round" transform="rotate(-10,38,24)" />
                <path d="M74,32 L74,30 C74,16 94,16 94,30 L94,32" fill="#e0a243" stroke="#000" stroke-width="2.5" stroke-linecap="round" transform="rotate(10,82,24)" />
            </g>
            <circle cx="60" cy="60" r="40" fill="#e0a243" stroke="#000" stroke-width="2.5" />
            <g class="eyes">
                <!-- left eye and eyebrow-->
                <line x1="37" x2="50" y1="46" y2="46" stroke="#000" stroke-width="3" stroke-linecap="round" />
                <circle cx="44" cy="55" r="3" fill="#000" />
                <!-- right eye and eyebrow -->
                <line x1="70" x2="83" y1="46" y2="46" stroke="#000" stroke-width="3" stroke-linecap="round" />
                <circle cx="76" cy="55" r="3" fill="#000" />
            </g>
            <g class="muzzle">
                <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" />
                <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" stroke="#000" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round" />
                <polygon points="59,63.5,60,63.4,61,63.5,60,65" fill="#000" stroke="#000" stroke-width="5" stroke-linejoin="round" />
            </g>
            <path d="M40,105 C10,140 110,140 80,105 L80,105 L70,111 L60,105 L50,111 L40,105" fill="#fff" />
        </svg>	
        <input type="text" id="id" name="id" placeholder="id" autocomplete="off">
        <input name="name" id="name" placeholder="Name" autocomplete="off" />
        <input name="email" id="email" placeholder="E-mail" autocomplete="off" />
        &nbsp;
        <button type="button" onclick="Docheck();" class="btn btn-lg btn-primary btn-block">비밀번호 찾기</button>	
    </form>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script>
     function Docheck() {
 	    var id = $("#id").val();
 	    var name = $("#name").val();
	    var email = $("#email").val();
	    var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
     if(id.length == 0 ){
      	alert("아이디를 입력해 주세요"); 
          $("#id").focus();
          return false;
      }	    
     if(name.length == 0){
         alert("이름을 입력해주세요");
         $("#name").focus();
         return false;
     }     
     if(email.length == 0){
         alert("이메일을 입력해주세요");
         $("#email").focus();
         return false;
     }
	if(re2.test(email) == false){
        alert("잘못된 이메일 형식입니다");
        $("#email").focus();
        return false;
    }     
     $.ajax({
    	 type : "post",
    	 cache : false,
    	 data : "id="+$("#id").val()+"&email="+$('#email').val()+"&name="+$('#name').val(),
    	 url : "/login/check2",
    	 success : function(data){
    		 if(data.pw==null || data.pw==""){
    			 alert("가입정보를 다시 입력하시요.");
    			 location.reload();
    		 }else{
    			 alert("회원님의 비밀번호는"+data.pw+"입니다.");
    			 location.reload();
    		 }
    	 }
     });
     }
    </script>
</body>
</html>

