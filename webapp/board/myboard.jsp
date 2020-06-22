<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.table{
		width:65%;
	}
</style>
<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/login.css">
</head>
<body bgcolor = "#ff7f00">
	<form action = "" method = "post" align = "center">
		<caption><h1 style = "color: #00FFFF;">나의 히스토리</h1></caption>
			<input type = "hidden" name = "boardid" value = "${sessionScope.loginVO.nickname}">
			<table border = "3" align = "center" class = "table">
				<tr>
					<th style = "width:7%">글번호</th>
					<th style = "width:40%">제목</th>
					<th style = "width:20%">장소</th>
					<th style = "width:15%">작성자</th>
					<th style = "width:15%">날짜</th>				
				</tr>
				<tr>
					 <c:forEach var = "myBoard" items = "${myBoard}">
						 <tr>
							<td>${myBoard.boardid}</td>
							<td><a name = "title" href="javascript:void(0);" 
								   onclick="boardClick('${myBoard.boardid}')">${myBoard.title }</a></td>
							<td>${myBoard.board_address}</td>
							<td>${myBoard.create_user}</td>
							<td>${myBoard.create_dt}</td>
						</tr>
					</c:forEach>
				</tr>
			</table>
	</form>
	<div align = "center" style = "display: flex; margin-left: 30%;">
		<input type = "button" value = "뒤로가기" onclick = "history.back()">
		<input type = "button" value = "메인으로" onclick = "location.href = '/kakao'">
	</div>
</body>
<script>
function boardClick(boardid){
		//var a1 = document.getElementById('title').innerHTML;
		var id = boardid;		
		
		location.href = "/board?boardid="+id;
	}
</script>


</html>