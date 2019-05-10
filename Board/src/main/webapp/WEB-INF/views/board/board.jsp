<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/table.css" type="text/css" media="screen" />
<title>기초적인 게시판</title>
		<style>
 			.mytable { border-collapse:collapse; }  
			.mytable th, .mytable td { border:1px solid black; }
			.clear {clear:both;}
			td:nth-child(1), td:nth-child(3),td:nth-child(4),td:nth-child(5) {width:10%; }
			th:nth-child(1), th:nth-child(3),th:nth-child(4),th:nth-child(5) {width:10%; }
			a {text-decoration:none;}
			select {width:100px;font-size:16px;}
 			input[type="submit"] {width:90px;} 
			p + div > form > * {display:inline;vertical-align:middle;height:27px;}
			p + div {margin-top:25px !important;}
			td:nth-child(1), td:nth-child(3),td:nth-child(4),td:nth-child(5) {width:10%; }
			th:nth-child(1), th:nth-child(3),th:nth-child(4),th:nth-child(5) {width:10%; }
			td:nth-child(2) {text-align:left;}
			body{
			background-image:url(/../../resources/images/background6.jpg);
			background-repeat:no-repeat;
			background-size:100%;			
			}
		</style>
</head>
<body>
	<div>	
		<div style="float: right; margin-right: 132px;">	
			<c:choose>
				<c:when test='${session == "yes"}'>
					<a href="/logout" class="button" style="margin-right: 120px;">${sessionScope.id}님 로그아웃</a>
				</c:when>
			</c:choose>
		</div>		
	</div>
		<p style="width:30%;margin:0 auto;text-align:center;font-size:20px;">악보 공유 게시판</p>
		<div style="width:90%;margin:0 auto;">
			<form method="get" style="margin-left: 133px;">
				<select name="searchType">
					<option value="null" <c:if test="${search.searchType == 'null'}">selected</c:if> >분류</option>
					<option value="title" <c:if test="${search.searchType == 'title'}">selected</c:if> >제목</option>
					<option value="id" <c:if test="${search.searchType == 'id'}">selected</c:if> >작성자</option>
				</select>
				<input type="text" name="search" value="${search.search }">
				<input type="submit" value="검색" class="btn btn-outline-info">
			</form>
		</div>

	<br />
	<div style="width:73%;margin:0 auto;margin-left: 11%;">
			<table id="hor-minimalist-b" style="width:100%;">
				<thead>
					<tr>
						<th>번호</th>
						<th style="text-align:left;">제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th style="width: 50px;">추천</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty page}">
							<c:forEach items="${page}" var="board">
								<tr style="text-align:center;height:35px;">
									<td>${board.bno}</td>
									<td><a href="javascript:read_page_process(${board.bno})">${board.title}<c:if test='${board.files != null}'><img src="/../../resources/images/fileicon.png" style=""width=13px;"/></c:if></a></td>
									<td>${board.id}</td>
									<td><fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd"/></td>
									<td>${board.hits}</td>
									<td>${board.likenum}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr style="text-align:center;height:35px;">
								<td colspan="5">게시글이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<br />
			<c:if test="${pager.numberOfRecords != 0}">
				<div style="width:50%;margin:0 auto;text-align:center;">
					<c:if test="${pager.currentPageNo != 1}">
						<a href="javascript:page_locate(${pager.prevPageNo}, ${pager.maxPost})">이전</a>
					</c:if>&nbsp;
					<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1">
						<c:choose>
							<c:when test="${i != pager.currentPageNo}">
								<a href="javascript:page_locate(${i}, ${pager.maxPost})">
									<c:out value="${i}"></c:out>
								</a>&nbsp;
							</c:when>
							<c:otherwise>
								<c:out value="${i}"></c:out>
								&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pager.currentPageNo < pager.nextPageNo}">
						<a href="javascript:page_locate(${pager.nextPageNo}, ${pager.maxPost})">다음</a>
					</c:if>
				</div>
			</c:if>
			<br />
			<div>
			<c:if test="${session != null}">
				<button type="button" style="float:right;width:90px;height:30px;margin-top: -80;" onclick="new_write()" class="btn btn-outline-info">글쓰기</button>
			</c:if>
			</div>
			<div class="clear"></div>
		</div>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script>
	    console.log(${board.files});
		function new_write() {
			href = "/board/write?";
			href += "&currentPageNo=" + ${pager.currentPageNo}+"&maxPost=" + ${pager.maxPost};
			href += "&search=" + "${search.search}" + "&searchType="+ "${search.searchType}";
			location.href = href;
		}
		function page_locate(page, perpagenum) {
			href = "?currentPageNo=" + page + "&maxPost=" + perpagenum;
			href += "&search=" + "${search.search}" + "&searchType="
					+ "${search.searchType}";
			location.href = href;
		}
		function read_page_process(bno) {
			href = "board/read?bno=" + bno;
			href += "&currentPageNo=" + ${pager.currentPageNo}+"&maxPost=" + ${pager.maxPost};
			href += "&search=" + "${search.search}" + "&searchType="+ "${search.searchType}";
			location.href = href;
		}
		jQuery(document).ready(function(){
		    
		    var select = $("select#color");
		    
		    select.change(function(){
		        var select_name = $(this).children("option:selected").text();
		        $(this).siblings("label").text(select_name);
		    });
		});
		$(document).ready(function() { 
			var placeholderTarget = $('.textbox input[type="text"]'); 
			//포커스시
			placeholderTarget.on('focus', function(){ 
				$(this).siblings('label').fadeOut('fast'); 
			}); 
			//포커스아웃시
			placeholderTarget.on('focusout', function(){ 
				if($(this).val() == ''){ 
					$(this).siblings('label').fadeIn('fast'); 
					} 
				}); 
			});
		console.log('${pager.currentPageNo}');
		if($('.textbox input[type="text"]').val()!=''){
			$('.textbox input[type="text"]').siblings('label').fadeOut('fast'); 
		};
		var target="."+${pager.currentPageNo}
		console.log(target);
		$(target).css("color","#fff");
		$(target).css("background","#1278ed");
		$(target).css("border","#1px solid #4c8500");

	</script>
</body>
</html>
