$(function() {

	// 사진을 클릭하면 디테일 모달창이 화면에 보임
	$(".myDiaryImg").on("click", function() {
	    $("#modDiaryDiv").show("slow");
	});
	
	
	// 버튼이 눌리면  디테일 모달창이 닫힘
	$("#diaryCloseBtn").on("click",function() {
		//modal창이 꺼지면 모든 이미지 삭제 해주어야함
		$("#modDiaryImg").empty();
	    $("#modDiaryDiv").hide("slow");
	});
	
	
	// Image View Modal창에서 'M'버튼을 누르면 화면에 보임
	$("#diaryModifyBtn").on("click", function() {
	    $("#modDiaryModifyDiv").show("slow");
	});
		
	
	// 버튼이 눌리면  디테일 모달창이 닫힘
	$("#diaryViewModifyCloseBtn").on("click",function() {
	    $("#modDiaryModifyDiv").hide("slow");
	});	

	
	$("#recordDate").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
		dateFormat : 'YYMMdd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
		, buttonImageOnly : true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		, changeMonth : true // 월선택 select box 표시 (기본은 false)
		, changeYear : true // 년선택 selectbox 표시 (기본은 false)
		, showButtonPanel : true
	// 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
	
	
	$("#recordModifyDate").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
		dateFormat : 'YYMMdd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
		, buttonImageOnly : true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		, changeMonth : true // 월선택 select box 표시 (기본은 false)
		, changeYear : true // 년선택 selectbox 표시 (기본은 false)
		, showButtonPanel : true
	});
	
	
	// 다이어리를 수정폼을 띄우는 함수
	$("#diaryModifyBtn").on("click", function() {
		var recordSeqNum = $("#recordSeqNum").text();
		
		$.ajax({
			type: "GET",
			url: "../tripRecord/myDiaryModifyForm/"+recordSeqNum,
			data: recordSeqNum,
			dataType: "json",
			success: function(result) {	
				var recordDate = new Date(result.recordContent.recordDate);
				var recordDate_str = recordDate.getFullYear()+ '/' + (recordDate.getMonth()+1) + '/' + recordDate.getDate();


				if (result.attachFiles != null) {
					for (var i in result.attachFiles){
						$("#modDiaryViewImg").attr("src", "../diaryImg/"+result.attachFiles[i].fileName);
					}	
					
					$('#recordModifyDate').val(recordDate_str);
					$('#recordModifySpot').val(result.recordContent.recordSpot);
					$('#recordModifyContent').text(result.recordContent.recordContent);
					$('#recordModifySeq').text(result.recordContent.recordSeq);
				} 
			},
			error: function(){
			}
		});
	});
	
	
	// 다이어리 수정 요청
	$("#diaryViewModifyBtn").on("click", function(){
		
		var recordSeqNum = $("#recordSeqNum").text();		
		var modifyDate = $("#recordModifyDate").val();
		var modifySpot = $("#recordModifySpot").val();
		var modifyContent = $("#recordModifyContent").val();
		var modifySecret = $("#recordModifySecret option:selected").val();
		var memberId = $("#myId").text();	
		
		if (modifyContent == '') {
			swal({title: 'Error!',text: '내용을 입력해주세요.',type: 'error',confirmButtonText: 'OK',});
			return false;

		} else if (modifySpot == '') {
			swal({title: 'Error!',text: '여행장소를 입력해주세요.',type: 'error',confirmButtonText: 'OK',});
			return false;

		} else if (modifyDate == '') {
			swal({title: 'Error!',text: '여행날짜를 입력해주세요.',type: 'error',confirmButtonText: 'OK',});
			return false;
		} 
		
		$.ajax ({
			type: "GET",
			url: "../tripRecord/myDiaryModify",
			data : {
				recordSeq : recordSeqNum,
				recordDate : modifyDate,
				recordSpot : modifySpot,
				recordContent : modifyContent,
				recordSecret : modifySecret,
				memberId : memberId
			},
			dataType : "text",
			success: function(data) {
				
				if (data == 'success') {
//					alert("수정 완료!");
					$("#modDiaryModifyDiv").hide("slow");
					$("#modDiaryDiv").hide("slow");
					
				} else {
//					swal({title: 'Error!',text: '실패',type: 'error',confirmButtonText: 'OK',});
				}
			},
			error: function() {
//				alert("Modify Error!");
			} 
		});
	});
	

});


