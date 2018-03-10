/**
댓글
**/

$(function(){
	//댓글 모달 닫기 버튼
	$("#closeReplyBtn").on("click",function(){
		$("#viewReplyTable").empty();
		$("#replycompanionSeq").text("");
		$(".replyModContainer").hide("fast");
	});
	
	//댓글 작성 버튼을 누름
	$("#addReplyBtn").on("click", function(){
		var replyContent = $("#reContent").val();
		var cReplyNum=$("#saveReplyNum").text();
		var companionSeq = $("#replycompanionSeq").text();
		var secret = $(".typeOfSecret").text();
		
		$.ajax({
			url : "cReply/addReply", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"text",
			data : {
				memberId:memberId,
				companionSeq:companionSeq,
				replyContent:replyContent,
				cReplyNum:cReplyNum,
				memberProfile:memberProfile,
				secret:secret
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
		
		var companionSeq = $("#recordSeq").text();
		var replyContent = $("#reContent").val();

		$.ajax({
			url : "cReply/deleteReply", //글을 작성하기 위한 요청명 입력
			type : "post",
			datatype :"text",
			data : {
				memberId:memberId, //내가 저장하고 싶은 모든 내용을 여기서 넘겨준다.
				companionSeq:companionSeq,
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
	
	//비밀글 버튼 누름
	var secretFlag=true;
	
	$(".padlock").on("click", function(){
		if(secretFlag == true){
			$(".typeOfSecret").text('2');
			$(".padlock").attr("src","img/padlock_red.png");
			secretFlag=false;
		}else{
			$(".typeOfSecret").text('1');
			$(".padlock").attr("src","img/padlock_black.png");
			secretFlag=true;
		}
	});
});

function viewReplyMod(companionSeq, writer){
	//모달창 띄우기
	$(".replyModContainer").show("fast");
	var table = $("#viewReplyTable");
	$("#replycompanionSeq").text(companionSeq);
	
	$.ajax({
		url : "cReply/getReplyList", //글을 작성하기 위한 요청명 입력
		type : "post",
		datatype :"json",
		data : {
			companionSeq:companionSeq
		},
		success : function(replyList){
			var replyName;	//원댓쓰니
			
			for(var i in replyList){
				var tr = $("<tr>");
				var deleteReply = $("<button class='replyBtn'>X</button>");
				var ReplyOfReplyBtn = $("<button class='replyBtn'><img src='img/arrow.png' width='10px'></button>");
				
				if(replyList[i].depth != 0){
					$("<td class='replytable replytableMemberProfileRoR'>").html('<img src="img/arrow.png" width="10px"><img src="profileImg/' + replyList[i].memberProfile +'" class="replyProfile"/>').appendTo(tr);	//대댓글 버튼
				}else{
					$("<td class='replytable replytableMemberProfile'> ").html('<img src="profileImg/' + replyList[i].memberProfile +'" class="replyProfile" style="float:right;"/>').appendTo(tr);	//프로필사진
				}
				
				$("<td class='replytable' style='display:none'>").text(replyList[i].cReplySeq).appendTo(tr);	//전체 댓글 번호
				$("<td class='replytable' style='display:none'>").text(replyList[i].cReplyNum).appendTo(tr);	//댓글 번호
				$("<td class='replytable replytableId'>").text(replyList[i].memberId).appendTo(tr);	//아이디
				
				if(replyList[i].depth == 0){
					replyName = replyList[i].memberId;
				}
				
				if(replyList[i].secret == 2){
					//비공개 댓글
					if(replyList[i].memberId == memberId || writer == memberId){
						//글쓴이이면 댓글 보임
						//댓글쓰니이면 댓글보임
						$("<td class='replytable replytableContent' style='font-size:14px; color:#424242; font-style:oblique' >").html(replyList[i].replyContent+"<img src='img/padlock_black.png' style='width:10px; height:10px; margin-left:5px;'>").appendTo(tr);
					}else if(replyList[i-1].cReplyNum == replyList[i].cReplyNum && replyList[i].depth > 0 && replyName == memberId){
						//어떤 댓글이 대댓글이면 보임
						//내가 쓴 댓글의 대댓글이 비공개 댓글이여도 보임
						
						$("<td class='replytable replytableContent' style='font-size:14px; color:#424242; font-style:oblique' >").html(replyList[i].replyContent+"<img src='img/padlock_black.png' style='width:10px; height:10px; margin-left:5px;'>").appendTo(tr);
					}else{
						$("<td class='replytable replytableContent' style='font-size:13px; color:gray; font-style:oblique'>").html("비밀댓글입니다. <img src='img/padlock_black.png' style='width:10px; height:10px;'>").appendTo(tr);
					}
				}else if(replyList[i].secret == 1){
					//공개 댓글
					//그외 안보임
					$("<td class='replytable replytableContent'>").text(replyList[i].replyContent).appendTo(tr);
				}
				
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
						var cReplySeq = replyList[i].cReplySeq;
	
						$.ajax({
							url : "cReply/deleteReply/"+cReplySeq, 
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
						$("#saveReplyNum").text(replyList[i].cReplyNum);
						ReOfReFlag = true;					
					});
				})(i);
			}		
		},
		error : function(){
			
		}
	});
}
