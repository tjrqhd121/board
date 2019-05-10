<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
	<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<title>글 읽기</title>
		<style>
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
       position:relative;
       max-width: 1200px; 
       max-height: 800px; 
       overflow: auto;       
     }		
			body {
					background-image:url(/../../resources/images/background6.jpg);
					background-repeat:no-repeat;
					background-size: 100%;
				 }
			form > .in_block {text-align:left;}
			span {position:relative;top:-270px;}
 			input[type="button"] {width:70px;height:35px;}
		</style>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
		<script src="//code.jquery.com/jquery.min.js"></script>
	</head>
	<body style="margin-left: 150px; margin-right: 150px; margin-bottom: 8px; margin-top: 80px;">	
		<p style="width:30%;margin:0 auto;text-align:center;font-size:20px;">악보 공유 게시판</p>	
				<div>
					<div id="btn" style="float: right; margin-top: 5px; margin-right: 132px;">
						<c:if test="${post.id != id}">
						<input type="button" value="뒤로" onclick='back()'  class="btn btn-outline-info">
						</c:if>
					</div>
				</div>
				
		<form>
			<div style="margin:0 auto; width:90%;">	
				<div style="float:right; position:relative; left:-6%; margin-bottom:20px;">		
					<c:if test="${post.id == id}">
						<input type="button" value="수정" onclick='alter()'  class="btn btn-outline-info">
						&nbsp;&nbsp;&nbsp;
						<input type="button" value="삭제" onclick='del_post(<c:out value="${post.bno}"></c:out>)'  class="btn btn-outline-info">
 						&nbsp;&nbsp;&nbsp;
 						<input type="button" value="뒤로" onclick='back()'class="btn btn-outline-info">									
					</c:if>
				</div>
					<div style="clear:both;"></div>
						<div class="in_block">
							<table>
								<tr>
									<td style="height:40px;">날짜:<fmt:formatDate value="${post.reg_date}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</table>
						</div>			
						<input type="hidden" value = "<c:out value="${post.id}"></c:out>">
							<div class="in_block" style="margin-left:3px;">
								제목 &nbsp;&nbsp;&nbsp;<input type="text" style="width:90%;" readonly="readonly" value="<c:out value="${post.title}"></c:out>">
							</div>
					<br />
							<div class="in_block" style="margin-left:3px;">
								글쓴이 <input type="text" style="width:90%;" readonly="readonly" value="<c:out value="${post.id}"></c:out>">
							</div>
					<br />		
							<div style="margin-left:3px;">
								<span>내용</span> &nbsp;&nbsp;&nbsp;
								<textarea rows="20" style="width:90%;" readonly="readonly"><c:out value="${post.body}"></c:out></textarea>
							</div>
						<div style="float:right; position:relative; left:-6%; margin-bottom:20px;">
							<input type="button" value="추천" id="addlike" class="btn btn-outline-info">
						</div>
					    <div class='popup back' style="display:none; height: auto; width:auto;"></div>
				   			 <div id="popup_front" class='popup front' style="display:none;">
				   			 <img id="popup_img">
				    	</div>
					<br />					 
			</div>
		</form>
		<ul class="mailbox-attachments clearfix uploadedList"></ul>
		<div style="width:90%; margin:0 auto; text-align:center; margin-bottom:15px;">
			<c:choose>
					<c:when test="${!empty comment}">
						<c:forEach items="${comment }" var="comment">
							<div style="font-size:15px; text-align:left; margin-left:20px; margin-bottom:15px;">
							<input type="text" value="${comment.com_cont}" readonly style="font-size:18px;width:500px;border:0px;">
								<button style="width:60px; height:30px;" id="comment_modify" class="btn btn-outline-info">수정</button>
								<button style="width:60px; height:30px;" id="comment_delete" value="${comment.com_no}" class="btn btn-outline-info">삭제</button>
							</div>				
						</c:forEach>
					</c:when>
				<c:otherwise>
					<div style="font-size:15px; text-align:left; margin-left:20px;">
						댓글이 존재하지 않습니다.
					</div>					
				</c:otherwise>
			</c:choose>		
		</div>
		<div style="width:90%; margin:0 auto;">
			<input type="text" style="width:300px; height:30px;" id="new_comment">
			<button style="width:100px; height:30px;" id="comment_add" class="btn btn-outline-info">댓글달기</button>
		</div>		
