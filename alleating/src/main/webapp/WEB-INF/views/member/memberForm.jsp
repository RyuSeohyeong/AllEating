<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
     <%
    request.setCharacterEncoding("utf-8");
    %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
	var userIdCheck = RegExp(/^[A-Za-z0-9]{6,16}$/); //아이디 유효성 검사
	var passwdCheck = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/); //비밀번호 유효성 검사
	var nameCheck = RegExp(/^[가-힣]{2,45}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,45}$/);//이름 유효성 검사 한글 또는 영문 사용하기(혼용X)
	$(function(){
	$('#alert-success').hide();
	$('#alert-danger').hide();
	$("input").keyup(function(){
		var pwd1 = $('#pwd1').val();
		var pwd2 = $('#pwd2').val();
		if(pwd1 !="" || pwd2 != ""){
			if(pwd1 == pwd2){
				$('#alert-success').show();
				$('#alert-danger').hide();
				$('#alert-success').addClass("greenText");
			}else{
				$('#alert-success').hide();
				$('#alert-danger').show();
				$('#alert-danger').addClass("redText");
			}
		}
	});

	$('#idCheckMessage').hide();
	
	$('#userId').keyup(function(){
		if(userIdCheck.test($('#userId').val())){
			$('#idCheckMessage').hide();
			$('#join_id_ex').show();
		}else{
			$('#join_id_ex').hide();
			$('#idCheckMessage').show();
			$('#idCheckMessage').text('6자 이상 16자 이하의 영문 혹은 영문과 숫자를 조합');
			$('#idCheckMessage').addClass('redText');
		}
	});
	$('#pwdCheckMessage').hide();
	$('#pwd1').keyup(function(){
		if(passwdCheck.test($('#pwd1').val())){
			$('#pwdCheckMessage').hide();
			$('#join_pwd_ex').show();
		}else{
			$('#join_pwd_ex').hide();
			$('#pwdCheckMessage').show();
			$('#pwdCheckMessage').text('영문/숫자/특수문자(공백제외)포함 8자 이상 20이하');
			$('#pwdCheckMessage').addClass('redText');
		}
	});

	$('#nameCheckMessge').hide();
	$('#join_name').keyup(function(){
		if(('#join_name').val() != " "){
			$('#nameCheckMessge').hide();
			$('#join_name_ex').show();
		}else{
			$('#join_name_ex').hide();
			$('#nameCheckMessge').show();
			$('#nameCheckMessge').text('이름을 입력해주세요');
			$('#nameCheckMessge').addClass('redText');
		}
	});
});
function fn_checkId(){ //아이디 중복체크
	var contextPath = getContextPath();
	var _id = $("#userId").val();
	if(_id==''){
		alert("아이디를 입릭하세요");
		return false;
	}
	$.ajax({
		type:"post",
		async:true,
		url:"/member/checkId.do",
		dataType:"text",
		data:{id:_id},
		success:function(data, textStatus){
			if(data=='usable'){
				$('#idCheckMessage').text("사용할 수 있는 ID입니다");
				$('#idCheckMessage').removeClass();
				$('#idCheckMessage').addClass("greenText");
			}else{
				$('#idCheckMessage').text("사용할 수 없는 ID입니다.");
				$('#idCheckMessage').removeClass();
				$('#idCheckMessage').addClass("redText");
			}
		},
		error:function(data, textStatus){
			alert("에러가 발생했습니다.");
		},
		complete:function(data, textStatus){
			
		}
	});
}
function fn_select(){
	var text = $('#email_select').val();
	if((text =='self') || (text=='choose')){
		$('#selects').val("");
		$('#selects').attr('disabled', false);
	}
	else{
		$('#selects').val(text);
		$('#selects').attr('disabled', true);
	}

	}
function fn_ownerInfoShow(){
	var joinType = $('.joinCheck:checked').val();
	console.log(joinType);
	if(joinType == 'owner'){
		$('.ownerInfo').css('display','block');
		$('.ownerInfoValue').attr('disabled', false);
	} else {
		$('.ownerInfo').css('display','none');
		$('.ownerInfoValue').attr('disabled', true);
		$('.ownerInfoValue').val("");
	}	
}

