<!-- 내가 쓴 여행 게시글 리스트  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords"
	content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="GetTemplates.co" />

<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous"></script>

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>

<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>
	
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyCDaCyJ-nputHM4cp2ogGZjCC_3ASAg-uE&libraries=places"></script>

<script type="text/javascript">
	$(function() {
		var recordSpot = new google.maps.places.Autocomplete(document.getElementById('recordSpot'));
		var recordModifySpot = new google.maps.places.Autocomplete(document.getElementById('recordModifySpot'));
	});
	
	var memberId='${memberId}';
	var memberProfile='${memberProfile}';
</script>

<script src="js/sweetalert2.min.js"></script>
<script src="../js/diaryList.js"></script>

<!-- reply.css/js -->
<link rel="stylesheet" type="text/css" href="../css/reply.css">
<script src="../js/reply.js"></script>

<!-- sweetalert js -->
<script src="../js/sweetalert2.min.js"></script>

<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="../css/sweetalert2.css">
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
<script src="../js/sweetalert2.min.js"></script>
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="../css/sweetalert2.css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700"
	rel="stylesheet">
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

<!-- jquery-ui resource embed start -->
<link
	href="resources/jqueryui/css/ui-lightness/jquery-ui-1.8.16.custom.css"
	rel="stylesheet">
<script src="resources/jqueryui/js/jquery-ui-1.8.16.custom.min.js"></script>
<!-- jquery-ui resource embed end -->

<!-- Modernizr JS -->
<script src="js/modernizr-2.6.2.min.js"></script>

<style type="text/css">
	body{
		font-family: 'Jeju Gothic', serif;
	}
</style>

<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
</head>
<body>
	<div class="gtco-loader"></div>
	<div id="page">
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
							<li class="has-dropdown"><a href="../itinerary/start">ITINERARY</a>
								<ul class="dropdown">
									<li><a href="../tMember/myItinerary">MY TRIP</a></li>
								</ul></li>

							<!-- 추후 요청 변경 -->
							<li class="has-dropdown"><a href="../companion">COMPANION</a>
								<ul class="dropdown">
									<li><a href="../tMember/myCompanion">LIST</a></li>
								</ul></li>

							<!-- 추후 요청 변경 -->
							<li class="has-dropdown"><a href="../tripRecord/tripRecordList">DIARY</a>
								<ul class="dropdown">
									<li><a href="../tripRecord/myDiaryList">MY DIARY</a></li>
								</ul></li>

							<li><a href="../tMember/myInfo">MY PAGE</a></li>

							<li><a href="../tMember/logout">LOGOUT</a></li>
						</ul>
					</div>
				</div>
			</div>
		</nav>

		<header id="gtco-header" class="gtco-cover gtco-cover-md" role="banner" style="background-image: url(../img/bg1.jpg)">
			<div class="overlay" id="overlay" style="display:none;"></div>
			<div class="myPage">
				<ul id="splitMyPage">
					<li id="myDairyList">
						<div class="myDiary-box">
							<div class="myInfoTitle">
								<h3>My Diary</h3>
							</div>

							<!-- 프로필  -->
							<div class="row form-group" align="center">
								<div class="col-md-12">
									<div id="profile-box">
										<div id="diaryProfile">
											<img class="dairyProfileImg" id="dairyProfileImg"
												src="../profileImg/${memberInfo.memberProfile}">
										</div>
										<div id="diaryIdNIntro">
											<div class="diaryMemberId">
												<label id="diaryMemberIdVal"><b>${memberInfo.memberId}</b></label>
											</div>
											<div class="diaryMemberIntro">
												<label id="diaryMemberIntroVal">${memberInfo.memberIntro}</label>
											</div>
										</div>
										<div id="diaryWriteBtn">
											<input type="button" class="btn btn-primary" id="writeBtn" value="+"
												onclick="location.href='../tripRecord/myDiaryWriteForm'">
										</div>
									</div>


									<!-- 사진 목록 -->
									<div class="myDiaryList">
										<table>
											<tr>
												<c:forEach var="files" items="${fileList }" varStatus="status">
													<c:if test="${status.index%3==0}">
											</tr>
											<tr>
												</c:if>
												<div class="imgsize">
													<img src="../diaryImg/${files.fileName}" class="myDiaryImg" 
													id="imgAtt${status.index }" onclick="myDiaryView('${files.recordSeq}','${memberInfo.memberProfile}','${memberInfo.memberId}')" style="width: 200px; height: 200px;">
												</div>
												<div id="recordSeqInList" style="display:none;">${files.recordSeq}</div>
												</c:forEach>
											</tr>
										</table>
									</div>
								
									<!-- 글 Detail을 위한 모달창 -->
                           <div id="modDiaryDiv" style="display:none;">
                              <div class="modDiaryContent">
                                 <ul>
                                    <li class="modDiaryBtn">
                                         <div class="xBtn"><input type="button" id="diaryCloseBtn" value="X"></div>
                                         <div class="dBtn"><input type="button" id="diaryDeleteBtn" value="D" onclick="myDiaryDelete()"></div>
                                         <div class="mBtn"><input type="button" id="diaryModifyBtn" value="M"></div>
                                    </li>
                                    
                                    <li class="modDiaryProfile">
                                       <div id="modMyProfile">
