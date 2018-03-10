<!-- 여행 후기 게시물 쓰기 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	});
</script>

<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>

<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">

<script type="text/javascript" src="../js/diaryWrite.js"></script>

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

<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

<script type="text/javascript">
	var memberId = '${memberId}';
</script>
<style type="text/css">
body {
	width: 100%;
	min-height: 700px;
	background-color: black;
	background-image: url(../img/bg1.jpg);
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
						<li class="has-dropdown"><a href="../itinerary">COMPANION</a>
							<ul class="dropdown">
								<li><a href="#">LIST</a></li>
							</ul></li>

						<!-- 추후 요청 변경 -->
						<li class="has-dropdown"><a href="../itinerary">DIARY</a>
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

		<header id="gtco-header" class="gtco-cover gtco-cover-md"
			role="banner" style="background-image: url(../img/bg1.jpg)">
		<div class="myPage">
			<ul id="splitMyPage">

				<li id="myDairyWrite">
					<div class="myDiary-box">
						<div class="myInfoTitle">
							<h3>My Diary Write</h3>
						</div>

						<!-- 작성 부분  -->

						<div class="row form-group" align="center">
							<div class="col-md-12">
								<div id="profile-box">

									<!-- Diary Form -->
									<form name="tripRecordFrm" action="../tripRecord/myDiaryWrite" method="post" enctype="multipart/form-data">
										<input type="hidden" name="memberId" value=${memberId }>
										
										<div class="myDiaryWriteContent">
											
											<!-- Thumbnail-->
											<div class="myDiaryWriteThumbnail-box">
												<!-- File #1 Thumbnail-->			
												<div id="myDiaryWriteFileThumbnail">
													<div id="DiaryThumbnail">
													</div>
												</div>
																								
												<div id="myDiaryWriteFileThumbnail2">
													<div id="DiaryThumbnail2">
													</div>
												</div>
																								
												<div id="myDiaryWriteFileThumbnail3">
													<div id="DiaryThumbnail3"> 
													</div>
												</div>
											</div>

											<!-- File -->
											<div class="myDiaryWriteFile-box">
												<div id="myDiaryWriteFile-input">
													<input type="file" name="file" id="diary_File_hidden" class="btn btn-primary btn-block"/>
													<input type="button" name="fileBtn" id="diary_FileBtn" class="btn btn-primary btn-block" value="FILE #1" >
												</div>
												
												<div id="myDiaryWriteFile-input2">
													<input type="file" name="file" id="diary_File_hidden2" class="btn btn-primary btn-block"> 
													<input type="button" name="fileBtn" id="diary_FileBtn2" class="btn btn-primary btn-block" value="FILE #2" >
												</div>
												
												<div id="myDiaryWriteFile-input3">
													<input type="file" name="file" id="diary_File_hidden3" class="btn btn-primary btn-block"> 
													<input type="button" name="fileBtn" id="diary_FileBtn3" class="btn btn-primary btn-block" value="FILE #3" >
												</div>
											</div>

											<!-- Content -->
											<div class="myDiaryWriteContent-box">
												<div id="myDiaryWriteContent">
													<label id="myDiaryContentlb">Memo</label>
												</div>
												<div id="myDiaryWriteContent-input">
													<div id="myDiaryWriteContent-input">
														<textarea name="recordContent" id="recordContent" cols="47" rows="5"></textarea>
													</div>
<!-- 													<div id="myDiaryWriteContent-text"> -->
<!-- 														<span id="textCount"></span> -->
<!-- 													</div> -->
												</div>
											</div>	
																				
											<!-- Location -->
											<div class="myDiaryWriteLoc-box">
												<div id="myDiaryWriteLoc">
													<label>Location</label>
												</div>
												<div id="myDiaryWriteLoc-input">
													<input type="text" name="recordSpot" id="recordSpot">
												</div>
											</div>
											
											<!-- Date -->
											<div class="myDiaryWriteDate-box">
												<div id="myDiaryWriteDate">
													<label>Date</label>
												</div>
												<div id="myDiaryWriteDate-input">
													<input type="text" name="recordDate" id="recordDate">
												</div>
											</div>
											
											<!-- Secret -->
											<div class="myDiaryWriteSecret-box">
												<div id="myDiaryWriteSecret">
													<label>Secret</label>
												</div>
												<div id="myDiaryWriteSecret-input">
													<select id="recordSecret" name="recordSecret">
														<option value="public" selected="selected">공개</option>
														<option value="private">비공개</option>
													</select>
												</div>
											</div>
										</div>
										<br><br>
										
										<!-- Buttons -->
										<div class="myDiaryWriteBtn-box">
											<div id="diaryWriteButton">
												<input type="submit" class="btn btn-primary"
													id="myDiaryWriteBtn" name="myDiaryWriteBtn" value="Write">
											</div>
											<div id="diaryResetBtn">
												<input type="reset" class="btn btn-primary" id="resetBtn"
													value="Reset">
											</div>
											<div id="diaryCancelBtn">
												<input type="button" class="btn btn-primary" id="cancleBtn"
													value="Cancel" onclick="location.href='myDiaryList'">
											</div>
										</div>
									</form>

								</div>
							</div>
						</div>

					</div>
				</li>

			</ul>
		</div>

		</header>
	</div>
</body>
</html>