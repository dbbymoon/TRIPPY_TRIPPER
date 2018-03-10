/*Companion을 위한 js입니다.*/
$(function(){
	 var auto1 = new google.maps.places.Autocomplete(document.getElementById('departure'));
     var auto2 = new google.maps.places.Autocomplete(document.getElementById('destination'));
     var auto3 = new google.maps.places.Autocomplete(document.getElementById('mdeparture'));
     var auto4 = new google.maps.places.Autocomplete(document.getElementById('mdestination'));
    
     /*글 작성 관련 메서드*/
     //textArea 입력 제한을 위한 함수
     var textCountLimit = 99;
   

     $(document).ready(function(){
         $('textarea[name=companionMemo]').keyup(function() {
             // 텍스트영역의 길이를 체크
             var textLength = $(this).val().length;
      
             // 입력된 텍스트 길이를 #textCount 에 업데이트 해줌
             $('#textCount').text(textLength);
              
             // 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
             if (textLength > textCountLimit) {
                 $(this).val($(this).val().substr(0, textCountLimit));
             }
         });
         
     });
     
    //날짜 입력을 위한 함수
    $("#tourDate").datepicker(   // inputbox 의 id 가 startDate 이겠죠.
            {dateFormat:'yy/mm/dd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
             , showOn: 'button' // 우측에 달력 icon 을 보인다.
//              , buttonImage: '/images/Icon_calendar.gif'  // 우측 달력 icon 의 이미지 패스 
             , buttonImageOnly: true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
             , changeMonth: true // 월선택 select box 표시 (기본은 false)
             ,changeYear: true  // 년선택 selectbox 표시 (기본은 false)
             ,showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
    });
    
    $("#mtourDate").datepicker(   // inputbox 의 id 가 startDate 이겠죠.
            {dateFormat:'yy/mm/dd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
             , showOn: 'button' // 우측에 달력 icon 을 보인다.
//              , buttonImage: '/images/Icon_calendar.gif'  // 우측 달력 icon 의 이미지 패스 
             , buttonImageOnly: true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
             , changeMonth: true // 월선택 select box 표시 (기본은 false)
             ,changeYear: true  // 년선택 selectbox 표시 (기본은 false)
             ,showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
    });

    //버튼이 눌리면 글쓰기 모달창이 화면에 보임
	$("#companionWrite").on("click", function(){
		$("#modDiv").show("slow");
	});

	//버튼이 눌리면 글쓰기 모달창이 닫힘
	$("#closeBtn").on("click",function(){
		$("#modDiv").hide("slow");
	});

	//글쓰기 모달창에서 글작성 버튼이 눌렸는 때 수행하는 함수
	$("#writeBtn").on("click",function(){
		
		var tourDate = $("#tourDate").val();
		var departure = $("#departure").val();
		var destination = $("#destination").val();
		var detailSpot = $("#detailSpot").val();
		var vehicles = $("#vehicles option:selected").val();
		var companionMemo = $("#companionMemo").val();
		var tourDate = $("#tourDate").val();
		var companionNum = $("#companionNum option:selected").val();
		var companionGender = $("#companionGender option:selected").val();
		
		//입력값을 없을 경우 방지
		if(departure=='' || destination=='' || detailSpot=='' || tourDate=='' || tourDate=='' ||companionMemo==''){
			swal({
				  title: 'error!',
				  text: '값을 모두 입력해주세요.',
				  type: 'error',
				  confirmButtonText: 'OK',
			});
			return false;
		}
		
		//ajax로 작성 요청
		$.ajax({
			url : "companion/write", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"json",
			data : {
				memberId:memberId, //내가 저장하고 싶은 모든 내용을 여기서 넘겨준다.
				tourDate:tourDate,
				departure:departure,
				destination:destination,
				detailSpot:detailSpot,
				vehicles:vehicles,
				companionMemo:companionMemo,
				tourDate:tourDate,
				companionNum:companionNum,
				companionGender:companionGender,
				memberProfile:memberProfile
			},
			success : function(result){
				if(result == "SUCCESS"){
					swal({
						  title: 'Success!',
						  text: '글을 작성하였습니다.',
						  type: 'success',
						  confirmButtonText: 'OK',
					}).then(function(){
						$("#modDiv").hide("slow");
						location.reload(true);
					});
				}
			},
			error : function(){
				swal({
					  title: 'error!',
					  text: '글 작성을 실패하였습니다.',
					  type: 'error',
					  confirmButtonText: 'OK',
				}).then(function(){
					$("#modDiv").hide("slow");
				});
			}
		});
	});
		
	/*글 수정 관련 메서드*/
	//글 수정 모달창에서 글 수정을 요청하는 버튼
	$("#ModifyBtn").on("click",function(){
		var companionSeq = $("#mcompanionSeq").text();
		var tourDate = $("#mtourDate").val();
		var departure = $("#mdeparture").val();
		var destination = $("#mdestination").val();
		var detailSpot = $("#mdetailSpot").val();
		var vehicles = $("#mvehicles option:selected").val();
		var companionMemo = $("#mcompanionMemo").val();
		var tourDate = $("#mtourDate").val();
		var companionNum = $("#mcompanionNum option:selected").val();
		var companionGender = $("#mcompanionGender option:selected").val();
		
		//입력값을 없을 경우 방지
		if(departure=='' || destination=='' || detailSpot=='' || tourDate=='' || tourDate=='' ||companionMemo==''){
			swal({
				  title: 'error!',
				  text: '값을 모두 입력해주세요.',
				  type: 'error',
				  confirmButtonText: 'OK',
			});
			return false;
		}
		
		//ajax로 내가 해당되는 글의 seq를 가지고 가서 정보를 가져와야한다.
		$.ajax({
			url : "companion/modify", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"json",
			data : {
				companionSeq:companionSeq,
				memberId:memberId, //내가 저장하고 싶은 모든 내용을 여기서 넘겨준다.
				tourDate:tourDate,
				departure:departure,
				destination:destination,
				detailSpot:detailSpot,
				vehicles:vehicles,
				companionMemo:companionMemo,
				tourDate:tourDate,
				companionNum:companionNum,
				companionGender:companionGender,
				memberProfile:memberProfile
			},
			success : function(result){
				if(result == "SUCCESS"){
					swal({
						  title: 'Success!',
						  text: '글을 수정하였습니다.',
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
					  text: '글 수정을 실패하였습니다.',
					  type: 'error',
					  confirmButtonText: 'OK',
				}).then(function(){
					$("#modDivModify").hide("slow");
				});
			}
		});
	});
	
	//글 수정 모달창에서 닫기 버튼
	$("#ModifyCloseBtn").on("click",function(){
		$("#modDivModify").hide("slow");
	});
	
	
	/*동행인 리스트 관련 메서드*/
	//동행인 모달창에서 닫기 버튼
	$("#goWithClose").on("click",function(){
		$("#modGoWithList").hide("slow");
		goWithListFlag = false;
	});
	
});

//수정 모달 창에 원하는 데이터를 가져오는 함수
function ModifyComponion(companionSeq){
	$("#modDivModify").show("slow");
	$.ajax({
		url : "companion/getModify/"+companionSeq, //글을 작성하기 위한 요청명 입력
		type : "get",
		datatype :"json",
		success : function(companion){
			var tourDate = new Date(companion.tourDate);
			var tourDate_year = tourDate.getYear()+1900;
			var tourDate_month = tourDate.getMonth()+1;
			var tourDate_date = tourDate.getDate();
			var tourDate_str = tourDate_year+'/'+tourDate_month+'/'+tourDate_date;
			
			$("#mcompanionSeq").text(companionSeq);
			document.getElementById("mtourDate").value = tourDate_str;
			document.getElementById("mdeparture").value = companion.departure;
			document.getElementById("mdestination").value = companion.destination;
			document.getElementById("mdetailSpot").value = companion.detailSpot;
			document.getElementById("mvehicles").value = companion.vehicles;
			document.getElementById("mcompanionGender").value = companion.companionGender;
			document.getElementById("mcompanionNum").value = companion.companionNum;
			document.getElementById("mcompanionMemo").value = companion.companionMemo;
		}
	});
}

//수정 모달창에서 글을 삭제하는 함수
function DeleteComponion(companionSeq){

	$.ajax({
		url : "companion/delete/"+companionSeq, //글을 작성하기 위한 요청명 입력
		type : "get",
		datatype :"json",
		success : function(result){
			if(result == "SUCCESS"){
				swal({
					  title: 'Success!',
					  text: '글을 삭제하였습니다.',
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
				  text: '글 삭제를 실패하였습니다.',
				  type: 'error',
				  confirmButtonText: 'OK',
			}).then(function(){
				$("#modDivModify").hide("slow");
			});
		}
	});
}

//글 번호를 반환하는 함수
function returnSeq(companionSeq){
	//goWith 버튼을 누르면 동행 신청하는 것으로 matching DB에 대기 상태로 들어간다.
	//해당 글 번호, 매칭 버튼을 누른 ID, 대기상태로 저장
	$.ajax({
		url : "companion/goWith", //글을 작성하기 위한 요청명 입력
		type : "get",
		data: {
			memberId:memberId,
			companionSeq:companionSeq
		},
		datatype :"json",
		success : function(result){
			if(result == "SUCCESS"){
				swal({
					  title: 'Success!',
					  text: '동행 신청 완료',
					  type: 'success',
					  confirmButtonText: 'OK',
				}).then(function(){
					location.reload(true);
				});	
			}
		},
		error : function(){
			swal({
				  title: 'error!',
				  text: '이미 참여한 동행입니다.',
				  type: 'error',
				  confirmButtonText: 'OK',
			});
		}
	});
}

var goWithListFlag = false;

//동행인 리스트 버튼을 클릭했을때 해당글의 동행리스트를 보여주는 메서드
function goWithList(companionSeq, writerId){
	//글의 seqeunce로 해당하는 동행인 리스트 가져오기
	
	var table = $("#goWith_content");
	$("tr",table).remove();
	
	if(goWithListFlag == false){
		$("#modGoWithList").show("slow");
		goWithListFlag = true;
	}else{
		$("#modGoWithList").hide("fast");
		goWithListFlag = false;
	}
	
	$.ajax({
		url : "companion/getGowithList/"+companionSeq, //글을 작성하기 위한 요청명 입력
		type : "post",
		datatype :"json",
		success : function(tMemberMatchingList){
			
			var btnFlag=true;
			
			for(var i in tMemberMatchingList){
				
				if(tMemberMatchingList[i].matchingType == 1){
					var changeBtn = $('<input type="button" class="changebtn" value="allow">');
				
				}else{
					var changeBtn = $('<input type="button"  class="changebtn" value="cancel">');
				}
				
				var tr = $("<tr>");

				//작성자와 내 아이디와 같으면 띄움
				if(writerId == memberId ){
					//매칭 상태가 allow이면 띄움 btnFlag는 if안의 코드를 딱 한 번만 실행하기 위해서 사용
					if(changeBtn.val() == "allow" && btnFlag==true){
						var boundary =  $("<tr>");
						$("<td class='goWithListTd' colspan='3'>").text("New").appendTo(boundary);
						boundary.appendTo(table);
						btnFlag=false;
					}
				}
				//안띄우는 경우
				//내 아이디가 작성자 아이디와 다름 그리고 매칭 상태가 allow면 안띄움
				if(memberId != writerId && tMemberMatchingList[i].matchingType == 1){
					//아무것도 출력하지 않음
				}else{
//					
//					alert(memberProfile);
					$("<td class='goWithList' width='40px' align='center'>").html('<img src="profileImg/' + tMemberMatchingList[i].memberProfile+'" style="width:30px; height:30px; border-radius:50%;"/>').appendTo(tr);
					$("<td class='goWithList' width='120px' align='center'>").text(tMemberMatchingList[i].memberId).appendTo(tr);
				}
				
				//리스트 아이디 != 내 아이디이면 띄움
				//작성자 아이디 == 내 아이디이면 띄움
				if(writerId == memberId){
					if(tMemberMatchingList[i].memberId != memberId){
						$("<td align='right'>").append(changeBtn).appendTo(tr);
					}
				}
				
				tr.appendTo(table);
			
				(function(i){
					var memberId = tMemberMatchingList[i].memberId;
					changeBtn.on("click",function(){
						var matchingType = $(this).val();
							$.ajax({
								url : "companion/changeMatchingType",
								data : {
									memberId:memberId,
									companionSeq:companionSeq,
									matchingType:matchingType
								}, 
								type : "get",
								datatype :"text",
								success : function(result){
									location.reload(true);
									goWithListFlag = true;
									$("#modGoWithList").show("fast");
								}
							 });						 
					});
				})(i);
			}
		},
		error : function(){
			swal({
				  title: 'error!',
				  text: '실패염',
				  type: 'error',
				  confirmButtonText: 'OK',
			});
		}
	});
}

var modMenu = false;
function memberInfoBtn(memberId) {
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


// 멤버 정보 보기 
$("#viewProfileBtn").click(function() {
    $("#modInfoView").show("slow");

    $.ajax({
        type: "GET",
        url: "tripRecord/memberInfoView/"+memberId,
        data: memberId,
        dataType: "json",
        success: function(result) {
            var birth = new Date(result.memberBirth);
            var memberBirth_str = birth.getFullYear()+ '/' + birth.getMonth()+1 + '/' + birth.getDate();

            if (result.memberSecret == "public") {
                $("#viewMemberProfile").attr("src", "../profileImg/"+result.memberProfile);
                $("#viewMemberId").text(result.memberId);
                $("#viewMemberName").text(result.memberName);
                $("#viewMemberEmail").text(result.memberEmail);
                $("#viewMemberBirth").text(memberBirth_str);
                $("#viewMemberGender").text(result.memberEmail);
                $("#viewMemberIntro").text(result.memberIntro);
            } else {
                $("#viewMemberProfile").attr("src", "../profileImg/"+result.memberProfile);
                $("#viewMemberId").text(result.memberId);
                $("#viewMemberName").text("비공개");
                $("#viewMemberEmail").text("비공개");
                $("#viewMemberBirth").text("비공개");
                $("#viewMemberGender").text("비공개");
                $("#viewMemberIntro").text(result.memberIntro);                    
            }
        },
        error: function() {
            alert("error!");
        }

    });


});

// 멤버 다이어리 보기
$("#viewDiaryBtn").click(function() {
    window.location.replace('tripRecord/memberDiaryView?memberId='+memberId);
});
}
