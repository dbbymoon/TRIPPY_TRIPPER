/**
 * 
 */

$(function(){
		
		$(".satisfied").on("click",function(){
			$(".satisfied").removeClass("checked");
			for(var i=1;i<=(this.getAttribute("id").substring(9,11));i++){
				$("#satisfied"+i).addClass("checked");
			}
			$("#satisfiedScore").html(this.getAttribute("id").substring(9,11));
		});
		$(".before").on("click",function(){
			$(".before").removeClass("checked");
			for(var i=1;i<=(this.getAttribute("id").substring(6,8));i++){
				$("#before"+i).addClass("checked");
			}
			$("#beforeScore").html(this.getAttribute("id").substring(6,8));
		});
		$(".active").on("click",function(){
			$(".active").removeClass("checked");
			for(var i=1;i<=(this.getAttribute("id").substring(6,8));i++){
				$("#active"+i).addClass("checked");
			}
			$("#activeScore").html(this.getAttribute("id").substring(6,8));
		});
		
		
		var tourName = $("#itineraryList option:selected").val();
		
		var timeline = document.getElementById('timeline');
		var div = document.createElement('div');
		div.classList.add("day_left");
		var text = document.createTextNode("Day 1");
		div.appendChild(text);
		timeline.appendChild(div);
		
		$.ajax({
			url:"showMyItinerary",
			type:"GET",
			data:{
				tourName : tourName
			},
			dataType :"json",
			success:function(data){
				var i=0;
				var j=0;
				var dayCount = 0;
				$(data).each(function(){
					var tourDate = new Date(this.departureDate);
					var tourSpot = this.tourSpot;
					var spotLink = this.spotLink;
					tourDate.setDate(tourDate.getDate()+dayCount);
					
					if(new Date(this.tourDate).getTime()!==tourDate.getTime()){
// 						alert(new Date(this.tourDate));
						dayCount++;
						var timeline = document.getElementById('timeline');
						var div = document.createElement('div');
						if(j%2==0){
							div.classList.add("day_right");
						}else{
							div.classList.add("day_left");
						}
						var text = document.createTextNode("Day "+(dayCount+1));
						div.appendChild(text);
						timeline.appendChild(div);
						j++;
					}
					if(tourSpot!=null){
						var timeline = document.getElementById('timeline');
						var div1 = document.createElement('div');
						div1.classList.add('container');
						if(i%2==0){
							div1.classList.add('left');
						}else{
							div1.classList.add('right');
						}
						var div2 = document.createElement('div');
						div2.classList.add('content');
						var h2 = document.createElement('h2');
						h2.style.color="black";
						var spot = document.createTextNode(tourSpot);
						var p = document.createElement('p');
						var spot_aTag = document.createElement('a');
					 	spot_aTag.appendChild(spot);
					 	spot_aTag.setAttribute("href",spotLink);
					 	spot_aTag.setAttribute("target","_blank");
					 	var tourMemo;
					 	if(this.tourMemo!=null){
							tourMemo = document.createTextNode(this.tourMemo);
					 	}else{
					 		tourMemo = document.createTextNode(" ");
					 	}
					 
					 	//별점 주기
// 					 	var span;
// 					 	var starDiv = document.createElement('div');
// 					 	for(var x=0;x<5;x++){
// 					 		span = document.createElement('span');
// 						 	span.classList.add('fa');
// 						 	span.classList.add('fa-star');
// 						 	starDiv.appendChild(span);
// 					 	}

//						var button = document.createElement('button');
//						var text = document.createTextNode('후기');
//						button.addEventListener("click",function(event){
//							$("#star_tourSpot").html(tourSpot);
//							$("#star_spotLink").html(spotLink);
//							$("#starDiv").show("slow");
//						},false);
//						div2.appendChild(button);
					 	
					 	h2.appendChild(spot_aTag);
						p.appendChild(tourMemo);
						div2.appendChild(h2);
						
// 						div2.appendChild(starDiv);
						
						div2.appendChild(p);
						div1.appendChild(div2);
						timeline.appendChild(div1);
						i = i+1;
					}
				});
			},
			error:function(request,status,error){

			}
		});
	});
	
	function closeResearch(){
		$(".fa").removeClass("checked");
		$("#starDiv").hide("slow");	
	}
	function saveResearch(){
		var tourSpot = $("#star_tourSpot").html();
		var spotLink = $("#star_spotLink").html();
		var beforeScore = $("#beforeScore").html();
		var satisfiedScore = $("#satisfiedScore").html();
		var activeScore = $("#activeScore").html();
		
		$(".fa").removeClass("checked");
		$("#starDiv").hide("slow");	
	}
	

	function selectMyItinerary(){
		var tourName = $("#itineraryList option:selected").val();
		
		$(".container").remove();
		$(".day_left").remove();
		$(".day_right").remove();
		var timeline = document.getElementById('timeline');
		var div = document.createElement('div');
		div.classList.add("day_left");
		var text = document.createTextNode("Day 1");
		div.appendChild(text);
		timeline.appendChild(div);
		
		$.ajax({
			url:"showMyItinerary",
			type:"GET",
			data:{
				tourName : tourName
			},
			dataType :"json",
			success:function(data){
				
				var i=0;
				var j=0;
				var dayCount = 0;
				$(data).each(function(){
					var tourDate = new Date(this.departureDate);
					tourDate.setDate(tourDate.getDate()+dayCount);
					
					if(new Date(this.tourDate).getTime()!==tourDate.getTime()){
// 						alert(new Date(this.tourDate));
						dayCount++;
						var timeline = document.getElementById('timeline');
						var div = document.createElement('div');
						if(j%2==0){
							div.classList.add("day_right");
						}else{
							div.classList.add("day_left");
						}
						var text = document.createTextNode("Day "+(dayCount+1));
						div.appendChild(text);
						timeline.appendChild(div);
						j++;
					}
					if(this.tourSpot!=null){
						var timeline = document.getElementById('timeline');
						var div1 = document.createElement('div');
						div1.classList.add('container');
						if(i%2==0){
							div1.classList.add('left');
						}else{
							div1.classList.add('right');
						}
						var div2 = document.createElement('div');
						div2.classList.add('content');
						var h2 = document.createElement('h2');
						h2.style.color="black";
						var tourSpot = document.createTextNode(this.tourSpot);
						var p = document.createElement('p');
						var spot_aTag = document.createElement('a');
					 	spot_aTag.appendChild(tourSpot);
					 	spot_aTag.setAttribute("href",this.spotLink);
					 	spot_aTag.setAttribute("target","_blank");
					 	var tourMemo;
					 	if(this.tourMemo!=null){
							tourMemo = document.createTextNode(this.tourMemo);
					 	}else{
					 		tourMemo = document.createTextNode(" ");
					 	}
					 	h2.appendChild(spot_aTag);
						p.appendChild(tourMemo);
						div2.appendChild(h2);
						div2.appendChild(p);
						div1.appendChild(div2);
						timeline.appendChild(div1);
						i = i+1;
					}
				});
			},
			error:function(request,status,error){
			}
		});
	}
	
	
	 
	   function deleteMyPlan(){
	      var tourName = $("#itineraryList option:selected").val();
	      $.ajax({
	         url:"deleteMyPlan",
	         type:"POST",
	         data:{
	            tourName:tourName
	         },
	         dataType:"text",
	         success:function(result){
	            if(result == "SUCCESS"){
	               swal({title: 'SUCCESS!',text: '삭제 되었습니다.',type: 'success',confirmButtonText: 'OK',}).then(function(){location.reload(true)});
	            }
	         },
	         error : function(request,status,error){
	            swal({title: 'Error!',text: '실패',type: 'error',confirmButtonText: 'OK',});
	         }
	      });
	   }