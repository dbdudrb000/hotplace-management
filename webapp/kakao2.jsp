<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.5.0.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>
	
	<!-- bootstrap -->
	<link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
	<script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>
	
	<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/layout.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/kakao.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/login.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/mainTop.css">
	
	<!-- font Awesome -->
	<link rel="stylesheet" href="/resources/css/fontawesome/all.css">
	
<style>
.menubar li ul {
	background: rgb(109, 109, 109);
	display: none; /* 평상시에는 서브메뉴가 안보이게 하기 */
	height: auto;
	padding: 0px;
	margin: 0px;
	border: 0px;
	position: absolute;
	width: 200px;
	z-index: 200;
}
/* 인포윈도우 뜨게 하는 css */
.infowindow {
	padding: 5px;
	width: 500px;
	height: 100px;
	font: small-caption;
	border-radius: 50px;
	bgcolor: #ff7f00;
}

/* 임포트 */
.table {
	border-collapse: collapse;
	border-top: 3px solid #168;
	height: 670px;
	text-align: center;
	/* margin-left: 30%; */
	left: 670px;
	word-break: normal;
	background-color: #D7DF01;
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

.table tr td:first-child {
	text-align: center;
}

/*     .board_table{ */
/*     	left: 800px; position: absolute; */
/*     	z-index: 15; bgcolor : #ff7f00; */
/*     } */

	.window_img{
		width:200px;
		hieht:200px;
	}
	
	.listclose{
		width : 35px;
		height : 25px;
	}
</style>
</head>
<body bgcolor = "#ff7f00">
	
	<!-- 마커 클러스터러 에 등록할 주소를 가져오는 것이다.  -->
	<c:forEach var = "boardList" items = "${boardList}">
		<!-- 뭐가 필요한지 몰라서 일단 board (DB) 값 다 가져온 것. -->
		<div style=" display: none; ">
			<div name = "user_id">${boardList.boardid}</div>
			<div name = "user_address" style="font-size: 12px;">${boardList.board_address} </div>
			<div name = "user_lat">${boardList.lat}</div>
			<div name = "user_lng">${boardList.lng}</div>
			<div name = "user_title">${boardList.title}</div>		
			<div name = "user_detail" style="width: 200px;">${boardList.detail}</div>		
			<div name = "user_feeling">${boardList.feeling}</div>		
			<div name = "user_ delyn">${boardList.delyn}</div>		
			<div name = "user_create_dt">${boardList.create_dt}</div>		
			<div name = "user_ctreate_user">${boardList.create_user}</div>		
			<div name = "user_filepath">${boardList.filepath}</div>	
		</div>
	</c:forEach>
	
	 <c:forEach var = "sw" items = "${sw}">
		<tr>
			<td>sw: ${sw} 좌표!!</td>
		</tr>
	</c:forEach> 
	
	

	<a href ="/kakao"><h1 style= "color:#00FFFF;">HotPlace</h1></a>
<form action = "" name = "form">
	<nav>
		<ul align = "right" style = "cursor: pointer;">
			<c:choose>			
				<c:when test = "${sessionScope.loginVO.email == null}">
					<li><a onclick= "main_board()">추억리스트</a></li>
					<li><a href = "/board/allBoard">추억게시판</a></li>	
					<li><a onclick = "noMemberBoard()">추억 등록</a></li>	
			    	<li><a href="/joinView">회원가입</a></li>
			    	<li><a href="/loginView">로그인</a></li>		      
			    </c:when>
		    	<c:otherwise>
		    		<li><a onclick= "main_board()">추억리스트</a></li>
		    		<li><a href = "/board/allBoard">추억게시판</a></li>	   
		    		${sessionScope.loginVO.email}님!     
		    		<li><a href = "/logoutLogic">로그아웃</a></li>
		    		<li><a href = "/board">추억 등록</a></li>
		    		<li>
		    			<a href="javascript:void(0);" onclick="myboard('/board/myboard')">나의 히스토리</a>
		    			<input type = "hidden" name = "create_user" value = "${sessionScope.loginVO.nickname}">
		    		</li>
		    		
		    	</c:otherwise> 	
		    </c:choose>
		</ul>  
		   
	</nav> 
	</form>          	  	            	
	<table id="searchList" style = "display:none" border = "5" width = 38%>	

	</table>   			    			   			

	<form>
		 	<center style = "margin : 20px;">
		    	<input type="text" id="search_text" placeholder="검색창" style = "display: inline;"> 
 				<input type = "button" value = "검색" onclick = "buttonAddress(search_text.value)" style = "display: inline;">	
		    </center>
		<div align = "center">
			<div class="btn-group" id="address_div" role="group" aria-label="...">
				<c:forEach var = "addressList" items = "${addressList}">
					
					<input type="hidden" class="address_city" value="${addressList.pkid1 }">
					<button type="button" class="btn btn-primary" style="border : 2px solid white;" onclick="buttonAddress('${addressList.pkid1 }');">
					  ${addressList.pkid1 }
					<c:forEach var = "sub_city_list" items = "${addressList.sub_city}">
						<span class="badge badge-light" onclick="buttonAddress('${addressList.pkid1 }','${sub_city_list}');">${sub_city_list}</span>
					</c:forEach>
					</button>
					
				</c:forEach>
			</div>
 			
		</div>
				
	</form>

	<div style="display: none;" id="information" >
		<div align = "left">
			<p id="title" style="margin-left: 10px;">제목:</p> 
			<div id="address" style="width: 200px;"></div>
			<div id = "window_img"></div>
			<p id="window_like" style="margin-left: 10px;">
				<span id="like">♡ </span>
				<span id="like_cnt">0</span>
				<span id="chat" style="font-size: 1em; color: #999;" onclick="alert('!!!');">
					<i class="far fa-comments"></i>
				</span>
				<span id="chat_cnt">17</span>
				<a class="modal-detail"data-toggle="modal" onclick="setDetail(this);" href="#shortModal" class="btn btn-primary"><span class="badge badge-pill badge-info" style=" float: right; margin: 5px;">Info</span></a>
			</p> 
		</div>		
	</div>

<!--  검색창에 검색하면 해당 정보를 가져오는데 그 정보들을 searchList 의 innerHTML 로 넣어주는 것이다. -->
<div class = "menubar">
 <ul id="searchList1" align = "left">
 	
	
</ul>
</div> 

<article class="comic">
  <div class="panel" style="height: 850px;">
    <p class="text top-left" style="z-index: 9">꼬레아</p>
    <div id="map" style="width:100%;height:100%;"></div>	<!-- 여기에 지도창에 보여주는 것이다. -->
    <p class="text bottom-right" style="z-index: 9">...핫 플레이스</p>
	<div id="clickLatlng"></div>
    
  </div>
  <div class="panel" style=" display:none; height: 850px;" id = "detail_board" >
    <p class="text top-left" style="z-index: 9">현장 반응 ...</p>
    <!-- <a>닫기</a> -->
    
    <div style= "" id = "boardML" class = "board_table">
		<span><a style = " background: darkseagreen;" onclick = "main_board()"><h5 style = "margin-left:90%;"><span style = "font-size:20px;"><i class="fas fa-times-circle"></i></span></h5></a></span> 
		
		<article class="comic" id="boardArticle" style=" overflow-y: scroll;scroll-behavior: smooth;height: 800px;" >
			<c:forEach var = "boardList2" items = "${boardList}">
			  <div class="detail_panel" onclick="location.href='/board?boardid=${boardList2.boardid }'" style="cursor:pointer; background-size:100% 100%; background-image: url('/board/img?path=${boardList2.filepath}');">
				<p style="display: none;">${boardList2.create_user }</p>
				<p style="display: none;">${boardList2.create_dt }</p>	
			    <p class="text top-left">${boardList2.title }</p>
			    <p class="text bottom-right">${boardList2.board_address }</p>
			  </div>
			</c:forEach>	
		</article>	
	</div>
    
    <p class="text bottom-right" style="z-index: 9">...씨끌벅적</p>
  </div>
	   
</article>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bf2a48e2f31d722ff5972f0dca35a662&libraries=services,clusterer,drawing"></script>
<script>
	window.addEventListener('DOMContentLoaded', function(){
		
		//실행될 코드
		map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		    center : new kakao.maps.LatLng(36.222683, 127.226358), // 지도의 중심좌표 
		    level : 12 // 지도의 확대 레벨 
		    
		});
		//최초 실행
		init();
			
		
		
	});
	
	
	function init(markers){
		
		var lat = document.getElementsByName('user_lat');
		var lng = document.getElementsByName('user_lng');
		var titleArry = document.getElementsByName('user_title');
		var detailArry = document.getElementsByName('user_detail');
		var feelingArry = document.getElementsByName('user_feeling');
		var addressArry = document.getElementsByName("user_address");
		var create_userArry = document.getElementsByName("user_ctreate_user");
		var create_dtArry = document.getElementsByName('user_create_dt');
		var boardidArry = document.getElementsByName('user_id');
		var filepathArry = document.getElementsByName('user_filepath');
		
		// DB에 저장된 (제목, 내용, 기분, 작석자, 순번 등등) 을 오브젝트 형식으로 만든것.
		var boardArryObj = {
				title 		: 	titleArry
			,	detail 		: 	detailArry
			,	feeling 	: 	feelingArry
			,	address		:	addressArry
			,	create_user :	create_userArry
			,	create_dt 	: 	create_dtArry
			,	boardid		:	boardidArry
			,	filepath	:	filepathArry
		};
		
		// DB에 저장된 ( 좌표 )들을  오브젝트형식 로 가지고 있는 것.
		var coords = [];
		for(var i = 0; i < lat.length;i++){
			var position = { lat : lat[i].innerText, lng : lng[i].innerText };
			coords.push(new kakao.maps.LatLng(lat[i].innerText, lng[i].innerText));
		}
		
		//클러스터러 그려주기
		makeMarkAndClusterer(coords,boardArryObj);
		
	}
	
	markersArry = [];