//이용약관 동의 체크박스
$(document).ready(function(){
//전체 체크박스 클릭
	$("#checkAll").click(function() {
		if ($("#checkAll").prop("checked")) {
			$(".testCheck").prop("checked", true);
		} else {
			$(".testCheck").prop("checked", false);
		}
	});
//전체 체크박스 선택중 체크박스 하나를 풀었을때 "전체" 체크해제
	$(".testCheck").click(function() {
		if ($(".testCheck:checked").length == 7) {
			$("#checkAll").prop("checked", true);
		} else {
			$("#checkAll").prop("checked", false);
		}
	});
});

//이메일 sms 수신동의 전체 체크
$(document).ready(function(){
//전체 체크박스 클릭
	$("#checkAll2").click(function() {
		if ($("#checkAll2").prop("checked")) {
			$(".testCheck2").prop("checked", true);
		} else {
			$(".testCheck2").prop("checked", false);
		}
	});
//전체 체크박스 선택중 체크박스 하나를 풀었을때 "전체" 체크해제
	$(".testCheck2").click(function() {
		if ($(".testCheck2:checked").length == 2) {
			$("#checkAll2").prop("checked", true);
		} else {
			$("#checkAll2").prop("checked", false);
		}
	});
});

function fn_loginGO(){
		var owner_name = document.getElementById('companyName').value;
		var owner_num = document.getElementById('companyNum').value;
		var owner_tel1 = document.getElementById('companyTel1').value;
		var owner_tel2 = document.getElementById('companyTel2').value;
		var owner_tel3 = document.getElementById('companyTel3').value;
	
	if($('.joinCheck').val() == 'owner'){
		if(owner_name==""){
			alert('사업장명을 입력해주세요');
			owner_name.focus();
			return false;
		}
		if(owner_num==""){
			alert('사업장 번호를 입력해주세요');
			owner_num.focus();
			return false;
		}
		if(owner_tel1==""){
			alert('사업장 번호를 입력해주세요');
			owner_tel1.focus();
			return false;
		}
		if(owner_tel2==""){
			alert('사업장 번호를 입력해주세요');
			owner_tel2.focus();
			return false;
		}
		if(owner_tel3==""){
			alert('사업장 번호를 입력해주세요');
			owner_tel3.focus();
			return false;
		}

	}
	location.href="${contextPath}/member/loginForm.do"
}
</script>
<link href="${contextPath}/css/join.css" rel="stylesheet" type="text/css" />
<style>
	
	#checkEamil{
		display: none;
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100">
<div class="input-form">
<form method="post" action="${contextPath }/member/addMember.do">
<div id="join_input">
	<div id="join_title">회원가입</div>
	<div id="join_Basic_input_text">
		<span class="redText">*</span>
		기본정보입력(필수)
	</div>
<!--회원 분류-->

	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">회원분류</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_radio">
				<input type="radio" class="form-check-input joinCheck" name="join_type" value="user" id="form_join_type"checked onchange="fn_ownerInfoShow()"/>
				<label class="form-check-label" for="form_join_type">
					일반회원
				</label>
				<input type="radio" class="form-check-input joinCheck" name="join_type" value="owner" id="form_join_type2" onchange="fn_ownerInfoShow()"/>
				<label class="form-check-label" for="form_join_type">
					사업자 회원
				</label>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--사업장 명 및 번호-->
	<div class="ownerInfo">
	<!--사업장 명-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">사업장 명</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box ownerInfoValue" name="owner_name" id="companyName" placeholder="사업장명을 입력해주세요" disabled/>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
<!--사업장 번호-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">사업장 번호</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box ownerInfoValue" name="owner_num"  id="companyNum" maxlength='10' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled/>
			</div>
			<span class="conditionText">"-"없이 사업자 번호 10자리 입력</span>
		</div>
		<div class="form_button_box"></div>
	</div>
	</div><!--사업장 명 및 번호-->
<!--아이디-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">아이디</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box" id="userId" name="id" placeholder="아이디를 입력해주세요"/>
			</div>
			<span class="conditionText" id="join_id_ex">6자 이상 16자 이하의 영문 혹은 영문과 숫자를 조합</span>
			<div id="idCheckMessage"></div>
		</div>
		<div class="form_button_box">
			<button class="btn btn-outline-secondary" type="button" id="idCheckBtn" onclick=" fn_checkId();">ID중복확인</button>
		</div>
	</div>