// 다이어리 뷰를 띄우는 함수
function myDiaryView(recordSeq, memberProfile, memberId) {
	
	$.ajax({
		type: "GET",
		url: "../tripRecord/myDiaryView/"+recordSeq,
		data: recordSeq,
		dataType: "json",
		success: function(result) {
			var recordDate = new Date(result.tripRecord.recordDate);
			var recordDate_str = recordDate.getFullYear()+ '/' + (recordDate.getMonth()+1) + '/' + recordDate.getDate();
			
			var li = $("#modDiaryImg");
			if (result.fileList != null) {
				for (var i in result.fileList) {
					$('<img src="../diaryImg/'+result.fileList[i].fileName+'" class="mySlides">').appendTo(li);
				}
				
				// 사진이 2장 이상이면 버튼 생성
				if (result.fileList.length >= 2) {
					$('<button id="prevBtn" onclick="plusDivs(-1)">&#10094;</button>').appendTo(li);
					$('<button id="nextBtn" onclick="plusDivs(+1)">&#10095;</button>').appendTo(li);					
				}

				showDivs(slideIndex);
				
				// 내가 작성한 글이 아니면 수정, 삭제버튼이 보이지 않음
				if (result.memberInfo.memberId != memberId) {
					$("#diaryModifyBtn").remove();
					$("#diaryDeleteBtn").remove();
				}
				
		        $('#myId').text(memberId);
		        $('#modMyProfile').html('<img src="../profileImg/'+memberProfile+'" class="modDairyProfileImg">');
		        $('.modDairyProfileImg').attr("style", "float: left; width: 65px; height: 65px;margin: 10px; border-radius: 50%;");
				
				$('#recordSeqNum').text(result.tripRecord.recordSeq);
				$('#recordContentInView').text(result.tripRecord.recordContent);
				$('#recordDate').text(recordDate_str);
				$('#recordLocation').text(result.tripRecord.recordSpot);
				
				
				if (result.tripRecord.recordSecret == 'private') {
					// private
					$("#modSecretImg").attr("src", "../img/lock.png");
					$("#modSecretImg").attr("style", "width:18px; height:18px;");
				} else {
					// public
					$("#modSecretImg").attr("style", "width:20px; height:20px; visibility:hidden;");
				}
				
				$("#viewReplyTable").empty();
				getReplyList();
				
			}
		},
		error: function(){
//			alert("Error!");
		}
	});
}


// 다이어리를 삭제하는 함수
function myDiaryDelete() {
	var recordSeq = $("#recordSeqNum").text();
	
	$.ajax({
		type: "GET",
		url: "../tripRecord/myDiaryDelete/"+recordSeq,
		dataType: "text",
		success: function(result) {	
			if (result == 'success') {
//				alert("삭제가 완료되었습니다.");
				location.reload(true);
			} else {
//				alert("삭제 실패!");
			}
		},
		error: function(){
//			alert("Delete Error!");
		}
	});
	
}

var slideIndex = 1;

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = $(".mySlides");
  if (n > x.length) {
	  slideIndex = 1
  }    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}

