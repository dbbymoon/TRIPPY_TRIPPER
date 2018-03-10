
// 다이어리 사진 업로드 검사
function imgUpload(btnId) {
	
	var ext = $("#"+btnId).val().split('.').pop().toLowerCase(); // 확장자
			
	// 배열에 추출한 확장자가 존재하는지 체크
	if ($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
		alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
		
		// ★ 파일 확장자 다시 검사 ★
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////////////////////////

$(function() {
	
	//textArea 입력 제한을 위한 함수
	 var textCountLimit = 200;

	$('textarea[name=recordContent]').keyup(function() {
		// 텍스트영역의 길이를 체크
		var textLength = $(this).val().length;

		// 입력된 텍스트 길이를 #textCount 에 업데이트 해줌
		$('#textCount').text("("+textLength+"/200)");

		// 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
		if (textLength > textCountLimit) {
			alert("200자 까지만 작성이 가능합니다.");
			$(this).val($(this).val().substr(0, textCountLimit));
		}
	});

	
	$("#diary_File_hidden").change(function() {
		// 내 아이디값 가져와서 파라미터로 넘겨줌
		var btnId = $(this).attr("id");
		imgUpload(btnId);
		
		readURL(this);
	});
	
	$("#diary_File_hidden2").change(function() {
		var btnId = $(this).attr("id");
		imgUpload(btnId);
		readURL2(this);
	});
	
	$("#diary_File_hidden3").change(function() {
		var btnId = $(this).attr("id");
		imgUpload(btnId);
		readURL3(this);
	});


	// 썸네일 생성
	function readURL(input) {		
		if (input.files && input.files[0]) {
			
			var reader = new FileReader();

			reader.onload = function(e) {
				
				// 업로드한 이미지로 속성 변경			
				$("#DiaryThumbnail").prepend('<img class="thumbnailImg" id="thumbnailImg" style="width: 200px; height: 200px; src="">');
				$('#thumbnailImg').attr('src', e.target.result);
								
				// 새로운 이미지를 선택했을 때, 기존 이미지 삭제 후 다시 출력
				$("#diary_File_hidden").change(function(){
					$(".thumbnailImg").remove();
				});
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function readURL2(input) {
		if (input.files && input.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {

				// 업로드한 이미지로 속성 변경			
				$("#DiaryThumbnail2").prepend('<img class="thumbnailImg2" id="thumbnailImg2" style="width: 200px; height: 200px;" src="">');
				$('#thumbnailImg2').attr('src', e.target.result);
				
				// 새로운 이미지를 선택했을 때, 기존 이미지 삭제 후 다시 출력
				$("#diary_File_hidden2").change(function(){
					$(".thumbnailImg2").remove();
				});
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function readURL3(input) {
		if (input.files && input.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {

				// 업로드한 이미지로 속성 변경			
				$("#DiaryThumbnail3").prepend('<img class="thumbnailImg3" id="thumbnailImg3" style="width: 200px; height: 200px;" src="">');
				$('#thumbnailImg3').attr('src', e.target.result);
				
				// 새로운 이미지를 선택했을 때, 기존 이미지 삭제 후 다시 출력
				$("#diary_File_hidden3").change(function(){
					$(".thumbnailImg3").remove();
				});
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	
	
	
	// 다이어리 작성
	$("#myDiaryWriteBtn").on("click", function() {
		var id = memberId;		
		var title = $("#recordTitle").val();
		var content = $("#recordContent").val();		
		var file1 = $("input[id=diary_File_hidden]")[0].files[0];
		var file2 = $("input[id=diary_File_hidden2]")[0].files[0];
		var file3 = $("input[id=diary_File_hidden3]")[0].files[0];
		var location = $("#recordSpot").val();
		var tripDate = $("#recordDate").val();

		if (file1 == null && file2 == null && file3 == null) {
			alert("사진은 1장 이상 등록해주세요.");
			return false;

		} else if (content == '') {
			alert("내용을 입력해주세요.");
			return false;

		} else if (location == '') {
			alert("여행 장소를 입력해주세요.");
			return false;

		} else if (tripDate == '') {
			alert("여행 날짜를 입력해주세요.");
			return false;
		} 
	
	});
	
	
	$("#recordDate").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
		dateFormat : 'YYMMdd' // 만약 2011년 4월 29일 선택하면  inputbox 에 '2011/04/29' 로표시
		, buttonImageOnly : true //  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
		, changeMonth : true // 월선택 select box 표시 (기본은 false)
		, changeYear : true // 년선택 selectbox 표시 (기본은 false)
		, showButtonPanel : true
	// 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
	
	

});



//$(document).ready(function() {
//	  // MagnificPopup
//		var magnifPopup = function() {
//			$('.diaryImgPopup').magnificPopup({
//				type: 'image',
//				tLoading: 'Loading image...',
////				items: [
////					{
////						src: $('<div>String String String</div>'),
////						type: 'inline'
////					}
////				],
//				image: {
//					src: function(item){
//						return '<input type="button" id="diaryModifyBtn" value="M"> <input type="button" id="diaryDeleteBtn" value="D">'
//					},
//					src: function() {
//						
//					}
//				},
//				removalDelay: 300,
//				mainClass: 'mfp-with-zoom',
//				gallery:{
//					enabled:true
//				},
//				zoom: {
//					enabled: true, // By default it's false, so don't forget to enable it
//
//					duration: 300, // duration of the effect, in milliseconds
//					easing: 'ease-in-out', // CSS transition easing function
//
//					// The "opener" function should return the element from which popup will be zoomed in
//					// and to which popup will be scaled down
//					// By defailt it looks for an image tag:
//					opener: function(openerElement) {
//					// openerElement is the element on which popup was initialized, in this case its <a> tag
//					// you don't need to add "opener" option if this code matches your needs, it's defailt one.
//					return openerElement.is('img') ? openerElement : openerElement.find('img');
//					}
//				}
//			});
//		};
//
//		
//		// Call the functions 
//		magnifPopup();
//		
//		
//		
//		$("#diaryModifyBtn").on("click", function(){
//			alert("ㅠㅜㅜㅠㅠㅜ");
//		});
//		
//
//	});