<!--                                           <img class="modDairyProfileImg" id="modDairyProfileImg" -->
<%--                                           src="../profileImg/${memberInfo.memberProfile}"> --%>
                                       </div>
                                       <div id="modMyId">
                                          <span id="myId" style="font-color:#09C6AB;"></span>
<%--                                           <b>${memberInfo.memberId}</b> --%>
                                       </div>
                                    </li>
                                    
                                    <li id="modDiaryImg" class="diaryImgDetail">
                                    <!-- 사진/옆으로 넘기는 버튼이 달리는 곳  -->
                                    </li>
                                       <li class="recordDateLi">
                                          <span id="recordDate"></span>
                                       </li>
                                       <li class="recordContentLi">
                                          <span id="recordContentInView"></span>
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
                           </div>


									<!-- 글 수정을 위한 모달창 -->
									<div id="modDiaryModifyDiv" style="display: none;">
										<!-- <div class = "modal-title">Write</div> -->
										<div class="modDiaryContent">
											<ul>
												<li class="modModifyCloseBtn">
													<input type="button" id="diaryViewModifyCloseBtn" value="X">
												</li>
												
												<li class="modDiaryProfile">
													<div id="">
														<img class="modDairyProfileImg" id="modDairyProfileImg"
														src="../profileImg/${memberInfo.memberProfile}">
													</div>
													<div id="modMyId">
														<span id="myId" style="font-color:#09C6AB;"><b>${memberInfo.memberId}</b></span>
													</div>
												</li>
												
												<li class="diaryImgDetail">
													<img src="" alt="photo" id="modDiaryViewImg" class="modDiaryViewImg"
													style="width:500px; height:500px;">
												</li>
													<li class="recordModifyDateLi">
														<span id="recordModifyDateSpan">Date</span>
														<input type="text" name="recordModifyDate" id="recordModifyDate">
													</li>
													<li class="recordModifyLocationLi">
														<span id="recordModifyLocationSpan">Location</span>
														<input type="text" name="recordModifySpot" id="recordModifySpot">
													</li>
													<li class="recordModifyContentLi">
														<span id="recordModifyContentInViewSpan">Content</span>
														<textarea name="recordModifyContent" id="recordModifyContent" rows="4" cols="30"></textarea>
													</li>
													<li class="recordModifySecretLi">
														<span id="recordModifySecretSpan">Secret</span>
														<select id="recordModifySecret" name="recordModifySecret">
															<option value="public" selected="selected">공개</option>
															<option value="private">비공개</option>
														</select>
													</li>
													<li class="modModifyBtnLi">
														<input type="button" id="diaryViewModifyBtn" value="MODIFY">
														<input type="reset" id="diaryViewResetBtn" value="RESET">
													</li>
													<li class="recordSeqNumLi">
														<span id="recordModifySeq" style="display: none;"></span>
													</li>
												</ul>
											</div>
										</div>



									<!-- 									<div class="col-lg-4 col-md-4 col-sm-6"> -->
									<!-- 										<a href="../img/random.jpg" class="fh5co-card-item image-popup"> -->
									<!-- 											<figure> -->
									<!-- 												<img src="../img/random.jpg" class="img-responsive"> -->
									<!-- 											</figure> -->
									<!-- 										</a> -->
									<!-- 									</div> -->
									<%-- </c:forEach> --%>

								</div>
							</div>
						</div>
			</div>
	</div>

	</div>
	</li>

	</ul>
	</div>

	</header>
	</div>
	

<script>

</script>

</body>
</html>