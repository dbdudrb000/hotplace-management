<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	 <link rel="stylesheet" type="text/css" href="/resources/css/hotplace/login.css">
<style>
	.table1{
		width:65%;
	}
	
	.table {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width:65%; inline-size: -webkit-fill-available;
      border-collapse: separate;
    }  
    .table th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .table th, .table td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .table th:first-child, .table td:first-child {
      border-left: 0;
    }
    .table th:last-child, .table td:last-child {
      border-right: 0;
    }
    .table tr td:first-child{
      text-align: center;
    }
	
	
</style>

</head>
<body bgcolor = "#ff7f00">
	
		
	<c:forEach var = "boardList" items = "${boardList}">
		<!-- 뭐가 필요한지 몰라서 일단 board (DB) 값 다 가져온 것. -->
		<div style=" display: none; ">
			<div name = "user_id">${boardList.boardid}</div>
			<div name = "user_address">${boardList.board_address} </div>
			<div name = "user_lat">${boardList.lat}</div>
			<div name = "user_lng">${boardList.lng}</div>
			<div name = "user_title">${boardList.title}</div>		
			<div name = "user_detail">${boardList.detail}</div>		
			<div name = "user_feeling">${boardList.feeling}</div>		
			<div name = "user_ delyn">${boardList.delyn}</div>		
			<div name = "user_create_dt">${boardList.create_dt}</div>		
			<div name = "user_ctreate_user">${boardList.create_user}</div>		
			<div name = "user_filepath">${boardList.filepath}</div>		
		</div>
			
		
	</c:forEach>	


	<caption><h1 style = "color: #00FFFF;" align = "center">추억 공유게시판</h1></caption>
		
			<div align = "center">
				<ul style = "list-style-type:none; dsiplay:inline; ">
					<li><input type = "text" placeholder = "검색창" id = "search_text"></li>
					<li><input type = "button" value = "검색하기" onclick = "search()"></li>
				</ul>
			</div>


		<form>
			<table align = "center" border = "2" class = "table">
				<tr>
					<th style = "width:7%">글번호</th>
					<th style = "width:40%">제목</th>
					<th style = "width:20%">장소</th>
					<th style = "width:15%">작성자</th>
					<th style = "width:15%">날짜</th>
				</tr>
				<c:forEach var = "boardList" items = "${boardList}">
					<tr name = "allboard_tr">
							<td>${boardList.boardid}</td>						
							<td><a name = "title" href="javascript:void(0);" 
											onclick="boardClick('${boardList.boardid}')">${boardList.title }</a></td>				
							<td>${boardList.board_address}</td>
							<td>${boardList.create_user}</td>
							<td>${boardList.create_dt}</td>						
					</tr>
				</c:forEach> 
			</table>
				<div align = "center">
				<ul style = "display: inline-flex; list-style: none;"> <!-- style = "margin-left: 40%" -->
					<li><input type = "button" value = "뒤로가기" onclick = "history.back()" ></li>
					<li><input type = "button" value = "메인으로" onclick = "location.href = '/kakao'"></li>
				</ul>
				</div>
		</form>
</body>

<script>
	
	function boardClick(boardid){
		
		var id = boardid;		
		
		location.href = "/board?boardid="+id;
	}
	
			
	function search(){
		
		var search_text = document.getElementById('search_text').value;
		
		location.href = "/board/searchAllBoard?search="+search_text;
		
		
	}
	

</script>
</html>