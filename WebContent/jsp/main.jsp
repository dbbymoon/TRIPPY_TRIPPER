<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700"
rel="stylesheet">
<!-- Animate.css -->
<link rel="stylesheet" href="css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="css/icomoon.css">
<!-- Themify Icons-->
<link rel="stylesheet" href="css/themify-icons.css">
<!-- Bootstrap -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="css/magnific-popup.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="css/bootstrap-datepicker.min.css">
<!-- Owl Carousel -->
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="css/style.css">

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
background-image: url(img/bg1.jpg);
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
					<li class="has-dropdown"><a href="itinerary/start">ITINERARY</a>
						<ul class="dropdown">
							<li><a href="../tMember/myItinerary">MyTrip</a></li>
						</ul></li>

					<!-- 추후 요청 변경 -->
                    <li class="has-dropdown"><a href="companion">COMPANION</a>
                        <ul class="dropdown">
                            <li><a href="tMember/myCompanion">MyComponion</a></li>
                        </ul>
                    </li>

                    <!-- 추후 요청 변경 -->
                    <li class="has-dropdown"><a href="tripRecord/tripRecordList">DIARY</a>
                        <ul class="dropdown">
                            <li><a href="tripRecord/myDiaryList">MyDiary</a></li>
                        </ul>
                    </li>

                    <!-- 추후 요청 변경 -->
                    <li><a href="tMember/myInfo">MY PAGE</a></li>

                    <li><a href="tMember/logout">LOGOUT</a></li>
                </ul>
            </div>
        </div>
    </div>
    </nav>

    <header id="gtco-header" class="gtco-cover gtco-cover-md" role="banner" style="background-image: url(img/bg1.jpg)">
    <div class="main">
        <ul id="button">
            <li id="leftbutton"><a href='itinerary/start'>Travel plan</a></li>
            <li id="middlebutton"><a href='companion'>Get Companion</a></li>
            <li id="rightbutton"><a href='tripRecord/tripRecordList'>Trip Record</a></li>
        </ul>
    </div>
    </header>
</div>
</body>
</html>