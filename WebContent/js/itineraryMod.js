/**
 * 
 */

$(function(){
	
	if($("#mySchedules").val()==null){
		$("#selectSchedule").css("display","none");
		$("#addSchedule").css("display","block");
	}

	//* 텍스트 박스에 달력 띄우기
	$("#departureDate").datepicker(   // inputbox 의 id 가 startDate 이겠죠.
	{dateFormat:'yy/mm/dd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
	 , showOn: 'button' // 우측에 달력 icon 을 보인다.
	// , buttonImage: '/images/Icon_calendar.gif'  // 우측 달력 icon 의 이미지 패스 
	 , buttonImageOnly: true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
	 , changeMonth: true // 월선택 select box 표시 (기본은 false)
	 ,changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	 ,showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
	$("#endDate").datepicker(   // inputbox 의 id 가 startDate 이겠죠.
	{dateFormat:'yy/mm/dd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
	, showOn: 'button' // 우측에 달력 icon 을 보인다.
	//, buttonImage: '/images/Icon_calendar.gif'  // 우측 달력 icon 의 이미지 패스 
	, buttonImageOnly: true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
	, changeMonth: true // 월선택 select box 표시 (기본은 false)
	,changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	,showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});	

});


//4.2. 새로운 여행 추가
//4.2.1. 새로운 여행 추가를 위한 2번 모달 창 띄우기
function showAddSchedule(){
	$("#selectSchedule").hide("slow");
	$("#addSchedule").show("slow");
}
//4.2.2. 날짜 및 여행 이름 검사 
function checkAddSchedule(){
	var departureDate = $("#departureDate").val();
	var endDate = $("#endDate").val();
	var scheduleName = $("#scheduleName").val();
	
	var values = $("#mySchedules>option").map(function() { return $(this).val(); });
	
	var nameVal = true;	//이름의 중복 여부
	
	
	if(scheduleName==""){
		swal({
			  title: 'Error!',
			  text: '여행 이름을 입력해주세요',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
		return false;
	}else if(departureDate==""){
		swal({
			  title: 'Error!',
			  text: '출발일을 입력해주세요',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
		return false;
	}else if(endDate==""){
		swal({
			  title: 'Error!',
			  text: '도착일을 입력해주세요',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
		return false;
	}else{
		for(var i=0;i<values.length;i++){
			if(scheduleName==values[i]){
				swal({
					  title: 'Error!',
					  text: '중복된 이름입니다. 다시 설정하세요',
					  type: 'error',
					  confirmButtonText: 'OK',
				}).then(function(){
					nameVal = false;	
				});
				return false;
			}
		}
		if(nameVal){
			if(departureDate>endDate){
				swal({
					  title: 'Error!',
					  text: '출발일이 종료일보다 늦을 수 없습니다.',
					  type: 'error',
					  confirmButtonText: 'OK',
				});
				return false;
			}
		}
		return true;
	}
	
}