<!-- 여행 일정 짜기 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Free HTML5 Website Template by GetTemplates.co" />
<meta name="keywords"
	content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="GetTemplates.co" />

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous"></script>
	
<!-- 폰트 추가 -->
<link rel='stylesheet' href='http://fonts.googleapis.com/earlyaccess/jejugothic.css'>

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
<!-- Sweetalert js -->
<script src="../js/sweetalert2.min.js"></script>
<!-- <script src="resources/jqueryui/js/jquery-ui-1.8.16.custom.min.js"></script> -->
<!-- Sweetalert css -->
<link rel="stylesheet" type="text/css" href="../css/sweetalert2.css">
<!-- Google web font -->
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
<!-- <link  href="resources/jqueryui/css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet"> -->
<!-- Modernizr JS -->
<!-- <script src="js/modernizr-2.6.2.min.js"></script> -->
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

<!-- Itinerary Style -->
<link rel="stylesheet" href="../css/itinerary.css">
<!-- Itinerary js -->
<script type="text/javascript"
   src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyBb796ancA-ilugo1wUB7YPsuuDQ5U4CIY&libraries=places"></script>
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

<script type="text/javascript">
$(function(){
	//장소 자동 완성
	var autocomplete = new google.maps.places.Autocomplete(document.getElementById('tourSpot'));
	var autocomplete1 = new google.maps.places.Autocomplete(document.getElementById('start'));
	var autocomplete2 = new google.maps.places.Autocomplete(document.getElementById('fin'));
});


 /*********************************************************************************************************/
 /*********************************************GOOGLE MAP API**********************************************/
 /*********************************************************************************************************/

 //0. Google Map 생성을 위한 변수 준비
	var map; 	//구글 맵
	//장소 추천
	var places, iw;		
	var markers = [];
	var autocomplete;
	//길찾기
	var directionsDisplay;
	var directionsService = new google.maps.DirectionsService();

//1. 지도 그리기
function initialize() {
	//google Map 생성
	var myLatlng = new google.maps.LatLng(37.5536067, 126.96961950000002);
	var myOptions = {
		zoom: 14,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById('map'), myOptions);
	
	//places API 준비
	places = new google.maps.places.PlacesService(map);
	google.maps.event.addListener(map, 'tilesloaded', tilesLoaded);
	autocomplete = new google.maps.places.Autocomplete(document.getElementById('autocomplete'));
	google.maps.event.addListener(autocomplete, 'place_changed', function () {
		showSelectedPlace();
	});
	//directions API 준비
	directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
 		showSelectedPlace();
 	});
}

