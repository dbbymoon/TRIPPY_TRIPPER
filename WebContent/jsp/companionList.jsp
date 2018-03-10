<!-- 동행 게시글  리스트 -->
<!-- 내 정보 조회, 수정, 삭제 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="GetTemplates.co" />

<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>

<!-- cReply js -->
<script src="js/cReply.js"></script>

<!-- cReply css -->
<link rel="stylesheet" type="text/css" href="css/cReply.css">

<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>
	
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">
	
<!-- jQuery companion -->
<script src="js/companion.js"></script>
<!-- jQuery -->
<script src="js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="js/jquery.waypoints.min.js"></script>
<!-- Carousel -->
<script src="js/owl.carousel.min.js"></script>
<!-- countTo -->
<script src="js/jquery.countTo.js"></script>
<!-- Stellar Parallax -->
<script src="js/jquery.stellar.min.js"></script>
<!-- Magnific Popup -->
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/magnific-popup-options.js"></script>
<!-- Datepicker -->
<script src="js/bootstrap-datepicker.min.js"></script>
<!-- Main -->
<script src="js/main.js"></script>
<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>
<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
<!-- Animate.css -->
<link rel="stylesheet" href="css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="css/icomoon.css">
<!-- Themify Icons-->
<link rel="stylesheet" href="css/themify-icons.css">
<!-- Bootstrap  -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="css/magnific-popup.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="css/bootstrap-datepicker.min.css">
<!-- Owl Carousel  -->
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<!-- Theme style  -->
<link rel="stylesheet" href="css/style.css">

<!-- Modernizr JS -->
<script src="js/modernizr-2.6.2.min.js"></script>

<!-- DiaryList.js -->
<script src="js/diaryList.js"></script>
	
<!-- jquery-ui resource embed start -->
<link  href="resources/jqueryui/css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet">
<script src="resources/jqueryui/js/jquery-ui-1.8.16.custom.min.js"></script>
<!-- jquery-ui resource embed end -->


<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyCDaCyJ-nputHM4cp2ogGZjCC_3ASAg-uE&libraries=places"></script>
<script type="text/javascript">
    var memberId = '${memberId}';
    var memberProfile = '${memberProfile}';
