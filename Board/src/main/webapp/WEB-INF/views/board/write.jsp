<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<html>
	<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">	
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<title>글 쓰기 페이지</title>
		<style>
		li{
		margin-top: 100px;
		}		
			.fileDrop {
				  width: 80%;
				  height: 100px;
				  border: 1px dotted gray;
				  background-color: lightslategrey;
				  margin: auto; 
			}
			body {
					background-image:url(/../../resources/images/background6.jpg);
					background-repeat:no-repeat;
					background-size: 100%;
				 }		
			form > .in_block {text-align:left;}
			span {position:relative;top:-270px;}
			input[type="button"] {width:70px;height:35px;}
			input[type="submit"] {width:70px;height:35px;}
		</style>
	</head>
	<body style="margin-left: 150px; margin-right: 150px; margin-bottom: 8px; margin-top: 80px;">
		<p style="text-align:center;font-size:20px;">글 쓰기 페이지</p>
		<form method="post" id="registerForm">
			<div style="margin:0 auto; width:90%;">
					<div class="in_block">
						제목 &nbsp;&nbsp;&nbsp;<input type="text" style="width:90%;" name="title" id="title">
					</div>
				<br />
 					<div class="in_block">
						글쓴이 <input style="width:90%;" value="<c:out value="${id}"></c:out>" name="id" readonly>
					</div>
				<br />
					<div>
						<span>내용</span> &nbsp;&nbsp;&nbsp;
						<textarea rows="20" style="width:90%;" name="body"></textarea>
					</div>
					<div class="in_block">
						<label for="exampleInputEmail1">파일첨부</label>
						<div class="fileDrop"></div>
					</div>
					<div style="float:right; position:relative; left:-6%;">
						<input type="submit" value="완료" class="btn btn-outline-info" >
						&nbsp;&nbsp;&nbsp;			
					<input type="button" value="취소" onclick='back()' class="btn btn-outline-info" >
					</div>
				<div style="clear:both;"></div>
					<div class="box-footer">
						<div>
							<hr>
						</div>
							<ul class="mailbox-attachments clearfix uploadedList" style="margin-top: 100;">
							</ul>
					</div>
		</form>
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>		
        <script src = "https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>		
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 	
	    <script type="text/javascript" src="/resources/js/upload.js"></script>
    <script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"style="margin-bottom: -450;"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><img src="/../../resources/images/xicon3.png" style="width: 13;" /></a>
	</span>
  </div>
</li>                
	</script>	    				
		<script>
		
		function back() {
				href = "/board";
				href += "?currentPageNo=" + ${cri.currentPageNo} + "&maxPost=" + ${cri.maxPost};
				href += "&search=" + "${search.search}" + "&searchType=" + "${search.searchType}";				 
				location.href = href; 
			}		
		function checking_form() {
			var form = document.forms[0];
			if(form.title.value == "")
			{
				alert('제목을 적어주세요');
				return false;
			}
			if(form.body.value == "")
			{
				alert('내용을 채워주세요');
				return false;
			}
			return true;
		}
		var template = Handlebars.compile($("#template").html());
		$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
		});
		$(".fileDrop").on("drop", function(event){
			event.preventDefault();
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			var formData = new FormData();
			formData.append("file", file);	
			$.ajax({
				  url: '/uploadAjax',
				  data: formData,
				  dataType:'text',
				  processData: false,
				  contentType: false,
				  type: 'POST',
				  success: function(data){
					  var fileInfo = getFileInfo(data);
					  var html = template(fileInfo);		  
					  $(".uploadedList").append(html);
				  }
				});	
		});
		$("#registerForm").submit(function(event){
			event.preventDefault();
			if(checking_form() == false){
				return false;
			}else{
			var that = $(this);
			var str ="";
			$(".uploadedList .delbtn").each(function(index){
				 str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
			});
			that.append(str);
			that.get(0).submit();
			}
		});
		$(".uploadedList").on("click", ".delbtn", function(event){
			event.preventDefault();
			var that = $(this);
			$.ajax({
			   url:"/deleteFile",
			   type:"post",
			   data: {fileName:$(this).attr("href")},
			   dataType:"text",
			   success:function(result){
				   if(result == 'deleted'){
					   that.closest("li").remove();
				   }
			   }
		   });
		});		
		</script>
	</body>
</html>