// 	infowindow = '';
	function makeMarkAndClusterer(coords,boardArryObj){
		
		// 데이터에서 좌표 값을 가지고 마커를 표시합니다 - DB안에 있는 좌표를 가져와 마커를 생성시켜주는 것
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = [];
		for(var i=0; i<coords.length; i++){
        	var marker = displayMarker(coords[i],boardArryObj,i);	// 리턴되는 생성된 마커들을 배열에 넣고 마커클러스터러에 넣어주는 것.
			markers.push(marker);
		}
		
		
		// 마커 클러스터러를 생성합니다 
		var clusterer = new kakao.maps.MarkerClusterer({
		    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		    minLevel: 3 // 클러스터 할 최소 지도 레벨 
		});
		
		
        markersArry = markers;
        // 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers); //markers

		// 클러스터링 완료 후 이벤트핸들러     	    	
		var markers = [];
		kakao.maps.event.addListener(clusterer,'clustered',	function(clusters) {
			for (var i = 0; i < clusters.length; i++) {
				for (var j = 0; j < clusters[i].getMarkers().length; j++) {

					markers.push(clusters[i].getMarkers()[j]);
				}
			}
			var bounds = map.getBounds();
			var swLatlng = bounds.getSouthWest();
			var neLatlng = bounds.getNorthEast();
			// location.href = "/kakao?swLatlng="+swLatlng+"&neLatlng="+neLatlng;
			var param = {swLatlng : swLatlng , neLatlng : neLatlng};
			
			makeRequest(param);
			console.log("swLatlng" + swLatlng + "neLatlng" + neLatlng);
		});
		
		kakao.maps.event.addListener(clusterer,'clusterclick',	function(clusters) {
			kakao.maps.event.trigger(map,'click');
		});
		
	}
	// 파라미터로는 받은 것은 (좌표, 게시글정보, for문 돌면서 index) 를 넣어준 것이다. 
	function displayMarker(coord, boardArryObj, index) {

		// 마커를 생성하고 지도에 표시합니다
		var marker = new kakao.maps.Marker({
			map : map,
			position : coord
		});

		// 마커를 지도에 표시합니다.
		marker.setMap(map);

		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var frame = $('#information');

		var boardid = boardArryObj.boardid[index].innerHTML;
		var img = boardArryObj.filepath[index].innerHTML;
		frame.find("#title").html($(boardArryObj.title[index]).html());
		frame.find("#detail").html($(boardArryObj.detail[index]).clone());
		frame.find("#create_dt").html($(boardArryObj.create_dt[index]).clone());
		frame.find('#feeling').html($(boardArryObj.feeling[index]).clone());
		frame.find('#address').html($(boardArryObj.address[index]).clone());
		frame.find('#create_user').html($(boardArryObj.create_user[index]).clone());
		frame.find("#memory").html('<td align = "center" colspan = "2"><input type = "button" value = "추억구경하기 " onclick = "boardHref('	+ boardid + ')"></td>');
		frame.find('#window_img').html('<img src=/board/img?path='+ boardArryObj.filepath[index].innerHTML+ ' class = "window_img">');

		//Modal 셋팅
		frame.find('.modal-detail').attr('modal-title',$(boardArryObj.title[index]).html());
		frame.find('.modal-detail').attr('modal-contents',$(boardArryObj.detail[index]).html());
		frame.find('.modal-detail').attr('modal-img',boardArryObj.filepath[index].innerHTML);
		frame.find('.modal-detail').attr('modal-feeling',boardArryObj.feeling[index].innerHTML);
		frame.find('.modal-detail').attr('modal-boardid',boardid);
		frame.find('.modal-detail').attr('modal-create_user',$(boardArryObj.create_user[index]).html());
		
		//if(안좋아요)
		//    		frame.find('#like').html('<i class="far fa-heart"></i>');
		//if(좋아요)
		frame.find('#like').html('<span onclick="btnLike(this);" style="font-size: 1em; color: Tomato;"><i class="fas fa-heart"></i></span>');
		frame.find('#like_cnt').html("6");

		//frame.find("#memory").html('<td align = "center" colspan = "2"><input type = "button" value = "추억구경하기 " onclick = "boardHref('+boardid+')></td>');
		// frame.find("#memory").html('<td><a href="/board?boardid=' + boardid + '">' +'추억구경하기기'+ '</a></td>'); // 원래 하려던 방법

		var iwContent = frame.html();
		var iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {  
			infowindow.close();
		});
		
		// 마커에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			kakao.maps.event.trigger(map,'click');
			main_board(true);
			console.log('marker click!');
			
			goBoardInMap(marker.getPosition().Ha,marker.getPosition().Ga);
			console.log("Ha= "+marker.getPosition().Ha, "Ga= " + marker.getPosition().Ga);
			
			// 마커 위에 인포윈도우를 표시합니다
			infowindow.open(map, marker);
		});

		return marker;
	}

	function myboard(url) {
		document.form.action = url;
		form.submit();
	}

	// 인포윈도우에 추억보러기기 누르면 게시글보여주는 페이지로 가는것.
	function boardHref(boardid) {

		location.href = '/board?boardid=' + boardid;
	}

	function main_board(isOpen) {
		
		if(isOpen){			
			document.getElementById("detail_board").style.display = "block";
		}else{
			if (document.getElementById("detail_board").style.display == "none") {
				document.getElementById("detail_board").style.display = "block";
			} else {
				document.getElementById("detail_board").style.display = "none";
			}
		}
		map.relayout();
	}
	function search() {

		var search_text = document.getElementById("search_text").value;
		location.href = "/board/searchAllBoard?search=" + search_text;

	}

	function btnLike(ele) {
		if ($(ele).find('i')[0].className == "fas fa-heart") {
			$(ele).find('i')[0].className = "far fa-heart";
		} else {
			$(ele).find('i')[0].className = "fas fa-heart";
		}
	}

	var httpRequest;
	
	function makeRequest(param) {
		if(!param){ 
			param = {
					// ( 123, 567)
					"swLatlng" : '(' + map.getBounds().ea + ',' + map.getBounds().la + ')'
					,"neLatlng" : '(' + map.getBounds().ja + ',' + map.getBounds().ka + ')'
			};
		}
		httpRequest = new XMLHttpRequest();

		if (!httpRequest) {
			alert('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
			return false;
		}
		
		var formData = new FormData();
		formData.append('swLatlng', param.swLatlng);
		formData.append('neLatlng', param.neLatlng);
		
		httpRequest.onreadystatechange = alertContents;
		httpRequest.open('POST', '/board/ajax', true);
		httpRequest.send(formData);
		
	}

	function alertContents() {
		if (httpRequest.readyState === XMLHttpRequest.DONE) {
			if (httpRequest.status === 200) {
// 				console.log(httpRequest.responseText);
				drawList(JSON.parse(httpRequest.responseText).list);
			} else {
				alert('request에 뭔가 문제가 있어요.');
			}
		}
	}
	
	function drawList(list){
		htmlStr = '';
		
		if(list){
			for(var i = 0; i < list.length; i++){
// 				htmlStr += '<div class="detail_panel" onclick="location.href=\'/board?boardid=' + list[i].boardid + '\'" style="cursor:pointer; background-size:100% 100%; background-image: url(\'/board/img?path=' + list[i].filepath + '\');">';
				htmlStr += '<div class="detail_panel" onclick="goBoardInMap(' + list[i].lat + ',' + list[i].lng + ',\'true\')" style="cursor:pointer; background-size:100% 100%; background-image: url(\'/board/img?path=' + list[i].filepath + '\');">';
				htmlStr += '	<p style="display: none;">' + list[i].create_user + '</p>';
				htmlStr += '	<p style="display: none;">' + list[i].create_dt + '</p>';	
				htmlStr += '	<p class="text top-left"">' + list[i].title + '</p>';
				htmlStr += '	<p class="text bottom-right"">' + list[i].board_address + '</p>';
				htmlStr += '</div>';
			}
		}
		   
		document.getElementById('boardArticle').innerHTML = htmlStr;
		
	}
	
	function goBoardInMap(lat,lng,info){
	     map.setLevel(3);
		// 지도 중심을 이동 시킵니다
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(lat, lng);
	    //map.setCenter(moveLatLon);
	     map.panTo(moveLatLon);
	  	
	     if(info == 'true'){
	     // 마커 위에 인포윈도우를 표시합니다
	     makeInfoWindow(lat,lng);
	     }
	}
	
	function makeInfoWindow(lat,lng){
		lat = (lat + '').substr(0,14);
		lng = (lng + '').substr(0,14);
		var targetMarker = '';
		markersArry.forEach(function(marker){
		    if(		(marker.getPosition().Ha + '').substr(0,14) == lat  
		    	&&	(marker.getPosition().Ga + '').substr(0,14) == lng ){
		    	targetMarker = marker;
		    }
		})

		kakao.maps.event.trigger(targetMarker,'click');
		
		// 마커 위에 인포윈도우를 표시합니다
// 		infowindow.open(map, targetMarker);
	}
	
	function noMemberBoard(){
		var noMember = confirm("로그인을 하시겠습니까?");
		
		if(noMember == true){
			location.href = "/loginView";
		}
		
	}
	
	function setDetail(el){
		var contents = $(el).attr('modal-contents');
		var title = $(el).attr('modal-title');
		var img = $(el).attr('modal-img');
		var feeling = $(el).attr('modal-feeling');
		var boardid = $(el).attr('modal-boardid');
		var create_user = $(el).attr('modal-create_user'); 
		
		console.log(el);
		$("#shortModal").find('.modal-title').html(title);
		$("#shortModal").find('.modal-contents').html(contents);
		$("#shortModal").find('.modal-feeling').html(feeling);
		$("#shortModal").find('.window_img').attr("src",'/board/img?path='+img);
		

		//작성자
		if('${sessionScope.loginVO.nickname}' == create_user){
			$("#shortModal").find("[name=btnUpdate]").attr('onclick','location.href="/board?boardid=' + boardid + '"');
			document.getElementsByName('btnUpdate')[0].style.display = 'inline-block';
		}else{
			document.getElementsByName('btnUpdate')[0].style.display = 'none';
		}
		
	}
	
	function buttonAddress(city,sub){
		var address = "";

		if(sub){
			address = city + ' ' + sub;
		}else{
			address = city;
		}
		
		if(city){
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(address, function(result, status) {
	
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
	
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			        if(sub){
				        map.setLevel(6);
			        }else{
				        map.setLevel(9);
			        }
			    } 
			}); 
		}
		
	} 
</script>
<!-- 모달 -->
<%@ include file="\WEB-INF\jsp\main\board\lookBoard.jsp" %>
</body>
</html>