<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'  style="margin-top : 100px;">
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment" style="margin-bottom : -400px;"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>
	    <script type="text/javascript" src="/resources/js/upload.js"></script>
		<script>		
		var bno = ${post.bno};
		var template = Handlebars.compile($("#templateAttach").html());
		$.getJSON("/getAttach/"+bno, function(list){
			$(list).each(function(){
				var fileInfo = getFileInfo(this);
				var html = template(fileInfo);
				 $(".uploadedList").append(html);
			});
		});
		$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
			var fileLink = $(this).attr("href");
			if(checkImageType(fileLink)){
				event.preventDefault();
				var imgTag = $("#popup_img");
				imgTag.attr("src", fileLink);
				console.log(imgTag.attr("src"));	
				$(".popup").show('slow');
				imgTag.addClass("show");		
			}	
		});
		$("#popup_img").on("click", function(){
			$(".popup").hide('slow');
		});	
			function del_post(no) {
				var form = document.createElement("form");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "Post");
				form.setAttribute("action", "delete");

				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "bno");
				hiddenField.setAttribute("value", no);
				form.appendChild(hiddenField);
				
				document.body.appendChild(form);
				
				form.submit();
			}
			function back(){
				href = "/board"
				href +="?currentPageNo=" + ${cri.currentPageNo} + "&maxPost=" + ${cri.maxPost};
				href += "&search=" + "${search.search}" + "&searchType=" + "${search.searchType}";
				location.href = href;
			}			
			function alter() {
				href = "modify?bno=" + ${post.bno};
				href += "&currentPageNo=" + ${cri.currentPageNo} + "&maxPost=" + ${cri.maxPost};
				href += "&search=" + "${search.search}" + "&searchType=" + "${search.searchType}";
				location.href = href;
			}			
			
			$("#comment_add").click(function(){
				if($("#new_comment").val() == "")
					return false;
			    $.ajax({
			        url : "/commentInput",
			        type : "POST",
			        cache : false,
			        data : "bno=" + ${post.bno} + "&com_cont=" + $("#new_comment").val(),
			        success : function(response){
			        	if(response.result == 1)
			        		location.reload();
			        }
			    });
			});
			var likenumber=$("#likenum").val();
			$("#addlike").click(function(){
		      $.ajax({
			        type : "POST",
			        cache : false,
		       		data : "bno=" + ${post.bno},
		       		url : "/board/likenum",
		       		success : function(data) {
							if(data == 1){
								alert("감사합니다!");
				        		console.log(data.result);
							}
	       				}
		   		}); 
			})
			$("#comment_delete").click(function(){
				var no = $(this).val();
			    $.ajax({
			        url : "/commentDelete",
			        type : "POST",
			        cache : false,
			        data : "com_no=" + no,
			        success : function(response){
			        	if(response.result == 1)
			        		location.reload();
			        }
			    });
			});
			
			var check = false;
			
			$("#comment_modify").click(function(){
				$(this).next().hide();
				$(this).html("수정완료");
				$(this).css("width","80px");
				$(this).prev().css("border", "1px solid black").attr("readonly",false);
				$(this).attr('id', "comment_modify_ok");
				if(check == false)
				{
					$(this).bind('click', function(){
						var no = $("#comment_modify").val();
						var post = $("#comment_modify").prev().val();
						alert(no + "" +post);
						if(post == "")
						{
							alert('댓글을 입력해주세요.');
							return false;
						}
					    $.ajax({
					        url : "/commentModify",
					        type : "POST",
					        cache : false,
					        data : "com_no=" + no + "&com_cont=" + post,
					        success : function(response){
					        	if(response.result == 1)
					        		location.reload();
					        }
					    });					
					});
				}
				check = true;
			});		
		</script>
	</body>
</html>
