<!-- 회원 가입 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.js"
integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
crossorigin="anonymous"></script>
<script type="text/javascript" src="../js/join.js"></script>

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>

<style type="text/css">

body{
	font-family: 'Jeju Gothic', serif;
}

#idCheck, #pwCheck, #emailCheck {
font-size: 12px;
color: red;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords"
content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="GetTemplates.co" />

<!-- Facebook and Twitter integration -->
<meta property="og:title" content="" />
<meta property="og:image" content="" />
<meta property="og:url" content="" />
<meta property="og:site_name" content="" />
<meta property="og:description" content="" />
<meta name="twitter:title" content="" />
<meta name="twitter:image" content="" />
<meta name="twitter:url" content="" />
<meta name="twitter:card" content="" />
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
<!-- Modernizr JS -->
<script src="../js/modernizr-2.6.2.min.js"></script>
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
</div>
</div>
</nav>

    <header id="gtco-header" class="gtco-cover gtco-cover-md"
        role="banner" style="background-image: url(../img/bg2.jpg)">
        <div class="overlay"></div>
        <div class="gtco-container">
            <div class="row">
                <div class="col-md-12 col-md-offset-0 text-left">
                    <div class="row row-mt-12em">
                        <div class="col-md-4 col-md-push-1 animate-box" data-animate-effect="fadeInRight">
                            <div class="form-wrap">
                                <div class="tab">
                                    <div class="tab-content">
                                        <div class="tab-content-inner active" data-content="signup">
                                            <h3>Join</h3>
                                            <form name="joinForm" action="join" method="post">

                                                <%-- ID --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="id">ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                        <label id="idCheck"></label> 
                                                        <input type="text" id="memberIdTx" name="memberId" class="form-control" value="${memberId }">
                                                    </div>
                                                </div>

                                                <%-- PW --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="pw">PW</label> 
                                                        <input type="password" id="memberPass" name="memberPass" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="pwCheck">PW Check&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                                        <label id="pwCheck"></label>
                                                        <input type="password" id="memberPassCheck" class="form-control" onkeyup="join_checkPw()">
                                                    </div>
                                                </div>

                                                <%-- NAME --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="name">Name</label> 
                                                        <input type="text" id="memberName" name="memberName" class="form-control" value="${memberName }">
                                                    </div>
                                                </div>

                                                <%-- EMAIL --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="email">Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                        <label id="emailCheck"></label> 
                                                        <input type="text" id="memberEmailTx" name="memberEmail" class="form-control" value="${memberEmail }">
                                                    </div>
                                                </div>

                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <input type="submit" class="btn btn-primary btn-block" id="joinNextBtn" value="NEXT" onclick="return joinSubmit()">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
</div>

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
</body>
</html>