<!-- 아이디, 비밀번호 찾기 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>TRIPPY TRIPPER &mdash; FIND ID/PASSWORD</title>
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
<!-- Modernizr JS -->
<script src="../js/modernizr-2.6.2.min.js"></script>

<style type="text/css">

body{
	font-family: 'Jeju Gothic', serif;
}

</style>

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
							<a href="login">TRIPPY TRIPPER <em>.</em></a>
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
										<div id="findIdCotainer" class="tab-content">
											<div id="findIdCotainer_inner" class="tab-content-inner active" data-content="signup">
												<h3>Find ID</h3>
												<form action="findId" method="post">
													<div class="row form-group">
														<div class="col-md-12" style="margin-top:50px;">
															<label for="memberName">NAME</label> <input type="text"
																id="memberName" name="memberName" class="form-control">
														</div>
													</div>
													<div class="row form-group">
														<div class="col-md-12">
															<label for="memberEmail">EMAIL</label> <input type="text"
																id="memberEmail" name="memberEmail" class="form-control">
														</div>
													</div>

													<div class="row form-group">
														<div class="col-md-12">
															<input type="submit" class="btn btn-primary btn-block"
																value="FIND ID" style="margin-top:58px;">
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-md-push-1 animate-box"
								data-animate-effect="fadeInRight" style="margin-left:50px;">
								<div class="form-wrap">
									<div class="tab">
										<div class="tab-content">
											<div class="tab-content-inner active" data-content="signup">
												<h3>Find PW</h3>
												<form action="findPw" method="post">
													<div class="row form-group">
														<div class="col-md-12">
															<label for="memberId">ID</label> <input type="text"
																id="memberId" name="memberId" class="form-control">
														</div>
													</div>
													<div class="row form-group">
														<div class="col-md-12">
															<label for="memberName">NAME</label> <input type="text"
																id="memberName" name="memberName" class="form-control">
														</div>
													</div>
													<div class="row form-group">
														<div class="col-md-12">
															<label for="memberEmail">EAMIL</label> <input type="text"
																id="memberEmail" name="memberEmail" class="form-control">
														</div>
													</div>

													<div class="row form-group">
														<div class="col-md-12">
															<input type="submit" class="btn btn-primary btn-block"
																value="FIND PW" style="margin-top:20px;">
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