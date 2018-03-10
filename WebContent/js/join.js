$(function() {
	$("#file_hidden").on( "change", function() {
        var formData = new FormData();

        formData.append("profile", $("input[name=file]")[0].files[0]);
        formData.append("id", memberId);

        $.ajax({
            type : "post",
            url : "joinProfile",
            data : formData,
            dataType : "text",
            contentType : false,
            processData : false,
            success : function(result) {
                if (result == "fail") {
//                    alert("프로필 사진 업로드 실패!");
                } else {
                	$("#profileImg").attr("src", "../profileImg/" + result);
                	location.reload(true);
                }
            }
        });
	});

	$("#memberIdTx").on("blur", function() {
		var id = $("#memberIdTx").val();

		$.ajax({
			url : "../log/joinIdCheck",
			data : {
				memberId : id
			},
			type : "post",
			dataType : "text",
			success : function(data) {
				if (data == 'true') {
					$('#idCheck').html('사용 가능한 아이디입니다.');
					$("#joinNextBtn").prop("disabled", false);

				} else if (data == 'false' || data == null) {
					$('#idCheck').html('사용 불가능한 아이디입니다.');
					$("#joinNextBtn").prop("disabled", true);
				}

			}

		});
	});

	$("#memberEmailTx").on("blur", function() {
		var id = $("#memberId").val();
		var email = $("#memberEmailTx").val();

		$.ajax({
			url : "../log/joinEmailCheck",
			data : {
				memberId : id,
				memberEmail : email
			},
			type : "post",
			dataType : "text",
			success : function(data) {
				if (data == 'true') {
					$('#emailCheck').html('사용 가능한 이메일입니다.');
					$("#joinNextBtn").prop("disabled", false);

				} else {
					$('#emailCheck').html('사용 불가능한 이메일입니다.');
					$("#joinNextBtn").prop("disabled", true);
				}
			}
		});
	});
});

function join_checkPw() {
	var memberPass = document.getElementById("memberPass").value;
	var memberPassCheck = document.getElementById("memberPassCheck").value;

	if (memberPass != memberPassCheck) {
		document.getElementById("pwCheck").innerHTML = "비밀번호가 같지 않습니다."
		$("#joinNextBtn").prop("disabled", true);
	}
	if (memberPass == "") {
		document.getElementById("pwCheck").innerHTML = "비밀번호를 입력해주세요."
		$("#joinNextBtn").prop("disabled", true);
	}
	if (memberPassCheck == "") {
		document.getElementById("pwCheck").innerHTML = "비밀번호를 입력해주세요."
		$("#joinNextBtn").prop("disabled", true);
	}
	if (memberPass == memberPassCheck) {
		document.getElementById("pwCheck").innerHTML = ""
		$("#joinNextBtn").prop("disabled", false);
	}
}

function joinSubmit() {
	var idCheck = $("#idCheck").text();
	var emailCheck = $("#emailCheck").text();

	if (document.joinForm.memberId.value.length == 0) {
	    alert("아이디를 입력해주세요.");
	    return false;
	}
	if (document.joinForm.memberPass.value.length == 0) {
	    alert("비밀번호를 입력해주세요.");
	    return false;
	}
	if (document.joinForm.memberPassCheck.value.length == 0) {
	    alert("비밀번호 체크란을 입력해주세요.");
	    return false;
	}
	if (document.joinForm.memberName.value.length == 0) {
	    alert("이름을 입력해주세요.");
	    return false;
	}
	if (document.joinForm.memberEmail.value.length == 0) {
	    alert("이메일을 입력해주세요.");
	    return false;
	}
	if (idCheck == "") {
	    alert("아이디 중복확인을 해주세요");
	    return false;
	}
	if (emailCheck == "") {
	    alert("이메일 중복확인을 해주세요");
	    return false;
	}
}