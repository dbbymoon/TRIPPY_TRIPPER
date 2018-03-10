$(function() {

	/* 시작 MyInfo**************************************************************************** */
	$("#file_hidden").on("change", function() {
		var memberId = $("#memberIdVal").text();
		var formData = new FormData();
		formData.append("profile", $("input[name=file]")[0].files[0]);
		formData.append("id", memberId);

		$.ajax({
			type : "POST",
			url : "../tMember/updateProfile",
			data : formData,
			dataType : "text",
			contentType : false,
			processData : false,
			success : function(result) {
				if (result=="fail") {
//					alert("프로필 사진 수정 실패!");
				} else {
//					alert("프로필 사진 수정 완료!");
					$("#profileImg").attr("src", "../profileImg/" + result);
					location.reload(true);
					
				}
			}
		});
	});

	$("#memberBirth").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
		dateFormat : 'YYMMdd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
		,
		buttonImageOnly : true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		,
		changeMonth : true // 월선택 select box 표시 (기본은 false)
		,
		changeYear : true // 년선택 selectbox 표시 (기본은 false)
		,
		showButtonPanel : true
	// 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});

	$("#updateBtn").on("click", function() {
		var id = $("#memberIdVal").text();
		var pass = $("#memberPassCheck").val();
		var passCheck = $("#memberPassCheck").val();
		var name = $("#membername").val();
		var nick = $("#memberNick").val();
		var email = $("#memberEmail").val();
		var phoneNum = $("#memberPhoneNum").val();
		var birth = $("#memberBirth").val();
		var gender = $("#memberGender option:selected").val();
		var intro = $("#memberIntro").val();
		var secret = $("#membersecret option:selected").val();

		if (pass == '' || passCheck == '') {
			swal({title: 'Error!',text: '비밀번호를 입력해주세요.',type: 'error',confirmButtonText: 'OK',});
			return false;
		}

		$.ajax({
			type : "post",
			url : "myInfoUpdate",
			data : {
				memberId : id,
				memberPass : pass,
				memberPassCheck : passCheck,
				memberName : name,
				memberNick : nick,
				memberEmail : email,
				memberPhoneNum : phoneNum,
				memberBirth : birth,
				memberGender : gender,
				memberIntro : intro,
				memberSecret : secret
			},
			dataType : "text",
			success : function(data) {
				if (data != null && data == "success") {
					swal({title: 'Success!',text: '회원정보 수정 완료',type: 'success',confirmButtonText: 'OK',}).then(function(){
						window.location.replace('../tMember/myInfo');
					});
				} else if (data == "fail") {
					swal({title: 'Error!',text: '비밀번호를 확인해주세요.',type: 'error',confirmButtonText: 'OK',});
					window.location.replace('../tMember/myInfo');
				}
			},
			error : function() {
				swal({title: 'Error!',text: '회원정보 수정 실패',type: 'error',confirmButtonText: 'OK',});
				window.location.replace('../tMember/myInfo');
			}

		});

	});

	$("#deleteBtn").on("click", function() {
		var id = $("#memberIdVal").text();
		var pw = $("#memberPass").val();
		var pwCheck = $("#memberPassCheck").val();

		if (pw == '' || pwCheck == '') {
			swal({title: 'Error!',text: '비밀번호를 입력해주세요.',type: 'error',confirmButtonText: 'OK',});
			return false;
		}

		$.ajax({
			url : "../tMember/myInfoPassCheck",
			data : {
				memberId : id,
				memberPass : pw,
				memberPassCheck : pwCheck
			},
			type : "post",
			dataType : "text",
			success : function(data) {
				if (data != null && data == "success") {
					swal({title: 'SUCCESS!',text: '탈퇴하였습니다.',type: 'success',confirmButtonText: 'OK',}).then(function(){location.reload(true)});
					window.location.replace('../log/login');

				} else if (data == "fail") {
					swal({title: 'Error!',text: '비밀번호를 확인해주세요.',type: 'error',confirmButtonText: 'OK',});
					window.location.replace('../tMember/myInfo');
				}
			},
			error : function() {
				swal({title: 'Error!',text: '회원탈퇴 실패',type: 'error',confirmButtonText: 'OK',});
				window.location.replace('../tMember/myInfo');
			}
		});
	});
	/* 끝 MyInfo**************************************************************************** */
	
	/* 시작 MyCompanionList****************************************************************** */
	
	$("#decidedCompanion").on("click",function(){
		var table = $("#CompanionConditionList");
		$("tr",table).remove();
		var matchingType='2';
		
		$.ajax({
			url : "../tMember/myCompanionByType",
			data : {
				memberId:memberId,
				matchingType:matchingType
			},
			type : "post",
			dataType : "json",
			success : function(companionList) {
				for(var i in companionList){
					var tourDate = new Date(companionList[i].tourDate);
					var tourDate_year = tourDate.getYear()+1900;
					var tourDate_month = tourDate.getMonth()+1;
					var tourDate_date = tourDate.getDate();
					var tourDate_str = tourDate_year+'/'+tourDate_month+'/'+tourDate_date;
					var tr=$("<tr>");
					
					if(companionList[i].memberId != memberId){
						var seq = companionList[i].memberId;
						$("<td id='myCompanionMemberProfile' class='myCompanionList' height='80px' width='80px' align='center'>").html('<img src="../profileImg/' + companionList[i].memberProfile +'" class="myCompanionProfile"/>').appendTo(tr);
						$("<td id='myCompanionMemberId' class='myCompanionList' width='120px' align='left'>").text(companionList[i].memberId).appendTo(tr);
						$("<td id='myCompanionTourDate' class='myCompanionList' width='100px' align='center'>").text(tourDate_str).appendTo(tr);
						$("<td id='myCompanionDeparture' class='myCompanionList' width='400px' align='center'>").text(companionList[i].departure).appendTo(tr);
						$("<td id='myCompanionDestination' class='myCompanionList' width='400px' align='center'>").text(companionList[i].destination).appendTo(tr);
						$("<td>").html('<button class="CompanionListDeleteBtn" onclick="delMyCompanion('+seq+')">cancel</button>').appendTo(tr);
						tr.appendTo(table);
					}
				}	
			},
			error : function() {
			}			
		});
	});
	
	$("#waitingCompanion").on("click",function(){
		var table = $("#CompanionConditionList");
		$("tr",table).remove();
		var matchingType='1';
		
		$.ajax({
			url : "../tMember/myCompanionByType",
			data : {
				memberId:memberId,
				matchingType:matchingType
			},
			type : "post",
			dataType : "json",
			success : function(companionList) {
				for(var i in companionList){
					var tourDate = new Date(companionList[i].tourDate);
					var tourDate_year = tourDate.getYear()+1900;
					var tourDate_month = tourDate.getMonth()+1;
					var tourDate_date = tourDate.getDate();
					var tourDate_str = tourDate_year+'/'+tourDate_month+'/'+tourDate_date;
					
					var tr=$("<tr>");
					
					if(companionList[i].memberId != memberId){
						var seq = companionList[i].companionSeq;
						$("<td id='myCompanionMemberProfile' class='myCompanionList' height='80px' width='80px' align='center'>").html('<img src="../profileImg/' + companionList[i].memberProfile +'" class="myCompanionProfile"/>').appendTo(tr);
						$("<td id='myCompanionMemberId' class='myCompanionList' width='120px' align='left'>").text(companionList[i].memberId).appendTo(tr);
						$("<td id='myCompanionTourDate' class='myCompanionList' width='100px' align='center'>").text(tourDate_str).appendTo(tr);
						$("<td id='myCompanionDeparture' class='myCompanionList' width='400px' align='center'>").text(companionList[i].departure).appendTo(tr);
						$("<td id='myCompanionDestination' class='myCompanionList' width='400px' align='center'>").text(companionList[i].destination).appendTo(tr);
						$("<td>").html('<button class="CompanionListDeleteBtn" onclick="delMyCompanion('+seq+')">cancel</button>').appendTo(tr);
						tr.appendTo(table);
					}
				}
			},
			error : function() {
			}			
		});
	});
	/* 끝 MyCompanionList****************************************************************** */
	
});

