<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" type="text/css" href="/resources/css/hotplace/join.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body bgcolor = "#ff7f00">
	<form name = "joinForm" action = "/member/join">
		<div align = "center" style = "color: #00FFFF ;">
			<caption><h1>회원가입 페이지</h1></caption>
		</div>
			<table align = "center">				
				<div class="login">
	    			<input type="text" placeholder="email 입력해주세요" id="email" name="email" required>  
	 	    		<input type="password" placeholder="비밀번호 입력해주세요" id="password1" name="password1" required>
	 	    		<input type = "password" placeholder = "다시 비밀번호 입력해주세요" id="password2" required> 
	 	    		<input type = "hidden" id="password" name="password"> 
	 	    		<input type = "hidden" id="phone" name="phone"> 
	 	   			<input type = "text" placeholder = "닉네임입력" id = "nickname" name = "nickname" required>
	 	   			
	 	   			<input type="tel" id="msgFrom" name="msgFrom" placeholder=" 전화번호 입력 ( '-' 포함 )" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required>
	 	   			<span id="sendBtn" style="color: green; font-weight: bold;"><input type="button" value="SMS 전송 (문자보내기)" onclick="doSms()"></span>
					<ul style="display: none;" id="smsUl">
						<div>
							<span>타이머</span>&nbsp;&nbsp;<span id="timer"></span>
						</div>
	 	   				<input type="number" id="msg" name="msg" placeholder="인증 번호" maxlength="6" oninput="maxLengthCheck(this)">
	 	   				<input type="button" onclick="sendSmsCheck()" value="인증번호 확인" /><br/>
					</ul>
	 	   			
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
					<input type="text" id="sample4_detailAddress" placeholder="상세주소">
	 	 			<input type="button" value="가입" onclick = "join()">
	 	 			<input type = "button" value = "메인으로"onclick = "location.href = '/kakao'"> 	 			
					<span id="guide" style="color:#999;display:none"></span>
					<input type = "hidden" id = "address_hiddes" name = "address"> 	 	
							<!-- 지금은 사용 안하는 목록 ( 이 목록을 안쓴다고 삭제하면 javascript 에서 에러가 남 ) --> 
					<input type="text" id="sample4_postcode" placeholder="우편번호" style = "display:none">
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소" style = "display:none">
				    <input type="text" id="sample4_extraAddress" placeholder="참고항목" style = "display:none">
								 			
				</div>
			<div class="shadow"></div>
			</table>
	</form>
	<script>
	// 가입버튼을 누르면은 PW1 과 PW2 를 비교하여 맞으면은 submit() 해주는 기능
	function join(){
		var pw1 = document.getElementById("password1").value;
		var pw2 = document.getElementById("password2").value;
		var email = document.getElementById("email").value;
		var nickname = document.getElementById("nickname").value;
		var sample4_jibunAddress = document.getElementById("sample4_jibunAddress").value;
		var sample4_detailAddress = document.getElementById("sample4_detailAddress").value;
	
		if(pw1 != pw2){
			alert("비밀번호가 다릅니다.")
		}else if(pw1 =="" || email == "" || nickname == ""){
			alert("정보를 입력해주세요.");
		}else{
			document.getElementById("address_hiddes").value = sample4_jibunAddress + " " + sample4_detailAddress;			
			password.value = pw1;
			phone.value = msgFrom.value; 
			joinForm.submit();
		}
	}
	
	  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
			    var extraRoadAddr = ''; // 참고 항목 변수

	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
               		extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              	}
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
	}
		
	function doSms(){
		
		if(!msgFrom.value){
			alert("전화번호를 입력해주세요.");
			return;
		}
		smsUl.style.display = 'block';

		//타이머 
		var AuthTimer = new $ComTimer()
		AuthTimer.comSecond = 180;
		AuthTimer.fnCallback = function(){alert("다시인증을 시도해주세요.")}
		AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000);
		AuthTimer.domId = document.getElementById("timer");
		
		sendSMS();
	}
	
	function sendSMS(){
		
		// XMLHttpRequest 객체의 생성
		const xhr = new XMLHttpRequest();
		// 비동기 방식으로 Request를 오픈한다
		xhr.open('POST', '/sendSms', true);
		// 클라이언트가 서버로 전송할 데이터의 MIME-type 지정: json
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

		xhr.onload = function (e) {
		  if (xhr.readyState === 4) {
		    if (xhr.status === 200) {
		    	debugger;
		    	alert("전송되었습니다.");
		      console.log(xhr.responseText);
		    } else {
		    	alert("전송에 실패하였습니다. \n(문의 번호 : 1588-9999).");
		    	debugger;
		      console.error(xhr.statusText);
		    }
		  }
		};
		
		xhr.onerror = function (e) {
		  console.error(xhr.statusText);
		};
		
		const data = { phone_number : msgFrom.value };
// 		const data = new FormData();
// 		data.append(phone_number, msgFrom.value);
		xhr.send(JSON.stringify(data));
	}

	//인증번호 체크
	function sendSmsCheck(){
		
		if(!msg.value){
			alert("문자로 전송된 인증번호를 입력해주세요.");
			return;
		}
		
		// XMLHttpRequest 객체의 생성
		const xhr = new XMLHttpRequest();
		// 비동기 방식으로 Request를 오픈한다
		xhr.open('POST', '/sendSms/check', true);
		// 클라이언트가 서버로 전송할 데이터의 MIME-type 지정: json
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

		xhr.onload = function (e) {
		  if (xhr.readyState === 4) {
		    if (xhr.status === 200) {
		    	debugger;
		      console.log(xhr.responseText);
		      var data = JSON.parse(xhr.responseText);
		      if(data.status){
		    	  var data = JSON.parse(xhr.responseText);
		    	  console.log("인증 후 >> " + data);
		    	  if(data.status){
		    	  	alert("인증 되었습니다.");
		    	  	smsUl.style.display = 'none';
		    	  	sendBtn.style.display = 'none';
		    	  }else{
		    	      alert("인증번호를 다시 확인해주세요.");
		    	  }
		      }
		    } else {
		    	debugger;
		    	alert("인증에 실패하였습니다.");
		      console.error(xhr.statusText);
		    }
		  }
		};
		
		xhr.onerror = function (e) {
		  console.error(xhr.statusText);
		};
		
		const data = { phone_number : msgFrom.value , msg : msg.value};

		xhr.send(JSON.stringify(data));
	}
	
	//타이머 전역 변수
	function $ComTimer(){
	    //prototype extend
	}

	$ComTimer.prototype = {
	    comSecond : ""
	    , fnCallback : function(){}
	    , timer : ""
	    , domId : ""
	    , fnTimer : function(){
	        var m = Math.floor(this.comSecond / 60) + "분 " + (this.comSecond % 60) + "초";	// 남은 시간 계산
	        this.comSecond--;					// 1초씩 감소
// 	        console.log(m);
	        this.domId.innerText = m;
	        if (this.comSecond < 0) {			// 시간이 종료 되었으면..
	            clearInterval(this.timer);		// 타이머 해제
	            alert("인증시간이 초과하였습니다. 다시 인증해주시기 바랍니다.")
	        }
	    }
	    ,fnStop : function(){
	        clearInterval(this.timer);
	    }
	}
		
	function maxLengthCheck(object){
	    if (object.value.length > object.maxLength){
	      object.value = object.value.slice(0, object.maxLength);
	    }    
	}
		
	</script>
</body>
</html>