function getReplyList(){
	var recordSeq = $("#recordSeqNum").text();
	var table = $("#viewReplyTable");
	
	$.ajax({
		url : "../tReply/getReplyList", //글을 작성하기 위한 요청명 입력
		type : "post",
		datatype :"json",
		data : {
			recordSeq:recordSeq
		},
		success : function(replyList){
			
			for(var i in replyList){
				var tr = $("<tr>");
				var deleteReply = $("<button class='replyBtn'>X</button>");
				var ReplyOfReplyBtn = $("<button class='replyBtn'><img src='../img/arrow.png' width='10px'></button>");
				
				var replyDate = new Date(replyList[i].replyDate);
				var replyDate_year = replyDate.getYear()-100;
				var replyDate_month = replyDate.getMonth()+1;
				var replyDate_date = replyDate.getDate();
				var replyDate_str =replyDate_year+'/'+replyDate_month+'/'+replyDate_date;

				if(replyList[i].depth != 0){
					$("<td class='replytable replytableMemberProfileRoR'>").html('<img src="../img/arrow.png" width="10px"> <img src="../profileImg/' + replyList[i].memberProfile +'" class="replyProfile"/>').appendTo(tr);	//대댓글 버튼
				}else{

					$("<td class='replytable replytableMemberProfile'> ").html('<img src="../profileImg/' + replyList[i].memberProfile +'" class="replyProfile" style="float:right;"/>').appendTo(tr);	//프로필사진
				}
				
				$("<td class='replytable' style='display:none'> ").text(replyList[i].tReplySeq).appendTo(tr);	//전체 댓글 번호
				$("<td class='replytable' style='display:none'> ").text(replyList[i].replyNum).appendTo(tr);	//댓글 번호
				$("<td class='replytable replytableId'>").text(replyList[i].memberId).appendTo(tr);	//아이디
				$("<td class='replytable replytableContent'>").text(replyList[i].replyContent).appendTo(tr);	//내용
//				$("<td class='replytable replytableDate'>").text(replyDate_str).appendTo(tr);	//날짜
				if(replyList[i].depth == 0){
					$("<td align='center'>").append(ReplyOfReplyBtn).appendTo(tr);	//대댓글 버튼
				}
				
				if(replyList[i].memberId == memberId){
					$("<td align='center'>").append(deleteReply).appendTo(tr);		//삭제 버튼
				}
				tr.appendTo(table);
			
				//삭제
				(function(i){
					deleteReply.on("click",function(){
						var tReplySeq = replyList[i].tReplySeq;
						$.ajax({
							url : "../tReply/deleteReply/"+tReplySeq, 
							type : "get",
							datatype :"text",
							success : function(result){
								if("SUCCESS"==result){
									location.reload(true);
								}
							}
						 });						 
					});
				})(i);
			
				(function(i){
					ReplyOfReplyBtn.on("click",function(){
						var reContent = $("#reContent");

						reContent.val("@"+replyList[i].memberId+" ");
						$("#saveReplyNum").text(replyList[i].replyNum);				
					});
				})(i);
			}		
		},
		error : function(){
			
		}
	});
}



var modMenu = false;
function memberInfoBtn(memberId, type) {
	if (!modMenu) {
	    // 메뉴 열기
	    $("#modMenu").show("slow");
	    modMenu = true;
	} else {
	    // 메뉴 닫기
	    $("#modMenu").hide("slow");
	    modMenu = false;
	}
	
	
	// 멤버 정보 보기 close 버튼 
	$("#modInfoViewCloseBtn").click(function() {
	    $("#modInfoView").hide("slow");
	    $("#modMenu").hide("slow");
	    modMenu = false;
	});
	
	var viewProfileBtnURL;
	var viewDiaryBtn;
	
	if(type==1){
		viewProfileBtnURL="tripRecord/memberInfoView/"+memberId;
		viewDiaryBtn='tripRecord/memberDiaryView?memberId='+memberId;
		viewProfileURL="profileImg/";
		
	}else if(type==2){
		viewProfileBtnURL="../memberInfoView/"+memberId;
		viewDiaryBtn='../memberDiaryView?memberId='+memberId;
		viewProfileURL="../profileImg/";
	}
	
	// 멤버 정보 보기 
	$("#viewProfileBtn").click(function() {
	    $("#modInfoView").show("slow");
	    $.ajax({
	        type: "GET",
	        url: viewProfileBtnURL,
	        data: memberId,
	        dataType: "json",
	        success: function(result) {
	            var birth = new Date(result.memberBirth);
	            var memberBirth_str = birth.getFullYear()+ '/' + (birth.getMonth()+1) + '/' + birth.getDate();
	
	            if (result.memberSecret == "public" || result.memberSecret == "on") {
	                $("#viewMemberProfile").attr("src", viewProfileURL+result.memberProfile);
	                $("#viewMemberId").text(result.memberId);
	                $("#viewMemberName").text(result.memberName);
	                $("#viewMemberEmail").text(result.memberEmail);
	                $("#viewMemberBirth").text(memberBirth_str);
	                $("#viewMemberGender").text(result.memberEmail);
	                $("#viewMemberIntro").text(result.memberIntro);
	            } else {
	                $("#viewMemberProfile").attr("src", viewProfileURL+result.memberProfile);
	                $("#viewMemberId").text(result.memberId);
	                $("#viewMemberName").text("비공개");
	                $("#viewMemberEmail").text("비공개");
	                $("#viewMemberBirth").text("비공개");
	                $("#viewMemberGender").text("비공개");
	                $("#viewMemberIntro").text(result.memberIntro);                    
	            }
	        },
	        error: function() {
	        }
	    });
	});
	
	
	// 멤버 다이어리 보기
	$("#viewDiaryBtn").click(function() {
	    window.location.replace(viewDiaryBtn);
	});

}