</script>
<style type="text/css">
body {
	width: 100%;
	min-height: 700px;
	background-color: black;
	background: url(img/bg1.jpg) no-repeat center center fixed;
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
							<a href="main">TRIPPY TRIPPER <em>.</em></a>
						</div>
					</div>
					<div class="col-xs-8 text-right menu-1">
						<ul>
							<li class="has-dropdown">
							<li class="has-dropdown"><a href="itinerary/start">ITINERARY</a>
								<ul class="dropdown">
									<li><a href="tMember/myItinerary">MyTrip</a></li>
								
								</ul>
							</li>

							<li class="has-dropdown">
							<a href="companion">COMPANION</a>
								<ul class="dropdown">
									<li><a href="tMember/myCompanion">MyComponion</a></li>
								</ul>
							</li>
					
							<li class="has-dropdown">
							<a href="tripRecord/tripRecordList">DIARY</a>
								<ul class="dropdown">
									<li><a href="tripRecord/myDiaryList">MyDiary</a></li>
								
								</ul>
							</li>
							
							<li>
							<a href="tMember/myInfo">MYPAGE</a>
							</li>
							

                    		<li>
                    			<a href="tMember/logout">LOGOUT</a>
                    		</li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
		
		<header id="gtco-header" class="gtco-cover gtco-cover-sm" role="banner" style="background-image: url(img/bg1.jpg)">
		<div class="overlay"></div>
		<div class="gtco-container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 text-center">
					<div class="row row-mt-15em">

						<div class="col-md-12 mt-text animate-box" data-animate-effect="fadeInUp">
							<h1>Companion</h1>	
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
					<h2>Trip With Person Who Same Mind With You</h2>
					<p style="color:white; font-size:40px;font-family: 'Nanum Pen Script', cursive;">혼자 떠나는 여행에서 혼자이고 싶지 않은 당신을 위한 공간</p>
					<p><span class="btn btn-primary" id="companionWrite">Write</span></p>
					
					<p style="margin-left:50px">
						<form action="companion" method=post>
							<input type="hidden" name="type" value="1">
							<input type="text" name="companionSearch1" id="companionSearch1" placeholder="출발지"> <b>-</b> 
							<input type="text" name="companionSearch2" id="companionSearch2" placeholder="도착지">&ensp;
							<button class="companionSearchBtn">
							<img src="img/searcher.png" style="width:20px; height:20px"></button>
						</form>
						<form action="companion" method=post>
							<input type="hidden" name="type" value="2">
							<input type="text" name="companionSearchId" id="companionSearchId" style="width:272px;"placeholder="아이디">&ensp;
							<button class="companionSearchBtn">
							<img src="img/searcher.png" style="width:20px; height:20px"></button>
						</form>
					</p>
					
				</div>
			</div>
			
			<c:forEach var="companion" items="${companionList}">
				<div class="col-lg-4 col-md-4 col-sm-6">
					<span id="boxsize" class="fh5co-card-item">
						<div class="fh5co-text">
							
							<div class="comListDiv">		
								<div><input type="button" class="comList" value="=" onclick="goWithList('${companion.companionSeq}', '${companion.memberId}')"></div>
								<div class="viewMDBtn">
<!-- 								 본인이 쓴글이면 생기고 아니면 없어지게 해야함 -->
								 	<span id="companionSeq" style="display:none">${companion.companionSeq}</span>
								 	<c:set var="id" value="${memberId}"/>
									<c:if test ="${companion.memberId eq id}">
									<input type="button" class="btn-primary topViewBtn" value="M" onclick="ModifyComponion('${companion.companionSeq}')" style="background:black; font-size:4px; width:20px; height:22px; border:2px solid black !important;">
							    	<input type="button" class="btn-primary topViewBtn" value="D" onclick="DeleteComponion('${companion.companionSeq}')" style="background:black; font-size:4px; width:20px; height:22px; border:2px solid black !important;">
							    	</c:if>
							    	<c:if test ="${companion.memberId ne id}">
							    		<div class="emptySpan"></div>
							    	</c:if>
							    </div>
							</div>
							<div class="viewCompanion">
								<div class="viewCompanion-content">
									<p><img src='profileImg/${companion.memberProfile}' class="profileImgCom">
		
									<span id="companionMemberId" onclick="memberInfoBtn('${companion.memberId}',1)">${companion.memberId}</span>
									</p>
									<p><div class="companiontitle">출발지</div><div class="viewCompanionFont">${companion.departure}</div></p>
									<p><div class="companiontitle">도착지</div><div class="viewCompanionFont">${companion.destination}</div></p>
									<p><div class="companiontitle">상세목적지</div><div class="viewCompanionFont">${companion.detailSpot}</div></p>
									<p><div class="companiontitle">여행일</div><div class="viewCompanionFont"><fmt:formatDate value="${companion.tourDate}" pattern="yyyy-MM-dd"/></div></p>
									<p><div class="companiontitle">교통수단</div><div class="viewCompanionFont">${companion.vehicles}</div></p>
									<p><div class="companiontitle">동행인 성별 </div><div class="viewCompanionFont">${companion.companionGender}</div></p>
									<p style="text-align:center; font-style:italic;" >${companion.companionDeterminNum}/<b>${companion.companionNum+1}</b></p>
								</div>
								
								<div class="viewCompanion-memo">
									<p>${companion.companionMemo}</p>
								</div>
								
							</div>
							<p  class="viewBtn">	
								<input type="submit" id="goWith" class="btn btn-primary" onclick="returnSeq('${companion.companionSeq}')" value="GoWith">
							    <input type="button" id="viewReply" class="btn btn-primary" onclick="viewReplyMod('${companion.companionSeq}', '${companion.memberId}')" value="Commets">
							</p>
						</div>
						
					</span>
				</div>
			</c:forEach>

			</div>
		</div>
	</div>
	
	<!-- 댓글 모달창 -->
	<div class="replyModContainer" style="display:none;">
		<div class="replyModContainerTopLine"></div>
		<div class="replyContent">
			<div class="viewReply">
				<!--댓글은 ajax로 삽입 -->
				<table id="viewReplyTable"></table>
			</div>
			<div id="writeReply">
				<div id="saveReplyNum" style="display:none">0</div>
<!-- 				style="display:none" -->
				<div id="replycompanionSeq" style="display:none"></div>
				<textarea name="reContent" id="reContent" style="overflow:hidden;"></textarea>
				
				<img src="img/padlock_black.png" class="padlock"/>
				<div class="typeOfSecret" style="display:none">1</div><!-- 1은 공개, 2는 비공개 -->
				
				<input type="button" id="addReplyBtn" value="작성">
				<input type="button" id="closeReplyBtn" value="닫기">			
			</div>
		</div>
	</div>
	
	
	<!-- 글 작성 위한 모달창 -->
	<div id = "modDiv" style="display:none;">
<!-- 		<div class = "modal-title">Write</div> -->
		<div class = "modal-content">
			<ul>
				<li><p><img src='profileImg/${memberProfile}' class="modalProfileImg"><span id="companionMemberId">${memberId}</span></p></li>
				<li><span style="display:inline-block;width:90px;">날짜</span><input type="text" name="tourDate" id ="tourDate" class="datePicker"></li>
				<li><span style="display:inline-block;width:90px;">출발지</span><input type="text" name="departure" id="departure"></li>
	   		    <li><span style="display:inline-block;width:90px;">목적지</span><input type="text" name="destination" id="destination"></li>
	       		<li><span style="display:inline-block;width:90px;">상세 목적지</span><input type="text" name = "detailSpot" id="detailSpot"></li>
				<li><span style="display:inline-block;width:90px;">이동수단</span>
							<select name="vehicles" id="vehicles">
								<option value="도보" selected="selected">도보</option>
								<option value="자전거">자전거</option>
								<option value="지하철" >지하철</option>
								<option value="버스" >버스</option>
								<option value="택시">택시</option>
								<option value="비행기">비행기</option>
								<option value="기차">기차</option>
								<option value="자차">자차</option>
								<option value="랜트카">랜트카</option>
							</select></li>
				<li><span style="display:inline-block;width:90px;">성별</span>
				<select id="companionGender" name="companionGender">
							<option value="여자" selected="selected">여자</option>
							<option value="남자">남자</option>
							<option value="상관없음">상관없음</option>
						  </select></li>
				<li><span style="display:inline-block;width:90px;">동행인 수</span>
							<select id="companionNum" name="companionNum">
								<option value="1" selected="selected">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
			  				</select></li>
				<li>
				<span style="display:inline-block;width:90px;">상세내용</span>
				<textarea name="companionMemo" id="companionMemo" style="overflow:hidden;" cols="67" rows="4"></textarea>
				</li>
			</ul>
		</div>
		<br>
		<div class="modal-btn">
			<button class="btn btn-primary" id = "writeBtn">글 작성</button>	<!-- replyModBtn -->
			<button class="btn btn-primary" id = "closeBtn">닫기</button>
		</div>
	</div>
	
	
	<!-- 글 수정 위한 모달창 -->
	<div id = "modDivModify" style="display:none;">
		<div class = "modal-content">
			<ul>
				<li style="display:none">글번호 :<span id="mcompanionSeq"></span></li>
				<li><p><img src='profileImg/${memberProfile}' class="modalProfileImg"><span id="companionMemberId">${memberId}</span></p></li>
				<li><span style="display:inline-block;width:90px;">날짜</span><input type="text" name="tourDate" id ="mtourDate" class="datePicker"></li>
				<li><span style="display:inline-block;width:90px;">출발지</span><input type="text" name="departure" id="mdeparture"></li>
	   		    <li><span style="display:inline-block;width:90px;">목적지</span><input type="text" name="destination" id="mdestination"></li>
	       		<li><span style="display:inline-block;width:90px;">상세 목적지</span><input type="text" name = "detailSpot" id="mdetailSpot"></li>
				<li><span style="display:inline-block;width:90px;">이동수단</span>
							<select name="vehicles" id="mvehicles">
								<option value="도보" selected="selected">도보</option>
								<option value="자전거">자전거</option>
								<option value="버스" >버스</option>
								<option value="택시">택시</option>
								<option value="자차">자차</option>
								<option value="랜트카">랜트카</option>
							</select></li>
				<li><span style="display:inline-block;width:90px;">성별</span>
				<select id="mcompanionGender" name="companionGender">
							<option value="여자" selected="selected">여자</option>
							<option value="남자">남자</option>
							<option value="상관없음">상관없음</option>
						  </select></li>
				<li><span style="display:inline-block;width:90px;">동행인 수</span>
							<select id="mcompanionNum" name="companionNum">
								<option value="1" selected="selected">2</option>
								<option value="2">3</option>
								<option value="3">4</option>
								<option value="4">5</option>
								<option value="5">5</option>
			  				</select></li>
				<li>
				<span style="display:inline-block;width:90px;">상세내용</span>
				<textarea name="companionMemo" id="mcompanionMemo" style="overflow:hidden;" cols="68" rows="4"></textarea>
				</li>
			</ul>
		</div>
		<br>
		<div class="modal-btn">
			<button class="btn btn-primary" id = "ModifyBtn" >수정</button>
			<button class="btn btn-primary" id ="ModifyCloseBtn">닫기</button>
		</div>
	</div>
	
	<!-- 동행인 리스트 모달 -->
	<div id="modGoWithList" style="display:none;">
		<div>
			<button class="goWithCloseBtn" id ="goWithClose" style="float:right; margin-right:-10px;">X</button>
		</div>
		<div>
			<table id="goWith_content">

			<!-- for문을 이용해서 전체 리스트를 출력-->
			<!-- if문을 이용해서 상태가 2(확정)인 사람과 대기(1)인 사람을 나누어서 출력한다. -->

			</table>
		</div>
	</div>
	
		<!-- 아이디를 누르면 뜨는 메뉴 모달창 -->
		<div id="modMenu" style="display:none;">
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