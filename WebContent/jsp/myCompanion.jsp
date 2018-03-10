<!-- 내가 쓴 동행 게시글 리스트-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
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

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>


<script type="text/javascript">
var memberId = '${memberId}';
</script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<!-- sweetalert js -->
<script src="js/sweetalert2.min.js"></script>

<!-- sweetalert css -->
<link rel="stylesheet" type="text/css" href="css/sweetalert2.css">

<script type="text/javascript" src="../js/myInfo.js"></script>

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
<!-- Bootstrap -->
<link rel="stylesheet" href="../css/bootstrap.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="../css/magnific-popup.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="../css/bootstrap-datepicker.min.css">
<!-- Owl Carousel -->
<link rel="stylesheet" href="../css/owl.carousel.min.css">
<link rel="stylesheet" href="../css/owl.theme.default.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../css/style.css">

<!-- jquery-ui resource embed start -->
<link href="resources/jqueryui/css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet">
<script src="resources/jqueryui/js/jquery-ui-1.8.16.custom.min.js"></script>
<!-- jquery-ui resource embed end -->

<!-- Modernizr JS -->
<script src="js/modernizr-2.6.2.min.js"></script>

<!-- FOR IE9 below -->
<!--[if lt IE 9]>
<script src="js/respond.min.js"></script>
<![endif]-->
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
							<li><a href="../tMember/myItinerary">MyTrip</a></li>
						</ul>

                    <!-- 추후 요청 변경 -->
                    <li class="has-dropdown"><a href="../companion">COMPANION</a>
                        <ul class="dropdown">
                            <li><a href="../tMember/MyCompanion">MyCompanion</a></li>
                        </ul>
                    </li>

                    <!-- 추후 요청 변경 -->
                    <li class="has-dropdown"><a href="../tripRecord/tripRecordList">DIARY</a>
                        <ul class="dropdown">
                            <li><a href="#">MyDiary</a></li>
                        </ul>
                    </li>

                    <li><a href="myInfo">MY PAGE</a></li>

                    <li><a href="../tMember/logout">LOGOUT</a></li>
                </ul>
            </div>
        </div>
    </div>
    </nav>

    <header id="gtco-header" class="gtco-cover gtco-cover-md" role="banner" style="background-image: url(../img/bg1.jpg)">
    <div class="myPage">
        <ul id="splitMyPage">
            <li id="navi">
                <ul id="naviList"> 
                    <li><span id="profile"><img class="myPageProfileImg" id="myPageProfileImg"
                            src="../profileImg/${memberProfile}"></span></li>
   
                    <li style="margin-top:30px;"><a href="myInfo" style="color:black;">내정보</a></li>
                    <li><a href="#" style="color:black">나의 여행계획</a></li>
                    <li><a href="../tripRecord/myDiaryList" style="color:black">나의 다이어리</a></li>
                    <li><a href="myCompanion" style="color:black; font-size:18px;"><b>동행인</b></a></li>
        
                </ul>
            </li>
            <li id="myPageDetail" style="overflow:auto;">
           		<div class="myCompanionContent">
           			<div class="myCompanionContentBtn">
           			<button id="decidedCompanion" class="myCompanionTypeBtn" >확정된 동행</button>
           			<button id="waitingCompanion" class="myCompanionTypeBtn" >대기중인 동행</button>
           			</div>
           			<div class="myCompanionContentTable">
           			<table id="CompanionConditionList">
           				<c:forEach var="companion" items="${companionList}">
           				<c:set var="memberId" value="${memberId}"/>
							<c:if test ="${companion.memberId ne memberId}">
								<tr>
								<td id="myCompanionMemberProfile" class='myCompanionList' height='80px' width='80px' align='left'><img src="../profileImg/${companion.memberProfile}" class="myCompanionProfile"></td>
           						<td id="myCompanionMemberId" class='myCompanionList' width='120px' align='left'>${companion.memberId}</td>
           						<td id="myCompanionTourDate" class='myCompanionList' width='100px' align='center'><fmt:formatDate value="${companion.tourDate}" pattern="yyyy-MM-dd"/></td>
           						<td id="myCompanionDeparture" class='myCompanionList' width='400px' align='center'>${companion.departure}</td>
           						<td id="myCompanionDestination" class='myCompanionList' width='400px' align='center'>${companion.destination}</td>
           						<td><button class="CompanionListDeleteBtn" onclick="delMyCompanion(${companion.companionSeq})">cancel</button></td>
           						</tr>
							</c:if>
           				</c:forEach>
           			</table>
           			</div>
           		</div>
            </li>
        </ul>
    </div>
    
    </header>
</div>
</body>
</html>