<!--비밀번호-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">비밀번호</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="password" class="form-control join_input_box" id="pwd1" name="pwd" placeholder="비밀번호를 입력해주세요"/>
			</div>
			<span class="conditionText" id="join_pwd_ex">영문/숫자/특수문자(공백제외)포함 8자 이상 20이하</span>
			<div id="pwdCheckMessage"></div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--비밀번호 확인-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">비밀번호 확인</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="password" class="form-control join_input_box"  id="pwd2" placeholder="비밀번호를 한번 더 입력해주세요"/>
			</div>
			<span id="alert-success">비밀번호가 일치합니다</span>
			<span id="alert-danger">비밀번호가 불일치합니다</span>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--이름-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">이름</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box" id="join_name" name="name" placeholder="이름을 입력해주세요"/>
			</div>
			<span class="hideConditionText redText" id="join_name_ex">이름을 입력해주세요</span>
			<div id="nameCheckMessge"></div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--이메일-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">이메일</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<div class="input-group">
					<input type="text" name="email1" id="userEmail" class="form_input form_email form-control join_input_box2" required/>
					<span class="input-group-text">@</span> 
					<input type="text" name="email2" id="selects"class="form_input form_email form-control join_input_box2" required="required"/>
				
					<select name ="email3" id="email_select" class="form-select" onchange="fn_select();">
						<option value="choose">이메일 선택</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="nate.com">nate.com</option>
						<option value="lycos.co.kr">lycos.co.kr</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="korea.com">korea.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="self">직접 입력</option>
					</select>
				</div>
			</div>
			<span class="hideConditionText redText">이메일을 입력해주세요</span>
		</div>
		<div class="form_button_box">
			<button class="btn btn-outline-secondary" type="button" id="idCheckEmailBtn" onclick=" fn_checkEamil();">이메일 인증</button>
		</div>
	</div>
	<div id="checkEamil">
	<!--이메일 인증-->
	<div class="form_info" id="emailNumCheckBok">
		<div class="form_label_box">
			<label class="form_label">인증번호 확인</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box"  id="email_check" name="emailCheck" placeholder="인증번호 6자리를 입력해주세요"/>
			</div>
			<span class="hideConditionText"></span>
		</div>
		<div class="form_button_box">
			<button class="btn btn-info" type="button" id="idCheckEmailNumBtn" onclick=" fn_checkNum();"><span class="emailNumBtn">인증번호 확인</span></button>
		</div>
	</div>
	</div>
	<!--휴대폰-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">휴대폰</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control phone join_input_box2" name="hp1" maxlength='3' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
				-
				<input type="text" class="form-control phone join_input_box2" name="hp2" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
				-
				<input type="text" class="form-control phone join_input_box2" name="hp3" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
			</div>
			<span class="hideConditionText redText">전화번호를 입력해주세요</span>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--사업장 전화번호-->
	<div class="ownerInfo">
	
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">사업장 전화번호</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control phone join_input_box2 ownerInfoValue" name="owner_tel1" id="companyTel1" maxlength='3' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled/>
				-
				<input type="text" class="form-control phone join_input_box2 ownerInfoValue" name="owner_tel2" id="companyTel2" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled/>
				-
				<input type="text" class="form-control phone join_input_box2 ownerInfoValue" name="owner_tel3" id="companyTel3" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled/>
			</div>
			<span class="hideConditionText redText">전화번호를 입력해주세요</span>
		</div>
		<div class="form_button_box"></div>
	</div>
	</div><!--사업장 전화번호-->
	<!--주소-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">주소</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control phone join_input_box2" id="sample6_postcode" name = "zipcode" placeholder="우편번호">
				<button class="btn btn-outline-secondary" type="button" id="idCheckBtn" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--나머지 주소-->
	<div class="form_info">
		<div class="form_label_box"></div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box2" id="sample6_address" name="address" placeholder="주소"><br>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<!--나머지 주소-->
	<div class="form_info">
		<div class="form_label_box"></div>
		<div class="form_value_box">
			<div class="form_input_box">
				<input type="text" class="form-control join_input_box2" id="sample6_extraAddress" name="address2" placeholder="참고항목">
				<input type="text" class="form-control join_input_box2" id="sample6_detailAddress" name="addressDetail" placeholder="상세주소">
			</div>
		</div>
	</div>
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">성별</label>
		</div>
		<div class="form_value_box">
			<div class="form_radio">
				<input type="radio" class="form-check-input" name="gender" value="man" id="form_join_type"/>
				<label class="form-check-label" for="form_join_type">
					남자
				</label>
				<input type="radio" class="form-check-input" name="gender" value="woman"id="form_join_type2" />
				<label class="form-check-label" for="form_join_type">
					여자
				</label>
				<input type="radio" class="form-check-input" name="gender" value="none" id="form_join_type2" checked/>
				<label class="form-check-label" for="form_join_type">
					선택없음
				</label>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
