<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<style>
	.preview_div{
		text-align: center;
		width: 510px;
		min-height: 320px;
		border: 2px solid #000000;
		margin-top: 5px;
		top:50%;
		left:50%;
		margin-left:33%;
		
		display:flex;
		align-items:center;
		color: #00FFFF;
	}


	.preview_img{
		display:block;
		width:100%;
	}
</style>

</head>
<body bgcolor = "#ff7f00">
	<form method="POST" enctype="multipart/form-data" action = "/board/update">
		<table align = "center">
			<caption style = "color:#00FFFF;"><h1>추억 공유</h1></caption>
				<tr>
				<th>제목</th>
					<td>
						<input type = "text" placholder = "제목을 입력해주세요." name="title" required value="${voList[0].title}">
					</td>
				</tr>
		</table>
		<table align = "center" border = "1">	
			
			<tr colspan = "2">
				<th>
					<input type="button" onclick="sample5_execDaumPostcode()" value="추억의주소">
					 <input type="text" id="sample5_address" placeholder="추억의 주소" name="address" value="${voList[0].board_address}" >
					 <input type = "hidden" id = "addr_hidden" name="board_address" value="${voList[0].board_address}">
					 <input type = "hidden" name="boardid" value="${voList[0].boardid}">
				</th>
			<td>					
					 
					<input type = "file" id = "image_file" name="files">	
				</td>
			</tr>
		</table>
		<table>
				<div id = "preview_div" class = "preview_div">
					<img src="${contextPath}/resources/images/hotplace/${voList[0].filepath }" alt="추억의 사진" class = "preview_img">	
					<span class = "preview_span"></span>
					<input type = "hidden" id = "imgsrc">	
					<input type = "hidden" id = "lat" name="lat">	
					<input type = "hidden" id = "lng" name="lng">	
				</div> 
		</table>
		<table align = "left" style = "margin-left:33%">
			<tr>
				<th>필링</th>
				<td>
					<input type = "text" placeholder = "#당신의 감정을 적어주세요." style = "width:470px" name="feeling" value="${voList[0].feeling}">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<input type = "text" style = "width:470px; height:100px" name="detail" value="${voList[0].detail}">
				</td>
			</tr>
			<tr>
				<th></th>
				<td align = "center">
					<input type = "submit" value = "저장" >
					<input type =  "button" value = "초기화" onclick = "location.href = '/board'">
					<input type = "button" value = "메인으로" onclick = "location.href = '/kakao'">
				</td>
			</tr>
		</table>
	</form>
			 
		 	<div id="map" style="width:300px;height:300px;margin-top:10px;display:none" margin-top:50%></div>
		
	
</body>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bf2a48e2f31d722ff5972f0dca35a662&libraries=services"></script>
<script>

	document.addEventListener("DOMContentLoaded", function(){
		// Handler when the DOM is fully loaded
		settingAddress()
	});

	function settingAddress(){
		 var coords = new daum.maps.LatLng("${voList[0].lat}", "${voList[0].lng}");
         // 지도를 보여준다.
         mapContainer.style.display = "block";
         map.relayout();
         // 지도 중심을 변경한다.
         map.setCenter(coords);
         // 마커를 결과값으로 받은 위치로 옮긴다.
         marker.setPosition(coords)
	}
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
	    center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};
	
	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
	position: new daum.maps.LatLng(37.537187, 127.005476),
	map: map
	});
	
	
	function sample5_execDaumPostcode() {
	new daum.Postcode({
	    oncomplete: function(data) {
	        var addr = data.address; // 최종 주소 변수
	
	        // 주소 정보를 해당 필드에 넣는다.
	        document.getElementById("sample5_address").value = addr;
	        // 주소로 상세 정보를 검색
	        geocoder.addressSearch(data.address, function(results, status) {
	            // 정상적으로 검색이 완료됐으면
	            if (status === daum.maps.services.Status.OK) {
					
	                var result = results[0]; //첫번째 결과의 값을 활용
	                document.getElementById("lat").value = result.y;
	                document.getElementById("lng").value = result.x;
	                // 해당 주소에 대한 좌표를 받아서
	                var coords = new daum.maps.LatLng(result.y, result.x);
	                // 지도를 보여준다.
	                mapContainer.style.display = "block";
	                map.relayout();
	                // 지도 중심을 변경한다.
	                map.setCenter(coords);
	                // 마커를 결과값으로 받은 위치로 옮긴다.
	                marker.setPosition(coords)
	               document.getElementById('addr_hidden').value = addr;
	            }
	        });
	    }
	}).open();
	}
	
	const inpFile = document.getElementById("image_file");  			// input 타입 file 인것.
	const previewDiv = document.getElementById("preview_div");			// <div>
	const previewimg = previewDiv.querySelector(".preview_img");	// <img>
	const previewspan = previewDiv.querySelector(".preview_img"); // <span>
	
	inpFile.addEventListener("change",function(){
		const file = this.files[0];
		
		if(file){
			
			const reader = new FileReader();
			
			previewspan.style.display = "none";
			previewimg.style.display = "block";
			
			reader.addEventListener("load",function(){
				previewimg.setAttribute("src",this.result);	
			});
				reader.readAsDataURL(file);
				document.getElementById("imgsrc").value = previewimg.src;
				alert(previewimg.src);
		}
	});

</script>
</html>