//2. directions API 
//1) 길 찾기 결과 지도에 그리기 : Maps Javascript API 이용 
//2) 길 찾기 정보 텍스트로 띄우기 : Directions API 이용
function calcRoute() {
$("#addTransportBtn").remove();
$("#naviResult tr").remove();

var start = document.getElementById('start').value;      //출발지
var fin = document.getElementById('fin').value;         //도착지
var naviBox = document.getElementById('naviBox');      //길찾기 정보가 담긴 텍스트(div)가 붙여질 영역(div)

//화면에 띄워진 길찾기 결과 정보에서 TRANSPORT 일정 추가 시 필요한 변수 준비
var distance;   //전체 이동 거리
var duration;   //전체 소요 시간

//2.1. 길찾기 정보 data 가져오기
//Ajax /directions : 텍스트에 띄울 길찾기 정보를 가져오는 Ajax 요청 
// : data를 받아오면 화면에 정보를 띄운다
$.ajax({
       url:"directions",
       type:"GET",
       data:{
         start:start,
         fin:fin
       },
       datatype:"json",
       success:function(data){
         //TRANSPORT 일정 추가 시 필요한 변수 준비
         var memberId='${memberId}';
         var tourName=$("#tourName").html();
         var departureDate = new Date($("#departureDate").html());
         var endDate=new Date($("#endDate").html());
         var tourDate_show = $("#tourDate").html();   //여행 날짜
         var tourDate =new Date("2018/"+tourDate_show);
         
      //2.1.1. 화면에 띄우기

         //2.1.2.Transport-TRANSIT (대중교통 이용) 일정 추가 버튼
         // : 버튼이 눌리면 Ajax 요청을 통해 DB에 일정 추가 및 화면의 내 일정 목록에 추가
         var addTransportBtn = document.createElement('button');      
         var btnText = document.createTextNode("ADD");
         addTransportBtn.setAttribute("id","addTransportBtn");
         addTransportBtn.appendChild(btnText);
         addTransportBtn.addEventListener("click",function(){
            //일정 목록에서의 마지막 일정의 종류 : TOUR 인지 TRANSPORT 인지
            var lastElement = document.getElementById("scheduleBox").lastElementChild.getAttribute("class");
            if(lastElement=='transport'){
               //일정 목록 마지막이 transport 일정이면 transport가 연속으로 추가되지 않는다.
		       		swal({title: 'Error!',text: '장소를 삽입해 주세요.',type: 'error',confirmButtonText: 'OK',});
            }else{
               //Ajax /addTransport : DB에 TRANSPORT 일정 추가
               $.ajax({
                   url:"addTransport",
                      type:"POST",
                      data:{
                        memberId:memberId,
                        tourName:tourName,
                        departureDate:departureDate,
                        endDate:endDate,
                        tourDate:tourDate,
                        departure:start,
                        destination:fin,
                        duration:duration,
                        distance:distance
                      },
                      datatype:"json",
                      success:function(result){	// result는 DB에서 가져온 itinerarySeq를 반환한다.
                         if(result>0){
                           var itinerarySeq = result;
						//추가된 TRANSPORT 일정을 화면의 내 일정 목록에 추가
						var box = document.getElementById('scheduleBox');
						var div = document.createElement('div');
						div.classList.add('transport');
						var table = document.createElement('table');
						table.classList.add('transportTable');
						var deleteBtn = document.createElement('button');
						deleteBtn.innerHTML ="<img src='../img/cancel.png' width='7px'>";
						deleteBtn.classList.add('scheduleBtn');
						deleteBtn.addEventListener("click",function(event){	//TRANSPORT 일정 삭제 버튼
							$.ajax({
								url:"deleteTransport",
								type:"POST",
								data:{
									itinerarySeq : itinerarySeq,
								},
								datatype : "json",
								success : function(result){
									if(result=="SUCCESS"){
										swal({title: 'SUCCESS!',text: '삭제 되었습니다.',type: 'success',confirmButtonText: 'OK',}).then(function(){location.reload(true)});
									}
								},
								error : function(request,status,error){
									swal({title: 'Error!',text: '실패',type: 'error',confirmButtonText: 'OK',});
								}
							});
						});
						div.appendChild(deleteBtn);
                        var transportTr = document.createElement('tr');
                        var transportTd = document.createElement('td');
						//btn : TRANSPORT 일정의 정보 (이동 거리,소요 시간)를 띄우고 버튼을 누르면 길찾기 상세 정보를 알려준다.
                        var btn = document.createElement('button');
                        btn.setAttribute("class","transitDetailBtn");
						var text = document.createTextNode(distance+","+duration);
						btn.addEventListener("click",function(event){
							showDirections(departure,destination);	// 현재 TRANSPORT 일정의 길찾기 상세 정보를 알려주는 기능
						});
						btn.appendChild(text);
						transportTd.appendChild(btn);
						transportTr.appendChild(transportTd);
						table.appendChild(transportTr);
						div.appendChild(table);
						box.appendChild(div);
                        }
                      },error:function(request,status,error){
                    	  swal({title: 'ERROR!',text: '실패',type: 'error',confirmButtonText: 'OK',});
                      }
				});
            }
         },false);		//addTransportBtn(대중교통 이용 TRANSPORT 일정 추가 버튼)이 하는 기능 끝
        
		naviBox.appendChild(addTransportBtn);
     
	 
		//2.1.1.(이어서) 길찾기 결과 정보로 받아온 data를 화면에 띄운다.
         var results = document.getElementById('naviResult');	//길찾기 정보를 띄울 테이블
         var tr; 
         var i=0;
         var td;
         var text;
         $(data).each(function(){
			tr = document.createElement('tr'); 
            
            if(this.type=="total"){
			    //1) tr 첫번째 줄 : 전체 정보 띄우기 - 전체 소요 시간, 전체 이동 거리
               distance = this.distance;
               duration = this.duration;
               tr.classList.add("trasitDetailTitle");
                //전체 소요 시간
				text = document.createTextNode(this.duration);
                td= document.createElement('td');
                td.setAttribute("id","wholeDuration");
                td.setAttribute('colSpan', 2);
                td.appendChild(text);
                tr.appendChild(td);
				//전체 이동 거리
                text = document.createTextNode(this.distance);
                td= document.createElement('td');
                td.setAttribute("id","wholeDistance");
                td.setAttribute('colSpan', 2);
                td.appendChild(text);
                tr.appendChild(td);
                
                results.appendChild(tr);
                 //2) tr 두번째 줄 : 출발지
              	tr = document.createElement('tr');
              	tr.classList.add("trasitDetailPlace");
				//출발지 표시 아이콘 삽입
              	td= document.createElement('td');
                img = document.createElement('img');
                img.setAttribute('src','../img/departure.png');
                td.appendChild(img);
                tr.appendChild(td);
				//출발지
                text = document.createTextNode(start);
                td= document.createElement('td');
                td.setAttribute('colSpan', 3);
                td.appendChild(text);
                tr.appendChild(td);
                results.appendChild(tr);
            }else if(this.type=="walk_step"){ //3) tr 세번째 줄 이상 : 길찾기 정보의 각 step - walk, bus, subway, train
                tr.style.backgroundColor = (i % 2 == 0 ? 'rgba( 230, 230, 230, 0.9 )' : 'rgba( 200, 200, 200, 0.9)');
                //이용 대중교통 아이콘 삽입 (걷기)
				td= document.createElement('td');
                img = document.createElement('img');
                img.setAttribute('src','../img/walk.png');
                tr.classList.add("trasitDetailContent");
                td.appendChild(img);
                tr.appendChild(td);
                //소요시간(거리)
                text = document.createTextNode(this.duration+"("+this.distance+")");
                td= document.createElement('td');
                td.setAttribute('colSpan', 2);
                td.appendChild(text);
                tr.appendChild(td);
                results.appendChild(tr);
            }else if(this.type=="train_step"){
               tr.style.backgroundColor = (i % 2 == 0 ? 'rgba( 230, 230, 230, 0.9 )' : 'rgba( 200, 200, 200, 0.9)');
                //이용 대중교통 아이콘 삽입 (기차)
			    td= document.createElement('td');
                img = document.createElement('img');
                img.setAttribute('src','../img/train.png');
                td.appendChild(img);
                tr.appendChild(td);
                tr.classList.add("trasitDetailContent");
				//소요시간(거리)
                text = document.createTextNode(this.duration+"("+this.distance+")");
                td= document.createElement('td');
                td.appendChild(text);
                tr.appendChild(td);
				//기차 이름
                text = document.createTextNode(this.vehicleName);
                td= document.createElement('td');
                td.appendChild(text);
                tr.appendChild(td);
                results.appendChild(tr);
//                 tr.onclick=function(){    //토글
//                 if(detailTr.hasAttribute('class')){
//                    //있으면
//                    detailTr.removeAttribute('class');
//                    results.removeChild(detailTr);
//                 }else{
//                    //없으면
//                    detailTr.classList.add('trainDetail');
//                    results.appendChild(detailTr);
//                 }
//              };
             
			   //tr 다음 행 : 출발 정류장, 도착 정류장
               var detailTr = document.createElement('tr');
               detailTr.classList.add("detailTr");
//                 text = document.createTextNode(this.information);
//                 td= document.createElement('td');
//                 td.appendChild(text);
//                 detailTr.appendChild(td);
				/*출발 정류장*/
				//이미지
				td= document.createElement('td');
				td.style.padding="10px";
                img = document.createElement('img');
                img.setAttribute('src','../img/stop.png');
                img.classList.add("stopImg");
                td.appendChild(img);
                detailTr.appendChild(td);
                
                //정보
                text = document.createTextNode(this.departureStop+" 승차");
                td.setAttribute('colSpan', 3);
                td= document.createElement('td');
                td.style.padding="10px";
                td.appendChild(text);
                detailTr.appendChild(td);
                results.appendChild(detailTr);
				
                /*도착 정류장*/
                detailTr = document.createElement('tr');
				//이미지
				td= document.createElement('td');
				td.style.padding="10px";
                img = document.createElement('img');
                img.setAttribute('src','../img/stop.png');
                img.classList.add("stopImg");
                td.appendChild(img);
                detailTr.appendChild(td);
				
                //정보
                detailTr.classList.add("detailTr");
                text = document.createTextNode(this.arrivalStop+" 하차");
                td.setAttribute('colSpan', 3);
                td= document.createElement('td');
                td.style.padding="10px";
                td.appendChild(text);
                detailTr.appendChild(td);
//                 text = document.createTextNode(this.vehicle);
//                 td= document.createElement('td');
//                 td.appendChild(text);
//                 detailTr.appendChild(td);
//                 text = document.createTextNode(this.stopNum);
//                 td= document.createElement('td');
//                 td.appendChild(text);
//                 detailTr.appendChild(td);
                results.appendChild(detailTr);
            }else{
               tr.style.backgroundColor = (i % 2 == 0 ? 'rgba( 230, 230, 230, 0.9 )' : 'rgba( 200, 200, 200, 0.9)');
               tr.classList.add("busTr");
               //이용 대중교통 아이콘 삽입 (버스, 지하철)
			   td= document.createElement('td');
               img = document.createElement('img');
               if(this.vehicle=="Bus"){
                  img.setAttribute('src','../img/bus.png');	
               }else{
                  img.setAttribute('src','../img/subway.png');
               }
               td.appendChild(img);
               tr.appendChild(td);
               tr.classList.add("trasitDetailContent");
               //전체 시간(이동 거리)
			   text = document.createTextNode(this.duration+"("+this.distance+")");
               td= document.createElement('td');
               td.appendChild(text);
               tr.appendChild(td);
				//노선 번호
              if(this.vehicle=="Bus"){	
                 text = document.createTextNode(this.transit_route+"번");
               }else{
                  text = document.createTextNode(this.transit_route);
               }
                td= document.createElement('td');
                td.appendChild(text);
                tr.appendChild(td);
                results.appendChild(tr);

//          tr.onclick=function(){    //토글
//             if($("#"+this.transit_route).hasAttr('class')){
//                //있으면
//                $("#"+this.transit_route).removeAttr('class');
//               $("#"+this.transit_route).remove();
//             }else{
//                //없으면
//                  $("#"+this.transit_route).setAttr('class','test');
// //                results.append(detailTr);
// 				$(".busTr"+this.transit_route).after(str);
//             }
//          };

// 			$(".busTr").toggle(function(){
// 				alert("dd");
// 			},function(){
				
// 				alert("nn");
// 			});
// 			$(".busTr").click(function(){
// 				if($(".detailTr").css('display')=='none'){
// 					$(".detailTr").css('display','block');
// 				}else{
// 					$(".detailTr").css('display','none');
// 				}
// 			});
// 			tr.onclick=function(){
// 					if($(".detailTr").css('display')=='none'){
// 						$(".detailTr").css('display','block');
// 					}else{
// 						$(".detailTr").css('display','none');
// 					}
// 			};
         

            //tr 다음 행 : 출발 정류장, 도착 정류장
            var detailTr = document.createElement('tr');
            detailTr.classList.add("detailTr");
//             text = document.createTextNode(this.information);
//             td= document.createElement('td');
//             td.setAttribute('colspan','4');
//             td.appendChild(text);
//             detailTr.appendChild(td);
			/*출발 정류장*/
			//이미지
			td= document.createElement('td');
			td.style.padding="10px";
            img = document.createElement('img');
            img.setAttribute('src','../img/stop.png');
            img.classList.add("stopImg");
            td.appendChild(img);
            detailTr.appendChild(td);
			
            //정보
            text = document.createTextNode(this.departureStop+" 승차");
            td= document.createElement('td');
            td.style.padding="10px";
            td.setAttribute('colspan','3');
            td.appendChild(text);
            detailTr.appendChild(td);
            results.appendChild(detailTr);
			
            //도착 정류장
			detailTr = document.createElement('tr');
			//이미지
			td= document.createElement('td');
			td.style.padding="10px";
            img = document.createElement('img');
            img.setAttribute('src','../img/stop.png');
            img.classList.add("stopImg");
            td.appendChild(img);
            detailTr.appendChild(td);
                
            //정보
            detailTr.classList.add("detailTr");
            text = document.createTextNode(this.arrivalStop+" 하차");
            td= document.createElement('td');
            td.style.padding="10px";
            td.setAttribute('colspan','3');
            td.appendChild(text);
            detailTr.appendChild(td);
//             text = document.createTextNode(this.vehicle);
//             td= document.createElement('td');
//             td.appendChild(text);
//             detailTr.appendChild(td);
//             text = document.createTextNode(this.vehicleName);
//             td= document.createElement('td');
//             td.appendChild(text);
//             detailTr.appendChild(td);
//             text = document.createTextNode(this.stopNum);
//             td= document.createElement('td');
//             td.appendChild(text);
//             detailTrdetailTr.appendChild(td);
            results.appendChild(detailTr);
            }
            i++; 
         });
		  //4)tr 마지막 행 : 도착지
          tr = document.createElement('tr');
          tr.classList.add("trasitDetailPlace");
		  //도착지 표시 아이콘
          td= document.createElement('td');
          img = document.createElement('img');
          img.setAttribute('src','../img/destination.png');
          td.appendChild(img);
          tr.appendChild(td);
		  //도착지
          text = document.createTextNode(fin);
          td= document.createElement('td');
          td.setAttribute('colSpan', 3);
          td.appendChild(text);
          tr.appendChild(td);
          results.appendChild(tr);
       },error:function(request,status,error){
    	   swal({title: 'ERROR!', text: '실패',type: 'error',confirmButtonText: 'OK',});
       }
 });	//길찾기 정보 가져오기 기능 종료
 
//2.2. 지도에 길찾기 결과를 그린다
 var request = {
     origin:start,
     destination:fin,
     travelMode: eval("google.maps.DirectionsTravelMode."+'TRANSIT')
 };
 directionsService.route(request, function(response, status) {
   //alert(status);  // 확인용 Alert..미사용시 삭제
   if (status == google.maps.DirectionsStatus.OK) {
       directionsDisplay.setDirections(response);
   }
 });
}	//길찾기 관련 기능 종료