<!--생년월일-->
	<div class="form_info">
		<div class="form_label_box">
			<label class="form_label">생년월일</label>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<div id="join_birth_box">
					<input type="text" class="join_input_box2 join_input_birth" maxlength='4' name="birth_year" placeholder="YYYY"/>
					<span class="join_brith_bar">/</span>
					<input type="text" class="join_input_box2 join_input_birth" maxlength='2' name="birth_month" placeholder="MM"/>
					<span class="join_brith_bar">/</span>
					<input type="text" class="join_input_box2 join_input_birth" maxlength='2' name="birth_day" placeholder="DD"/>
				</div>
			</div>
		</div>
		<div class="form_button_box"></div>
	</div>
	<div class="join_bottom_bar"></div>

	<!--이용약관 동의-->
	<div class="form_agree_start">
	<div class="form_agree">
		<div class="form_label_box">
			<label class="form_label">이용약관동의</label>
			<span class="redText">*</span>
		</div>
		<div class="form_value_box">
			<div class="form_input_box">
				<div class="form_agree_box">
					<label class="form-check-label form_check_label"><input type="checkbox" class="form-check-input "  id="checkAll" /><!--전체 동의 체크박스-->
						<div class="form_label_text">
							<span>전체 동의합니다.</span>
						</div>
					</label>
					<p class="agree_box_text">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
				</div>
				<div class="form_agree_box">
					<label class="form-check-label form_check_label">
						<input type="checkbox" class="form-check-input testCheck"/><!--이용약관 동의(필수)-->
						<div class="form_label_text">
							<span>이용약관 동의</span>
							<span>(필수)</span>
						</div>
					</label>
					<div>
						<a>약관보기 <span>></span></a>
					</div>
				</div>
				<div class="form_agree_box">
					<label class="form-check-label form_check_label">
						<input type="checkbox" class="form-check-input testCheck"/><!--개인정보 수집 이용 동의(필수)-->
						<div class="form_label_text">
							<span>개인정보 수집·이용 동의</span>
							<span>(필수)</span>
						</div>
					</label>
					<div>
						<a>약관보기 <span>></span></a>
					</div>
				</div>
				<div class="form_agree_box">
					<label class="form-check-label form_check_label">
						<input type="checkbox" class="form-check-input testCheck" name="personalInformation"/><!--개인정보 수집 이용 동의 (선택)-->
						<div class="form_label_text">
							<span>개인정보 수집·이용 동의</span>
							<span>(선택)</span>
						</div>
					</label>
					<div>
						<a>약관보기 <span>></span></a>
					</div>
				</div>
				<div class="form_agree_box">
					<label class="form-check-label form_check_label">
						<input type="checkbox" class="form-check-input testCheck" id="checkAll2"/><!--sms 이메일 수신 전체 동의 체크박스-->
						<div class="form_label_text">
							<span>무료배송,할인쿠폰 등 혜택/정보 수신 동의</span>
							<span>(선택)</span>
						</div>
					</label>
				</div>
				<div class="form_agree_box2"style="padding-left: 100px;">
					<div class="form_yn_agree">
						<label >
							<input type="checkbox" class="form-check-input testCheck testCheck2" name="sms_yn" value="y"/><!--SMS 수신동의 (선택)-->
							<span>SMS</span>
						</label>
					</div>
					<div class="form_yn_agree">
						<label >
							<input type="checkbox" class="form-check-input testCheck  testCheck2" name="email_yn" value="y"/><!--이메일 수신 동의 (선택)-->
							<span>이메일</span>
						</label>
					</div>
				</div>
				<div class="form_agree_box">
					<label class="form-check-label form_check_label">
						<input type="checkbox" class="form-check-input testCheck"/><!--14세이상 체크 (필수)-->
						<div class="form_label_text">
							<span>본인은 만14세 이상입니다.</span>
							<span>(필수)</span>
						</div>
					</label>
				</div>
			</div>
		</div>
	</div>
	</div><!--이용약관 동의 끝-->
	<div class="form_end">
		<button class="join_end_btn" onclick="fn_loginGO()">
			<span id="join_btn_text">가입하기</span>
		</button>
	</div>
</div>
	</form>
</div>
</body>
</html>