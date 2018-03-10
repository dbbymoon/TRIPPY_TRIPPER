<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<h2 class="w3-center">Manual Slideshow</h2>

<div class="w3-content w3-display-container">
  <img class="mySlides" src="../diaryImg/0d87ff92-fefb-4ddf-874c-c3227bdd789d_d141726c-1350x900.jpg" style="width:100%">
  <img class="mySlides" src="../diaryImg/10d99894-95a5-4a7c-a208-cf2516f099fb_KakaoTalk_20180123_185944417.jpg" style="width:100%">
  <img class="mySlides" src="../diaryImg/1437e143-1412-4ead-9536-6841e7fcc5fe_165891_golden-clouds-wallpaper-jpg_2560x1600_h.jpg" style="width:100%">
  <img class="mySlides" src="../diaryImg/1710d219-2919-473c-8706-a145d465ef86_badacsony-wallpapers-background-travel-city-building-160568.jpg" style="width:100%">

  <button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
</div>

<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>

</body>
</html>