//3. Google Places API
//3.1. 타일로드
function tilesLoaded() {
	google.maps.event.clearListeners(map, 'tilesloaded');
	google.maps.event.addListener(map, 'zoom_changed', search);
	google.maps.event.addListener(map, 'dragend', search);
	search();
}
//3.2. 장소 선택
function showSelectedPlace() {
	clearResults();
	clearMarkers();
	var place = autocomplete.getPlace();
// 	alert(place.geometry.location);
	map.panTo(place.geometry.location);
	markers[0] = new google.maps.Marker({
		position: place.geometry.location,
		map: map
	});
	iw = new google.maps.InfoWindow({
		content: getIWContent(place)
	});
	iw.open(map, markers[0]);
}
//3.3. 검색
function search() {
	var target = document.getElementById("searchType");
	var type=target.options[target.selectedIndex].value;

	autocomplete.setBounds(map.getBounds());
	var search = {
		bounds: map.getBounds()
	};
	if (type != 'establishment') {
		search.types = [type];
	}
	places.search(search, function (results, status) {
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			clearResults();
			clearMarkers();
			for (var i = 0; i < results.length; i++) {
				markers[i] = new google.maps.Marker({
					position: results[i].geometry.location,
					animation: google.maps.Animation.DROP
				});
				google.maps.event.addListener(markers[i], 'click', getDetails(results[i], i));
				setTimeout(dropMarker(i), i * 100);
				addResult(results[i], i);
			}
		}
	});
}
//3.4. 마커
//3.4.1. 마커 지우기
function clearMarkers() {
	for (var i = 0; i < markers.length; i++) {
		if (markers[i]) {
			markers[i].setMap(null);
			markers[i] == null;
		}
	}
}
//3.4.2. 마커 떨어뜨리기
function dropMarker(i) {
	return function () {
		markers[i].setMap(map);
	}
}
//3.5. 검색 결과 >> listing
//3.5.1. 검색 결과 목록 띄우기
function addResult(result, i) {
	var results = document.getElementById('results');
	var tr = document.createElement('tr');
	tr.style.backgroundColor = (i % 2 == 0 ? 'rgba( 240, 240, 240, 0.8 )' : 'rgba( 210, 210, 210, 0.8 )');
	tr.onclick = function () {
		google.maps.event.trigger(markers[i], 'click');
	};
	var iconTd = document.createElement('td');
	var nameTd = document.createElement('td');
	var icon = document.createElement('img');
	icon.src = result.icon.replace('http:', '');
	icon.setAttribute('class', 'placeIcon');
	var name = document.createTextNode(result.name);
	iconTd.appendChild(icon);
	nameTd.appendChild(name);
	tr.appendChild(iconTd);
	tr.appendChild(nameTd);
	results.appendChild(tr);
}
//3.5.2. 검색 결과 초기화 (없애기)
function clearResults() {
	var results = document.getElementById('results');
	while (results.childNodes[0]) {
		results.removeChild(results.childNodes[0]);
	}
}

//3.6. 상세 정보
//3.6.1. 상세 정보 얻기
function getDetails(result, i) {
	return function () {
		places.getDetails({
			reference: result.reference
		}, showInfoWindow(i));
	}
}
//3.6.2. 상세 정보 모달 띄우기
function showInfoWindow(i) {
	return function (place, status) {
		if (iw) {
			iw.close();
			iw = null;
		}
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			iw = new google.maps.InfoWindow({
				content: getIWContent(place)
			});
			iw.open(map, markers[i]);
		}
	}
}
//3.6.3. 상세 정보 창에 띄울 정보 작성
function getIWContent(place) {
	var content = '<table style="border:0"><tr><td style="border:0;">';
	content += '<img class="placeIcon" src="' + place.icon + '"></td>';
	content += '<td style="border:0;padding:10px;"><b>'
				+'<a href="' + place.url + '" style="text-decoration:none">' + place.name + '&nbsp&nbsp</a>'
				+'<button onclick="showAddTour(\''+place.name+'\',\''+place.url+'\')" style="text-align:center;background-color:white;">일정 추가</button><br><hr>'
				+place.formatted_address+'<br>tel : '+place.formatted_phone_number+'</b>';
	content += '</td></tr></table>';
	return content;
}

//4. 화면 로드 시 구글 맵 초기화
google.maps.event.addDomListener(window, 'load', initialize);




/*********************************************************************************************************/
/**************************************************일정 편집*************************************************/
/*********************************************************************************************************/

