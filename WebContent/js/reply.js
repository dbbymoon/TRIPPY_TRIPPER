/**
댓글
**/

$(function(){

	//댓글 작성 버튼을 누름
	$("#addReplyBtn").on("click", function(){
		var recordSeq = $("#recordSeqNum").text();
		var replyContent = $("#reContent").val();
		var replyNum=$("#saveReplyNum").text();

		$.ajax({
			url : "../tReply/addReply", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"text",
			data : {
				memberId:memberId,
				recordSeq:recordSeq,
				replyContent:replyContent,
				replyNum:replyNum,
				memberProfile:memberProfile,
			},
			success : function(result){
				if(result == "SUCCESS"){
					swal({
						  title: 'Success!',
						  text: '댓글을 작성하였습니다.',
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
					  text: '댓글 작성을 실패하였습니다.',
					  type: 'error',
					  confirmButtonText: 'OK',
				}).then(function(){
				});
			}
			
		});
		
	});
		
	//댓글 삭제 버튼을 누름
	$("#deleteReplyBtn").on("click", function(){
		var recordSeq = $("#recordSeq").text();
		var replyContent = $("#reContent").val();

		$.ajax({
			url : "../tReply/deleteReply", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"text",
			data : {
				memberId:memberId, //내가 저장하고 싶은 모든 내용을 여기서 넘겨준다.
				recordSeq:recordSeq,
				replyContent:replyContent
			},
			success : function(result){
				if(result == "SUCCESS"){
					swal({
						  title: 'Success!',
						  text: '댓글을 작성하였습니다.',
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
					  text: '댓글 작성을 실패하였습니다.',
					  type: 'error',
					  confirmButtonText: 'OK',
				}).then(function(){
				});
			}
			
		});
		
	});
})