/* 시작 MyInfo**************************************************************************** */
function myInfo_checkPw() {
	var memberPass = document.getElementById("memberPass").value;
	var memberPassCheck = document.getElementById("memberPassCheck").value;

	if (memberPass != memberPassCheck) {
		document.getElementById("pwCheck").innerHTML = "비밀번호가 같지 않습니다."
		$("#updateBtn").prop("disabled", true);
		$("#deleteBtn").prop("disabled", true);
	}
	if (memberPass == "") {
		document.getElementById("pwCheck").innerHTML = "비밀번호를 입력해주세요."
		$("#updateBtn").prop("disabled", true);
		$("#deleteBtn").prop("disabled", true);
	}
	if (memberPassCheck == "") {
		document.getElementById("pwCheck").innerHTML = "비밀번호를 입력해주세요."
		$("#updateBtn").prop("disabled", true);
		$("#deleteBtn").prop("disabled", true);
	}
	if (memberPass == memberPassCheck) {
		document.getElementById("pwCheck").innerHTML = ""
		$("#updateBtn").prop("disabled", false);
		$("#deleteBtn").prop("disabled", false);
	}
}

function myInfoBtnClick() {

	if (document.myInfoForm.memberPass.value.length == 0) {
		swal({
			  title: 'error!',
			  text: '비밀번호를 입력해주세요.',
			  type: 'error',
			  confirmButtonText: 'OK',
		})
		return false;
	}
	if (document.myInfoForm.memberPassCheck.value.length == 0) {
		swal({
			  title: 'error!',
			  text: '비밀번호 확인란을 입력해주세요.',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
		return false;
	}

	return true;
}
/* 끝 MyInfo**************************************************************************** */

/* 시작 MyCompanionList****************************************************************** */
//MyCompanion에서 내가 요청한 동행을 삭제하는 기능
function delMyCompanion(companionSeq){
	
	$.ajax({
		url : "../tMember/deleteMyCompanion", //글을 작성하기 위한 요청명 입력
		type : "get",
		data:{
			companionSeq:companionSeq,
			memberId:memberId
		},
		datatype :"json",
		success : function(result){
			if(result == "SUCCESS"){
				swal({
					  title: 'Success!',
					  text: '동행을 취소하였습니다.',
					  type: 'success',
					  confirmButtonText: 'OK',
				}).then(function(){
					$("#modDivModify").hide("slow");
					location.reload(true);
				});
			}
		},
		error : function(){
			swal({
				  title: 'error!',
				  text: '취소할 수 없습니다.',
				  type: 'error',
				  confirmButtonText: 'OK',
			}).then(function(){
				$("#modDivModify").hide("slow");
			});
		}
	});
}

/* 끝 MyCompanionList****************************************************************** */