//1. 일정 추가
//1.1. 일정 추가를 위한 모달창 띄우기 
//1.1.1. TOUR 일정 추가를 위한 모달창 #modTour 띄우기
function showAddTour(name,url){
	//모달 창에 여행장소와 장소링크 자동 입력 시켜주기
	$("#tourSpot").val(name);
	$("#spotLink").val(url);
	//추가 버튼 띄우고, 수정 버튼 지우기 및 모달창 띄우기
	$("#modifyTourBtn").css("display","none");
	$("#addTourBtn").show("fast");
	$("#modTour").show("slow");
}
//1.1.2. TRANSPORT 일정 추가를 위한 모달창 #modTransport 
//: 1) 지도에서 transport 일정 추가 	2) TOUR 일정 추가 시 바로 전의 일정이 TOUR일 때 자동으로 모달 창이 뜬다.

//1.2. 일정 추가
//1.2.1. TOUR 일정 추가 : 1)일정 추가  2)div 추가  3)모달 창 닫기
function addTour(){
	//일정 목록에서의 마지막 일정의 종류 : TOUR 인지 TRANSPORT 인지
	var lastElement;
	
	if(document.getElementById("scheduleBox").lastElementChild!=null){
			lastElement = document.getElementById("scheduleBox").lastElementChild.getAttribute("class");
	}
	if(lastElement=='tour'){
		//마지막 요소가 TOUR이면 TRANSPORT 일정 추가를 위한 모달창 #modTransport를 띄운다
		$("#choiceTransport").show("fast");
		$("#updateChoiceTransport").hide("fast");
		$("#modTransport").show("slow");
	}else{
		//TOUR 일정 추가를 위한 변수 준비
		var memberId = '${memberId}';	//사용자 아이디
		var tourName = $("#tourName").html();	//여행 이름
		var departureDate = new Date($("#departureDate").html());	//여행 출발일
		var endDate = new Date($("#endDate").html());	//여행 종료일
		var tourDate_show = $("#tourDate").html();	//여행 날짜
		var tourDate =new Date("2018/"+tourDate_show);
		var tourSpot = $("#tourSpot").val();	//여행 장소
		var spotLink = $("#spotLink").val();	//여행 장소 url
		var tourMemo = $("#tourMemo").val();	//여행 상세 메모 
		//1) TOUR 일정 추가
		//Ajax /addTour
		$.ajax({
			url:"addTour",
			type:"POST",
			data:{
				memberId : memberId,
				tourName : tourName,
				departureDate : departureDate,
				endDate : endDate,
				tourSpot : tourSpot,
				spotLink : spotLink,
				tourMemo : tourMemo,
				tourDate : tourDate
			},
			datatype : "json",
			success : function(result){
				
				if(result>0){
					 var itinerarySeq = result;
					//2) div 추가
					var box = document.getElementById('scheduleBox');
					var div = document.createElement('div');
					div.classList.add('tour');
					var table = document.createElement('table');
					table.classList.add('tourTable')
					var tourTr = document.createElement('tr');
					var tourTd = document.createElement('td');
					var spot_aTag = document.createElement('a');
					var spot = document.createTextNode(tourSpot);
					spot_aTag.appendChild(spot);
					spot_aTag.setAttribute("href",spotLink);
					spot_aTag.setAttribute("target","_blank");
					var memoTr = document.createElement('tr');
					var memoTd = document.createElement('td');
					var memo = document.createTextNode(tourMemo);
					tourTd.appendChild(spot_aTag);
					tourTr.appendChild(tourTd);
					table.appendChild(tourTr);
					memoTd.appendChild(memo);
					memoTr.appendChild(memoTd);
					table.appendChild(memoTr);
					var modifyBtn = document.createElement('button');
				 	modifyBtn.innerHTML = "<img src='../img/edit.png'>";
					modifyBtn.classList.add('scheduleBtn');
					modifyBtn.addEventListener("click",function(event){
						$("#itinerarySeq").val(itinerarySeq);
						$("#tourSpot").val(tourSpot);
						$("#spotLink").val(spotLink);
						$("#tourMemo").html(tourMemo);
						$("#modifyTourBtn").show("fast");
						$("#addTourBtn").css("display","none");
						$("#modTour").show("slow");
					},false);
				 	var deleteBtn = document.createElement('button');
				 	deleteBtn.innerHTML ="<img src='../img/delete.png'>";
				 	deleteBtn.classList.add('scheduleBtn');
				 	deleteBtn.addEventListener("click",function(event){
				 		$.ajax({
				 			url:"deleteTour",
				 			type:"POST",
				 			data:{
				 				itinerarySeq : itinerarySeq,
				 			},
				 			datatype : "json",
				 			success : function(result){
				 				if(result=="SUCCESS"){
				 					swal({
                        			  title: 'SUCCESS!',
                        			  text: '삭제 되었습니다.',
                        			  type: 'success',
                        			  confirmButtonText: 'OK',
                        		}).then(function(){location.reload(true)});

				 				}
				 			},
				 			error : function(request,status,error){
				 				swal({
                    			  title: 'ERROR!',
                    			  text: '실패',
                    			  type: 'error',
                    			  confirmButtonText: 'OK',
                    		});
				 			}
				 		});
				 	});
				 	div.appendChild(deleteBtn);
				 	div.appendChild(modifyBtn);
					div.appendChild(table);
					box.appendChild(div);
				}
				swal({title: 'SUCCESS!',text: '추가 되었습니다.',type: 'success',confirmButtonText: 'OK',}).then(function(){location.reload(true)});
				
			},
			error : function(request,status,error){
				swal({
    			  title: 'ERROR!',
    			  text: '실패.',
    			  type: 'error',
    			  confirmButtonText: 'OK',
    		});
			}
		});
	
	//3) 모달창 닫기
	$("#modTour").hide("slow");
	$("#tourMemo").val("");
	}
}
//1.2.2. TRANSPORT 일정 추가 : 1)일정 추가  2)div 추가  3)모달 창 닫기
//: TRANSPORT 일정 추가 두번째 방법 : TOUR 일정 다음에 연속으로 다른 TOUR 일정을 추가할 때 자동으로 TRANSPORT 일정을 그 사이에 추가할 수 있다.
function addTransport(){
	var memberId='${memberId}';
	var tourName=$("#tourName").html();
	var departureDate = new Date($("#departureDate").html());
	var endDate=new Date($("#endDate").html());
	var tourDate_show = $("#tourDate").html();	//여행 날짜
	var tourDate =new Date("2018/"+tourDate_show);
	var transportation = $("input[type=radio][name=transportation]:checked").val();
	var departure= document.getElementById("scheduleBox").lastElementChild.getElementsByTagName("a")[0].text;
	var destination= $("#tourSpot").val();
	if(transportation=="transit"){
		//TRANSPORTATION = 'transit' 대중교통 이용 시, 자동으로 길찾기 결과를 알려주고 TRANSPORT 일정을 추가한다.
		showDirections(departure,destination);

		setTimeout(function() {  
			$("#modTour").hide();
			$("#addTransportBtn").trigger("click");
		}, 1500);
		
		setTimeout(function() {  
			addTour();
		}, 1800);
	}else{
		//TRANSPORTATION = 'walk' or 'drive' 차 또는 도보 이동
		$.ajax({
			url:"addTransport",
			type:"POST",
			data:{
				memberId:memberId,
		      	tourName:tourName,
		      	departureDate:departureDate,
		      	endDate:endDate,
		      	tourDate:tourDate,
		      	transportation:transportation,
		      	departure:departure,
		      	destination:destination
			},
			datatype:"json",
			success:function(data){
	      		//div 추가
	      		var box = document.getElementById('scheduleBox');
				var div = document.createElement('div');
				div.classList.add('transport');
				var table = document.createElement('table');
				table.classList.add('transportTable')
				var durationTr = document.createElement('tr');
				var durationTd = document.createElement('td');
				var text
				if(transportation=='walk'){
					text = document.createTextNode("도보로 이동");	
				}else{
					text = document.createTextNode("차로 이동");
				}
				
				durationTd.appendChild(text);
				durationTr.appendChild(durationTd);
				table.appendChild(durationTr);
				div.appendChild(table);
				box.appendChild(div);
				
			},error:function(request,status,error){
				swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
		    }
		});
	}
	
	$("#modTransport").hide("slow");
}



