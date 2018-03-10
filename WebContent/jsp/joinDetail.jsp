<!-- 회원 가입 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.js"
integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
crossorigin="anonymous"></script>

<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>


<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>TRIPPY TRIPPER &mdash; Travel WebSite</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
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

<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
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
<script type="text/javascript" src="../js/join.js"></script>
<script type="text/javascript">

var memberId = '${memberId}';

</script>
<style type="text/css">

body{
	font-family: 'Jeju Gothic', serif;
}

#file_hidden {
opacity: 0; /* input type="file" tag 투명하게 처리 */
position: absolute;
background-color: #F7819F;
border: 2px solid #F7819F !important;
}
</style>
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
                        <div class="col-md-4 col-md-push-1 animate-box"
                            data-animate-effect="fadeInRight">
                            <div class="form-wrap">
                                <div class="tab">
                                    <div class="tab-content">
                                        <div class="tab-content-inner active" data-content="signup">
                                            <h3>Join</h3>
                                            <form action="joinDetail" name="joinDetailForm" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="memberId" value="${memberId }">

                                                <%-- 프로필 --%>
                                                <div class="row form-group" align="center">
                                                    <div class="col-md-12">
                                                        <span id="profile"><img class="profileImg" id="profileImg" src="../profileImg/basic_profile.png"></span>
                                                        <input type="file" name="file" id="file_hidden" class="btn btn-primary btn-block"> 
                                                        <input type="button" name="fileBtn" id="fileBtn" class="btn btn-primary btn-block" value="FILE">
                                                    </div>
                                                </div>


                                                <%-- 성별 --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="gender">Gender</label> 
                                                        <select name="memberGender" id="memberGender" name="memberGender" class="form-control">
                                                            <option value="woman">Woman</option>
                                                            <option value="man">Man</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <%-- 자기소개 --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="intro">Intro</label> 
                                                        <input type="text" id="memberIntro" name="memberIntro" class="form-control">
                                                    </div>
                                                </div>

                                                <%-- 정보 공개 여부 --%>
                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <label for="memberSecret">Secret<img alt="secret" src="../img/lock.png" width="20px" height="20px"></label>
                                                        <select name="memberSecret" id="memberSecret" name="memberSecret" class="form-control">
                                                            <option value="off">OFF</option>
                                                            <option value="on">ON</option>
                                                        </select>
                                                    </div>
                                                </div> <br>

                                                <div class="row form-group">
                                                    <div class="col-md-12">
                                                        <input type="submit" class="btn btn-primary btn-block" value="JOIN">
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