<!-- 여행 후기 게시물 리스트 -->
<!-- 내가 쓴 여행 게시글 리스트  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Traveler &mdash; Free Website Template, Free HTML5 Template by GetTemplates.co</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="GetTemplates.co" />

<script src="https://code.jquery.com/jquery-3.2.1.min.js"
   integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
   crossorigin="anonymous"></script>

<!-- reply.js -->
<script src="../js/reply.js"></script>
<script src="../js/diaryList.js"></script>

<!-- sweetalert js -->
<script src="../js/sweetalert2.min.js"></script>
   
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">
   
<!-- jQuery companion -->
<script src="../js/companion.js"></script>
<!-- jQuery -->
<script src="../js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="../js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="../js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="../js/jquery.waypoints.min.js"></script>
<!-- Carousel -->
<script src="../js/owl.carousel.min.js"></script>
<!-- countTo -->
<script src="../js/jquery.countTo.js"></script>
<!-- Stellar Parallax -->
<script src="../js/jquery.stellar.min.js"></script>
<!-- Magnific Popup -->
<script src="../js/jquery.magnific-popup.min.js"></script>
<script src="../js/magnific-popup-options.js"></script>
<!-- Datepicker -->
<script src="../js/bootstrap-datepicker.min.js"></script>
<!-- Main -->
<script src="../js/main.js"></script>
<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="../css/sweetalert2.css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
<!-- Animate.css -->
<link rel="stylesheet" href="../css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="../css/icomoon.css">
<!-- Themify Icons-->
<link rel="stylesheet" href="../css/themify-icons.css">
<!-- Bootstrap  -->
<link rel="stylesheet" href="../css/bootstrap.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="../css/magnific-popup.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="../css/bootstrap-datepicker.min.css">
<!-- Owl Carousel  -->
<link rel="stylesheet" href="../css/owl.carousel.min.css">
<link rel="stylesheet" href="../css/owl.theme.default.min.css">
<!-- Theme style  -->
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/diary.css">
<link rel="stylesheet" href="../css/tripRecord.css">
<link rel="stylesheet" href="../css/reply.css">

<!-- Modernizr JS -->
<script src="../js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
   <script src="js/respond.min.js"></script>
   <![endif]-->
   
   
<!-- jquery-ui resource embed start -->
<link  href="resources/jqueryui/css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet">
<script src="resources/jqueryui/js/jquery-ui-1.8.16.custom.min.js"></script>
<!-- jquery-ui resource embed end -->


<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyCDaCyJ-nputHM4cp2ogGZjCC_3ASAg-uE&libraries=places"></script>

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>


<script type="text/javascript">
    var memberId = '${memberId}';
    var memberProfile = '${memberProfile}';

    
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
		viewProfileBtnURL="../tripRecord/memberInfoView/"+memberId;
		viewDiaryBtn='../tripRecord/memberDiaryView?memberId='+memberId;
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
	            var memberBirth_str = birth.getFullYear()+ '/' + birth.getMonth()+1 + '/' + birth.getDate();
	
	            if (result.memberSecret == "public") {
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
	            alert("error!");
	        }
	    });
	});
	
	
	// 멤버 다이어리 보기
	$("#viewDiaryBtn").click(function() {
	    window.location.replace(viewDiaryBtn);
	});

}
</script>
<style type="text/css">
body {
   width: 100%;
   min-height: 700px;
   background-color: black;
   background: url(../img/bg1.jpg) no-repeat center center fixed;
   -webkit-background-size: cover;
   -moz-background-size: cover;
   -o-background-size: cover;
   background-size: cover;
   font-family: 'Jeju Gothic', serif;
}
</style>

<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
</head>
<body>
   
   <div class="gtco-loader"></div>
   <div id="page">
      <!-- <div class="page-inner"> -->
      <nav class="gtco-nav" role="navigation">
         <div class="gtco-container">
            <div class="row">
               <div class="col-sm-4 col-xs-12">
                  <div id="gtco-logo">
                     <a href="../main">TRIPPY TRIPPER <em>.</em></a>
                  </div>
               </div>
               <div class="col-xs-8 text-right menu-1">
                  <ul>
                     <li class="has-dropdown">
                     <a href="../itinerary/start">ITINERARY</a>
                        <ul class="dropdown">
                           <li><a href="../tMember/myItinerary">MyTrip</a></li>
                        
                        </ul>
                     </li>
                     
                     <!-- 추후 요청 변경 -->
                     <li class="has-dropdown">
                     <a href="../companion">COMPANION</a>
                        <ul class="dropdown">
                           <li><a href="../tMember/myCompanion">MyComponion</a></li>
                        </ul>
                     </li>
                     <!-- 추후 요청 변경 -->
                     <li class="has-dropdown">
                     <a href="../tripRecord/tripRecordList">DIARY</a>
                        <ul class="dropdown">
                           <li><a href="../tripRecord/myDiaryList">MY DIARY</a></li>
                        
                        </ul>
                     </li>
                     
                     <li>
                     <a href="../tMember/myInfo">MY PAGE</a>
                     </li>
                     <li>
                         <a href="../tMember/logout">LOGOUT</a>
                     </li>
                  </ul>
               </div>
            </div>
         </div>
      </nav>
      
      <header id="gtco-header" class="gtco-cover gtco-cover-sm" role="banner" style="background-image: url(../img/bg1.jpg)">
      <div class="overlay"></div>
      <div class="gtco-container">
         <div class="row">
            <div class="col-md-12 col-md-offset-0 text-center">
               <div class="row row-mt-15em">

                  <div class="col-md-12 mt-text animate-box" data-animate-effect="fadeInUp">
                     <h1>Trip Record</h1>   
                  </div>
                  
               </div>
            </div>
         </div>
      </div>
   </header>
   <div>
      <div class="gtco-section">
      <div class="gtco-container">
         <div class="row">
            <div class="col-md-8 col-md-offset-2 text-center gtco-heading">
               <h2>Share Your Best Time In Your Trip</h2>