//2. 일정 수정
//2.1. TOUR 일정 수정
//2.1.1. TOUR 일정 수정 모달 창 띄우기
function showModifyTour(itinerarySeq,tourSpot,spotLink,tourMemo){
	$("#itinerarySeq").val(itinerarySeq);
	$("#tourSpot").val(tourSpot);
	$("#spotLink").val(spotLink);
	$("#tourMemo").html(tourMemo);
	$("#modifyTourBtn").show("fast");
	$("#addTourBtn").css("display","none");
	$("#modTour").show("slow");
}
//2.1.2. TOUR 일정 수정   1)일정 수정  2)div 수정  3)모달 창 닫기
function modifyTour(){
	//TOUR 일정 수정을 위한 변수 준비
	var memberId = '${memberId}';	//사용자 아이디
	var itinerarySeq = $("#itinerarySeq").val();	//일정 번호
	var tourSpot = $("#tourSpot").val();	//여행 장소
	var spotLink = $("#spotLink").val();	//여행 장소 URL
	var tourMemo = $("#tourMemo").val();	//여행 상세 메모
	//1) 일정 수정
	$.ajax({
		url:"modifyTour",
		type:"POST",
		data:{
			memberId : memberId,
			itinerarySeq : itinerarySeq,
			tourSpot : tourSpot,
			spotLink : spotLink,
			tourMemo : tourMemo,
		},
		datatype : "json",
		success : function(result){
			if(result=="SUCCESS"){
				swal({
	      			  title: 'SUCCESS!',
	      			  text: '수정 되었습니다',
	      			  type: 'success',
	      			  confirmButtonText: 'OK',
	      		}).then(function(){location.reload(true)});	
			}
		},
		error : function(request,status,error){
			swal({
  			  title: 'ERROR!',
  			  text: '실패',
  			  type: 'error',
  			  confirmButtonText: 'OK',
  		});
		}
	});
	//3. 모달창 닫기
	$("#modTour").hide("slow");
}

//3. 일정 삭제
//3.1. TOUR 일정 삭제
function deleteTour(itinerarySeq){
	
	$.ajax({
		url:"deleteTour",
		type:"POST",
		data:{
			itinerarySeq : itinerarySeq,
		},
		datatype : "json",
		success : function(result){
			if(result=="SUCCESS"){
				swal({
	      			  title: 'SUCCESS!',
	      			  text: '삭제 되었습니다',
	      			  type: 'success',
	      			  confirmButtonText: 'OK',
	      		}).then(function(){location.reload(true)});
			}
		},
		error : function(request,status,error){
			swal({
  			  title: 'ERROR!',
    			  text: '실패',
    			  type: 'error',
    			  confirmButtonText: 'OK',
    		});
		}
	});
}
//3.2. TRANSPORT 일정 삭제
function deleteTransport(itinerarySeq){

	if(document.getElementById("scheduleBox").lastElementChild.getAttribute("id")!=itinerarySeq){
		//현재 TRANSPORT 일정이 일정목록의 마지막 요소가 아닐 때 일정을 아예 삭제하지 않고 내용만 삭제한다
		$.ajax({
			url:"deleteTransport",
			type:"POST",
			data:{
				itinerarySeq : itinerarySeq
			},
			datatype : "json",
	 		success : function(result){
	 		if(result=="SUCCESS"){
	 			swal({
	      			  title: 'SUCCESS!',
	      			  text: '삭제 되었습니다',
	      			  type: 'success',
	      			  confirmButtonText: 'OK',
	      		}).then(function(){location.reload(true)});
	 			}
	 		},
	 		error : function(request,status,error){
	 			swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
	 		}
		});
	}else{
		//현재 TRANSPORT 일정이 일정목록의 마지막 요소일 때 일정을 아예 삭제
		$.ajax({
			url:"dropTransport",
			type:"POST",
			data:{
				itinerarySeq : itinerarySeq
			},
			datatype : "json",
	 		success : function(result){
	 		if(result=="SUCCESS"){
	 			swal({
	      			  title: 'SUCCESS!',
	      			  text: '삭제 되었습니다',
	      			  type: 'success',
	      			  confirmButtonText: 'OK',
	      		}).then(function(){location.reload(true)});
	 			}
	 		},
	 		error : function(request,status,error){
	 			swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
	 		}
		});
	}
}

//4. 모달창 닫기
//1.5.1. TOUR 일정 추가 및 수정 창 modTour 닫기
function closeTour(){
	$("#modTour").hide("slow");
}
function closeTransport(){
	$("#modTransport").hide("slow");
}


/*********************************************************************************************************/
/***********************************************이전 및 다음 버튼**********************************************/
/*********************************************************************************************************/

//1. 이전 버튼 : 전 날의 일정 목록을 출력
function previous(){
	var departureDate = new Date($("#departureDate").html());	//여행 출발일
	var tourDate_show = $("#tourDate").html();	//여행 날짜
	var tourDate =new Date("2018/"+tourDate_show);
	
	var tourDate_str = "2018/"+tourDate_show;
	
	
	if(departureDate.getTime()===tourDate.getTime()){
		swal({
			  title: 'ERROR!',
			  text: '첫 날입니다',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
	}else{
		tourDate.setDate(tourDate.getDate()-1);
		var tourDate_year = tourDate.getYear()+1900;
		var tourName = $("#tourName").html();
		$.ajax({
			url:"previous",
			type:"GET",
			data : {
				tourDate : tourDate,
				tourName : tourName
			},
			dataType:"json",
			success:function(data){
				var tourDate_month = tourDate.getMonth()+1;
				var tourDate_date = tourDate.getDate();
				var tourDate_str = tourDate_month+'/'+tourDate_date;
				$('.transport').remove();
				$('.tour').remove();
				$("#tourDate").html(tourDate_str);
				$(data).each(function(){
					//일정 데이터 끌고 오기
					var itinerarySeq = this.itinerarySeq;
					var tourSpot = this.tourSpot;
					var spotLink = this.spotLink;
					var tourMemo = this.tourMemo;
					if(this.tourMemo==null){tourMemo = "";}else{tourMemo = this.tourMemo;}
					var itineraryType=this.itineraryType;
					var departure = this.departure;
					var destination = this.destination; 
					
					if(itineraryType=="TOUR"){
						//div 채워넣기
						var box = document.getElementById('scheduleBox');
					 	var div = document.createElement('div');
					 	div.classList.add('tour');
					 	var table = document.createElement('table');
					 	table.classList.add('tourTable')
					 	var tourTr = document.createElement('tr');
					 	var tourTd = document.createElement('td');
					 	var spot_aTag = document.createElement('a');
					 	var spot = document.createTextNode(tourSpot);
					 	spot_aTag.appendChild(spot);
					 	spot_aTag.setAttribute("href",spotLink);
					 	spot_aTag.setAttribute("target","_blank");
					 	spot_aTag.setAttribute("value",itinerarySeq);
					 	var memoTr = document.createElement('tr');
					 	var memoTd = document.createElement('td');
					 	var memo = document.createTextNode(tourMemo);
					 	tourTd.appendChild(spot_aTag);
						tourTr.appendChild(tourTd);
						table.appendChild(tourTr);
					 	memoTd.appendChild(memo);
					 	memoTr.appendChild(memoTd);
					 	table.appendChild(memoTr);
					 	var modifyBtn = document.createElement('button');
					 	modifyBtn.innerHTML = "<img src='../img/edit.png'>";
						modifyBtn.classList.add('scheduleBtn');
						modifyBtn.addEventListener("click",function(event){
							$("#itinerarySeq").val(itinerarySeq);
							$("#tourSpot").val(tourSpot);
							$("#spotLink").val(spotLink);
							$("#tourMemo").html(tourMemo);
							$("#modifyTourBtn").show("fast");
							$("#addTourBtn").css("display","none");
							$("#modTour").show("slow");
						},false);
					 	var deleteBtn = document.createElement('button');
					 	deleteBtn.innerHTML ="<img src='../img/delete.png'>";
					 	deleteBtn.classList.add('scheduleBtn');
					 	deleteBtn.addEventListener("click",function(event){
					 		$.ajax({
					 			url:"deleteTour",
					 			type:"POST",
					 			data:{
					 				itinerarySeq : itinerarySeq,
					 			},
					 			datatype : "json",
					 			success : function(result){
					 				if(result=="SUCCESS"){
					 					swal({
					 		      			  title: 'SUCCESS!',
					 		      			  text: '삭제 되었습니다',
					 		      			  type: 'success',
					 		      			  confirmButtonText: 'OK',
					 		      		}).then(function(){location.reload(true)});
					 				}
					 			},
					 			error : function(request,status,error){
					 				swal({
						      			  title: 'ERROR!',
						      			  text: '실패',
						      			  type: 'error',
						      			  confirmButtonText: 'OK',
						      		});
					 			}
					 		});
					 	});
					 	div.appendChild(deleteBtn);
					 	div.appendChild(modifyBtn);
					 	div.appendChild(table);
					 	box.appendChild(div);
					 }else if(itineraryType=="TRANSPORT"){
						//div 채워넣기
							var box = document.getElementById('scheduleBox');
							var div = document.createElement('div');
							div.classList.add('transport');
							var table = document.createElement('table');
							table.classList.add('transportTable');
						 	var deleteBtn = document.createElement('button');
						 	deleteBtn.innerHTML ="<img src='../img/cancel.png' width='7px'>";
						 	deleteBtn.classList.add('scheduleBtn');
						 	deleteBtn.addEventListener("click",function(event){
						 		$.ajax({
						 			url:"deleteTransport",
						 			type:"POST",
						 			data:{
						 				itinerarySeq : itinerarySeq,
						 			},
						 			datatype : "json",
						 			success : function(result){
						 				if(result=="SUCCESS"){
						 					swal({
						 		      			  title: 'SUCCESS!',
						 		      			  text: '삭제 되었습니다',
						 		      			  type: 'success',
						 		      			  confirmButtonText: 'OK',
						 		      		}).then(function(){location.reload(true)});
						 				}
						 			},
						 			error : function(request,status,error){
						 				swal({
							      			  title: 'ERROR!',
							      			  text: '실패',
							      			  type: 'error',
							      			  confirmButtonText: 'OK',
							      		});
						 			}
						 		});
						 	});
						 	div.appendChild(deleteBtn);
							var transportTr = document.createElement('tr');
							var transportTd = document.createElement('td');
							var btn = document.createElement('button');
							btn.setAttribute("class","transitDetailBtn");
							if(this.transportation=="TRANSIT"){
								var text = document.createTextNode(this.distance+","+this.duration);
							}else if(this.transportation="walk"){
								var text = document.createTextNode("도보로 이동");
							}else{
								var text = document.createTextNode("차로 이동");
							}
							btn.addEventListener("click",function(event){
								//dd1
								showDirections(departure,destination);
							});
							btn.appendChild(text);
							transportTd.appendChild(btn);
							transportTr.appendChild(transportTd);
							table.appendChild(transportTr);
							div.appendChild(table);

							 	box.appendChild(div); 
					 }
				});
			},
			error:function(request,status,error){
				swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
			}
		});
	}
}
//2. 다음 버튼 : 다음 날의 일정 목록을 출력
function next(){
	var endDate = new Date($("#endDate").html());	//여행 출발일
	var tourDate_show = $("#tourDate").html();	//여행 날짜
	var tourDate =new Date("2018/"+tourDate_show);

	if(endDate.getTime()===tourDate.getTime()){
		swal({
			  title: 'ERROR!',
			  text: '마지막 날입니다',
			  type: 'error',
			  confirmButtonText: 'OK',
		});
	}else{
		tourDate.setDate(tourDate.getDate()+1);
		var tourName = $("#tourName").html();
		$.ajax({
			url:"next",
			type:"GET",
			data : {
				tourDate : tourDate,
				tourName : tourName
			},
			dataType:"json",
			success:function(data){
				var tourDate_month = tourDate.getMonth()+1;
				var tourDate_date = tourDate.getDate();
				var tourDate_str = tourDate_month+'/'+tourDate_date;
				$('.tour').remove();
				$('.transport').remove();
				$("#tourDate").html(tourDate_str);
				$(data).each(function(){
					//일정 데이터 끌고 오기
					var itinerarySeq = this.itinerarySeq;
					var tourSpot = this.tourSpot;
					var spotLink = this.spotLink;
					var tourMemo;
					if(this.tourMemo==null){tourMemo = "";}else{tourMemo = this.tourMemo;}
					var itineraryType=this.itineraryType;
					var departure = this.departure;
					var destination = this.destination;
				
					
					if(itineraryType=="TOUR"){
						//div 채워넣기
						var box = document.getElementById('scheduleBox');
					 	var div = document.createElement('div');
					 	div.classList.add('tour');
					 	var table = document.createElement('table');
					 	table.classList.add('tourTable')
					 	var tourTr = document.createElement('tr');
					 	var tourTd = document.createElement('td');
					 	var spot_aTag = document.createElement('a');
					 	var spot = document.createTextNode(tourSpot);
					 	spot_aTag.appendChild(spot);
					 	spot_aTag.setAttribute("href",spotLink);
					 	spot_aTag.setAttribute("target","_blank");
					 	spot_aTag.setAttribute("value",itinerarySeq);
					 	var memoTr = document.createElement('tr');
					 	var memoTd = document.createElement('td');
					 	var memo = document.createTextNode(tourMemo);
					 	tourTd.appendChild(spot_aTag);
						tourTr.appendChild(tourTd);
						table.appendChild(tourTr);
					 	memoTd.appendChild(memo);
					 	memoTr.appendChild(memoTd);
					 	table.appendChild(memoTr);
					 	var modifyBtn = document.createElement('button');
					 	modifyBtn.innerHTML = "<img src='../img/edit.png'>";
						modifyBtn.classList.add('scheduleBtn');
						modifyBtn.addEventListener("click",function(event){
							$("#itinerarySeq").val(itinerarySeq);
							$("#tourSpot").val(tourSpot);
							$("#spotLink").val(spotLink);
							$("#tourMemo").html(tourMemo);
							$("#modifyTourBtn").show("fast");
							$("#addTourBtn").css("display","none");
							$("#modTour").show("slow");
						},false);
					 	var deleteBtn = document.createElement('button');
					 	deleteBtn.innerHTML ="<img src='../img/delete.png'>";
					 	deleteBtn.classList.add('scheduleBtn');
					 	deleteBtn.addEventListener("click",function(event){
					 		$.ajax({
					 			url:"deleteTour",
					 			type:"POST",
					 			data:{
					 				itinerarySeq : itinerarySeq,
					 			},
					 			datatype : "json",
					 			success : function(result){
					 				if(result=="SUCCESS"){
					 					swal({
					 		      			  title: 'SUCCESS!',
					 		      			  text: '삭제 되었습니다',
					 		      			  type: 'success',
					 		      			  confirmButtonText: 'OK',
					 		      		}).then(function(){location.reload(true)});
					 				}
					 			},
					 			error : function(request,status,error){
					 				swal({
						      			  title: 'ERROR!',
						      			  text: '실패',
						      			  type: 'error',
						      			  confirmButtonText: 'OK',
						      		});
					 			}
					 		});
					 	});
					 	div.appendChild(deleteBtn);
					 	div.appendChild(modifyBtn);
					 	div.appendChild(table);
					 	box.appendChild(div);
					 }else if(itineraryType=="TRANSPORT"){
						//div 채워넣기
						var box = document.getElementById('scheduleBox');
						var div = document.createElement('div');
						div.classList.add('transport');
						var table = document.createElement('table');
						table.classList.add('transportTable');
					 	var deleteBtn = document.createElement('button');
					 	deleteBtn.innerHTML ="<img src='../img/cancel.png' width='7px'>";
					 	deleteBtn.classList.add('scheduleBtn');
					 	deleteBtn.addEventListener("click",function(event){
					 		$.ajax({
					 			url:"deleteTransport",
					 			type:"POST",
					 			data:{
					 				itinerarySeq : itinerarySeq,
					 			},
					 			datatype : "json",
					 			success : function(result){
					 				if(result=="SUCCESS"){
					 					swal({
					 		      			  title: 'SUCCESS!',
					 		      			  text: '삭제 되었습니다',
					 		      			  type: 'success',
					 		      			  confirmButtonText: 'OK',
					 		      		}).then(function(){location.reload(true)});
					 				}
					 			},
					 			error : function(request,status,error){
					 				swal({
						      			  title: 'ERROR!',
						      			  text: '실패',
						      			  type: 'error',
						      			  confirmButtonText: 'OK',
						      		});
					 			}
					 		});
					 	});
					 	div.appendChild(deleteBtn);
						var transportTr = document.createElement('tr');
						var transportTd = document.createElement('td');
						var btn = document.createElement('button');
						btn.setAttribute("class","transitDetailBtn");
						if(this.transportation=="TRANSIT"){
							var text = document.createTextNode(this.distance+","+this.duration);
						}else if(this.transportation="walk"){
							var text = document.createTextNode("도보로 이동");
						}else{
							var text = document.createTextNode("차로 이동");
						}
						btn.addEventListener("click",function(event){
							showDirections(departure,destination);
							//dd2
							$("#addTransportBtn").hide("slow");
						});
						btn.appendChild(text);
						transportTd.appendChild(btn);
						transportTr.appendChild(transportTd);
						table.appendChild(transportTr);
						div.appendChild(table);

						box.appendChild(div); 
					 }
				});
			},
			error:function(request,status,error){
				swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
			}
		});
	}
}

/*********************************************************************************************************/
/***************************************************기타**************************************************/
/*********************************************************************************************************/

//1. 지도 이용 탭
//1.1. PLACE 탭 
function showPlace(){
	$("#naviSection").css("display","none");
	$("#placeSection").css("display","block");
	$("#placeBtn").css("background","#FFFF00");
	$("#placeBtn").css("border","none");
	$("#naviBtn").css("background","none");
}
//1.2. Directions 탭
function showNavi(){
	$("#placeSection").css("display","none");
	$("#naviSection").css("display","block");
	$("#naviBtn").css("background","#FFFF00");
	$("#naviBtn").css("border","none");
	$("#placeBtn").css("background","none");
}

//2. 일정 목록 중 Transport 일정을 클릭하면, 그에 관련된 길찾기 정보가 화면에 띄워진다.
function showDirections(departure,destination){
	
	showNavi();
	
	
	$("#start").val(departure);
	$("#fin").val(destination);
	$("#directionsBtn").trigger("click");
	
	
	setTimeout(function() {  
		$("#addTransportBtn").hide();
	}, 1000);
	

}

var start_updateTransport;
var fin_updateTransport;
var itinerarySeq_updateTransport;

function showUpdateTransport(itinerarySeq){

	itinerarySeq_updateTransport = itinerarySeq;
	start_updateTransport = $("#"+itinerarySeq).prev().children().next().next().children().children().children().children().html();
	fin_updateTransport = $("#"+itinerarySeq).next().children().next().next().children().children().children().children().html();
	
	$("#choiceTransport").hide("fast");
	$("#updateChoiceTransport").show("fast");
	$("#modTransport").show("slow");
	
}

function updateTransport(){
  
	var departure = start_updateTransport;
	var destination = fin_updateTransport;
	var itinerarySeq= itinerarySeq_updateTransport;
	
	var transportation = $("input[type=radio][name=transportation]:checked").val();
	
	if(transportation=='transit'){
		//대중교통
		showDirections(departure,destination);
		//updateAjax : TRANSIT
		var duration;
		var distance;
		
		setTimeout(function() {  
			duration = $("#wholeDuration").text();
			distance = $("#wholeDistance").text();
			
			$.ajax({
				url:"modifyTransport",
				type:"POST",
				data:{
					itinerarySeq:itinerarySeq,
					transportation:transportation,
					departure:departure,
					destination:destination,
			      	distance:distance,
			      	duration:duration
				},
				datatype:"json",
				success:function(data){
					swal({
		      			  title: 'SUCCESS!',
		      			  text: '수정 되었습니다',
		      			  type: 'success',
		      			  confirmButtonText: 'OK',
		      		}).then(function(){location.reload(true)});
				},error:function(request,status,error){
					swal({
		      			  title: 'ERROR!',
		      			  text: '실패',
		      			  type: 'error',
		      			  confirmButtonText: 'OK',
		      		});
			    }
			});
			
		}, 1500);
//		alert(distance);
//		alert(duration);

		
	}else{ 	//UPDATE WALK,DRIVE
		$.ajax({
			url:"modifyTransport",
			type:"POST",
			data:{
				itinerarySeq:itinerarySeq,
				transportation:transportation,
				departure:departure,
				destination:destination
			},
			datatype:"json",
			success:function(data){
				swal({
	      			  title: 'SUCCESS!',
	      			  text: '수정 되었습니다',
	      			  type: 'success',
	      			  confirmButtonText: 'OK',
	      		}).then(function(){location.reload(true)});
			},error:function(request,status,error){
				swal({
	      			  title: 'ERROR!',
	      			  text: '실패',
	      			  type: 'error',
	      			  confirmButtonText: 'OK',
	      		});
		    }
		});
	}
	
	
	
	$("#modTransport").hide("slow");
}


</script>

<title>TRIPPY TRIPPER &mdash; Schedular</title>
</head>
<body>
	<div class="gtco-loader"></div>
	<div id="page">
		<!-- <div class="page-inner"> -->
		<!--------------------------------------------------- 네비게이션 바  --------------------------------------------------->
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
						<li class="has-dropdown"><a href="start">ITINERARY</a>
							<ul class="dropdown">
								<li><a href="../tMember/myItinerary">MYTRIP</a></li>
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
						<!-- 추후 요청 변경 -->
						<li><a href="../tMember/myInfo">MYPAGE</a></li>
						<li>
                  			<a href="../tMember/logout">LOGOUT</a>
                  	</li>
					</ul>
				</div>
			</div>

		</div>
		</nav>
		<header id="gtco-header" class="gtco-cover gtco-cover-sm"
			role="banner" style="background-image: url(img/bg1.jpg)">
		<div class="overlay"></div>
		<div class="gtco-container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 text-center">
					<div class="row row-mt-15em">
						<div class="col-md-12 mt-text animate-box"
							data-animate-effect="fadeInUp">
							<h1>Itinerary</h1>
						</div>

					</div>
				</div>
			</div>
		</div>
		</header>
	</div>
	
	<div class="row">
		<div class="col-md-8 col-md-offset-2 text-center gtco-heading">
			<br>
			<br>
			<h2>Plan Your Trip</h2>
		</div>
	</div>

	<div class="container">
		<!------------------------------------- Container 1 : 여행 일정 목록   ------------------------------------->
		<div class="container1" align="center">
			<!----------------------------------- 날짜 띄우기 ----------------------------------->
			<div class="scheduleDate" style="align: center;">
				<span><input type="button" class="goDate"
					onclick="previous()" style="float: left" value="<"></span>
				<c:forEach var="itinerary" items="${itineraryList }" begin="0"
					end="0">
					<div id="tourDate"><fmt:formatDate
							value="${itinerary.departureDate }" pattern="MM/dd" /></div>
				</c:forEach>
				<span><input type="button" class="goDate" onclick="next()"
					style="float: right" value=">"></span>
			</div>
			<!----------------------------------- 일정 목록 ----------------------------------->
			<div id="scheduleBox">
				<c:forEach var="itinerary" items="${itineraryList }">
					<c:if test="${itinerary.itineraryType =='TOUR' }">
						<div class="tour">
							<button class="scheduleBtn"
								onclick="deleteTour(${itinerary.itinerarySeq})">
								<img src="../img/delete.png">
							</button>
							<button class="scheduleBtn"
								onclick="showModifyTour(${itinerary.itinerarySeq},'${itinerary.tourSpot }','${itinerary.spotLink }','${itinerary.tourMemo }')">
								<img src="../img/edit.png">
							</button>
							<table class="tourTable">
								<tr>
									<td><a href="${itinerary.spotLink }" target="_blank">${itinerary.tourSpot }</a>
									</td>
								</tr>
								<tr>
									<td style="letter-spacing:1px;">${itinerary.tourMemo }</td>
								</tr>
							</table>
						</div>
					</c:if>
					<c:if test="${itinerary.itineraryType =='TRANSPORT' }">
						<div id=${itinerary.itinerarySeq } class="transport">
							<c:if test="${itinerary.transportation!=null}">
							<button class="scheduleBtn" onclick="deleteTransport(${itinerary.itinerarySeq})">
								<img src="../img/cancel.png" style="width:10px; height:10px;">
							</button>
							</c:if>
							<table class="transportTable">
								<tr>
									<td>
										<c:if test="${itinerary.transportation=='TRANSIT' }">
										<button onclick="showDirections('${itinerary.departure}','${itinerary.destination }')" class="transitDetailBtn">
											${itinerary.distance},
											${itinerary.duration }</button>
										</c:if>
										<c:if test="${itinerary.transportation=='walk' }">
										<button class="transitDetailBtn">
											도보로 이동</button>
										</c:if>
										<c:if test="${itinerary.transportation=='drive'}">
										<button class="transitDetailBtn">
											차로 이동</button>
										</c:if>
										<c:if test="${itinerary.transportation==null}">
										<button onclick="showUpdateTransport(${itinerary.itinerarySeq})" class="transitDetailBtn"> 
											...</button>
										</c:if>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>

		<!------------------------------------- Container 2 : 구글 맵 및 여행 정보   ------------------------------------->
		<div class="container2">
			<!--------------------- 여행 정보 : 이름, 출발날짜, 종료날짜, 지도 탭  --------------------->
			<div>
				<div class="schedule_container">
					<c:forEach var="itinerary" items="${itineraryList }" begin="0"
						end="0">
						<div class="schedule_detail" id="tourName" style="float: left;">${itinerary.tourName }</div>
						<div class="schedule_detail" id="departureDate"
							style="float: left">
							<fmt:formatDate value="${itinerary.departureDate }"
								pattern="yyyy/MM/dd" />
						</div>
						<div class="schedule_detail" style="float: left">-</div>
						<div class="schedule_detail" id="endDate">
							<fmt:formatDate value="${itinerary.endDate }"
								pattern="yyyy/MM/dd" />
						</div>
					</c:forEach>
				</div>
				<div>
					<button class="placeOrNavi" id="placeBtn" onclick="showPlace()">
						<img class="schedule_detail" src="../img/place.png">
					</button>
					<button class="placeOrNavi" id="naviBtn" onclick="showNavi()">
						<img class="schedule_detail" src="../img/directions.png">
					</button>
				</div>
			</div>

			<!--------------------------------- 구글 지도  --------------------------------->
			<div>
				<div class="map-canvas" id="map"
					style="width: 100%; position: relative;"></div>
				<!--------- 1. Google Place Map : 장소 검색 --------->
				<div id="placeSection">
					<div class="column" style="width: 30%; position: relative; left: 10px; top: -620px;">
						<div id="listing">
							<table id="results"></table>
						</div>
					</div>
					<!-- 검색 -->
					<div class="column">
						<div class="field_map">
							<input type="text" id="autocomplete" class="input_map"
								style="float: left;">
							<div id="controls">
								<select name="controls" id="searchType" class="input_map">
									<option value="restaurant">식당</option>
									<option value="subway_station">지하철</option>
									<option value="lodging">숙박업소</option>
									<option value="natural_feature">관광명소</option>
									<option value="establishment">기관, 시설</option>
									<option value="hospital">병원</option>
								</select>
								<button class="searchBtn" onclick="search()">Search</button>
							</div>
						</div>
					</div>
				</div>
				<!--------- 2. Google Directions Map : 길찾기 검색 --------->
				<div id="naviSection" style="display: none">
					<div class="column" style="width: 30%; position: relative; left: 10px; top: -600px;">
						<div id="naviBox">
							<table id="naviResult"></table>
						</div>
					</div>
					<div class="field_map">
						<input type="text" class="input_map" id="start" /> <input
							type="text" class="input_map" id="fin" />
						<button class="searchBtn" id="directionsBtn" onclick="calcRoute()">Search</button>
					</div>
				</div>
			</div>
		</div>
	</div>




	<!------------------------------------------ 모달 창   ------------------------------------------>
	<!---- 1. TOUR 일정 추가 및 수정 모달 창  ---->
	<div class="modal" id="modTour" style="display: none;">
		<div align="center">
			<input type="text" class="modText" id="itinerarySeq"
				style="display: none"><br> <input type="text"
				class="modText" id="tourSpot"><br>
			<textarea class="modText" rows="3" cols="20" id="tourMemo"
				placeholder="상세 메모"></textarea>
			<br>
			<br> <input type="text" class="modText" id="spotLink"
				readonly="readonly" style="display: none">
		</div>
		<div align="center" class="modal_btn">
			<button class="btn-primary" id="addTourBtn" onclick="addTour()">Add</button>
			<button class="btn-primary" id="modifyTourBtn" onclick="modifyTour()">Modify</button>
			<button class="btn-primary" id="closeTourBtn" onclick="closeTour()">Close</button>
		</div>
	</div>
	<!---- 2. TRANSPORT 일정 추가 시, 이동 수단 입력 받는 모달 창  ---->
	<div class="modal" id="modTransport" style="display: none;">
		<div align="center">
			<label><input type="radio" name="transportation" value="walk">도보</label>
			<label><input type="radio" name="transportation"
				value="drive">자동차</label> <label><input type="radio"
				name="transportation" value="transit">대중교통</label>
		</div>
		<div align="center">
			<button id="choiceTransport" class="btn-primary" onclick="addTransport()">submit</button>
			<button id="updateChoiceTransport" class="btn-primary" onclick="updateTransport()">submit</button>
			<button class="btn-primary" onclick="closeTransport()">close</button>
		</div>
	</div>


</body>
</html>