<!--                <p style="color:white; font-size:40px;font-family: 'Nanum Pen Script', cursive;">혼자 떠나는 여행에서 혼자이고 싶지 않은 당신을 위한 공간</p> -->
            </div>
         </div>
         <c:forEach var="tripRecord" items="${AllList}">
            <div class="col-lg-4 col-md-4 col-sm-6">
               <span id="boxsize" class="fh5co-card-item">
                  <div class="fh5co-text">

                     <div class="viewTripRecord">
                        <span id="tripRecordSeq" style="display: none;">${tripRecord.recordSeq}</span>
                        <div class="viewTripRecord-content">
                           <p>
	                           <img src='../profileImg/${tripRecord.memberProfile}' class="profileImgTripRecord">
	                           
<%-- 	                            onclick="memberInfoBtn('${tripRecord.memberId}',2)" --%>
<!-- test('${tripRecord.memberId}',2) -->
	                           <span id="tripRecordMemberId" onclick="memberInfoBtn('${tripRecord.memberId}',2)">${tripRecord.memberId}</span>
                           
                           </p>
                        </div>
                     </div>
                     
                     <div class="viewTripRecordImg">
                        <img src='../diaryImg/${tripRecord.diaryImg.fileName}' 
                        onclick="myDiaryView('${tripRecord.recordSeq}','${tripRecord.memberProfile}','${tripRecord.memberId}')" 
                        style="width:100%; height:100%" class="myDiaryImg">
                     </div>
                     <div class="viewTripRecord-memo">
                           <p>${tripRecord.content}</p>
                     </div>

                  </div>
                  
               </span>
            </div>
         </c:forEach>

         </div>
      </div>
   </div>
   
                    <!-- 글 Detail을 위한 모달창 -->
					<div id="modDiaryDiv" style="display:none;">
						<div class="modDiaryContent">
							<ul>
							  <li class="modDiaryBtn">
                                    <div class="xBtn2"><input type="button" id="diaryCloseBtn" value="X"></div>
                                </li>
								<li class="modDiaryProfile">
									<div id="modMyProfile"></div>
									<div id="modMyId">
										<span id="myId" style="font-color:#09C6AB;"></span>
									</div>
								</li>
								<li id="modDiaryImg" class="tripRecordImgDetail">
								<!-- 사진/옆으로 넘기는 버튼이 달리는 곳  -->
								</li>
								<li class="recordDateLi">
									<span id="recordDate"></span>
								</li>
								<li class="recordContentLi">
									<div id="recordContentInView"></div>
								</li>
								<li class="recordLocationLi">
									<b>&mdash; <span id="recordLocation"></span>에서</b>
								</li>
								<li class="recordSecretLi">
									<img src="" alt="secret" id="modSecretImg" class="modalProfileImg" style="">
								</li>
								<li class="recordSeqNumLi">
									<span id="recordSeqNum" style="display: none;"></span>
								</li>
							</ul>
							<div class="replyContent">
								<div class="viewReply">
								<!--댓글은 ajax로 삽입 -->
								<table id="viewReplyTable"></table>
								</div>
								<div id="writeReply">
									<div id="saveReplyNum" style="display:none">0</div>
									<textarea name="reContent" id="reContent" style="overflow:hidden;"></textarea>
									<input type="button" id="addReplyBtn" value="작성">		
								</div>
							</div>
						</div>
					</div>
					
					<!-- 아이디를 누르면 뜨는 메뉴 모달창 -->
					<div id="modMenu" style="display: none;">
					<div id="viewProfileBtn">Info</div>
					<div id="viewDiaryBtn">Diary</div>
					</div>

                                <!-- 내 정보 보는 모달창 -->
                                <div id="modInfoView" style="display: none;">
                                    <div class="viewLine"></div>    
                                    <input type="button" id="modInfoViewCloseBtn" value="x">                                    
                                    <div class="viewMemberContent">
                                        <ul class="viewMemberUl">
                                            <li class="viewMemberProNId">
                                                <span id="profile">
                                                <img id="viewMemberProfile" style="width:70px; height: 70px; border-radius: 50%;" src=""></span>
                                                <span id="viewMemberId"></span>
                                            </li>

                                            <li><span style="display: inline-block; width: 90px;">Name</span>
                                                <span id="viewMemberName"></span>
                                            </li>

                                            <li><span style="display: inline-block; width: 90px;">Email</span>
                                                <span id="viewMemberEmail"></span>
                                            </li>

                                            <li><span style="display: inline-block; width: 90px;">Birth</span>
                                                <span id="viewMemberBirth"></span>
                                            </li>

                                            <li><span style="display: inline-block; width: 90px;">Gender</span>
                                                <span id="viewMemberGender"></span>
                                            </li>

                                            <li><span style="display: inline-block; width: 90px;">Intro</span>
                                                <div id="viewIntroSec"><span id="viewMemberIntro"></span></div>
                                            </li>
                                        </ul>
										<div class="replyContent">
								
                                    </div>
                                </div>
				</div>
         
			
         
</body>
</html>