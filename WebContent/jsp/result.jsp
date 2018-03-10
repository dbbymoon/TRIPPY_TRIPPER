<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<link rel="stylesheet" type="text/css" href="../css/sweetalert2.css">

<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous"></script>

<!-- sweetalert js -->
<script src="../js/sweetalert2.min.js"></script>

<script type="text/javascript">
	$(function(){
		if('${state}' == "success"){
			swal({
				  title: 'Success!',
				  text: '${msg}',
				  type: 'success',
				  confirmButtonText: 'OK',
			}).then(function(){
			    location.href = '${url}';
			});
		}else{
			swal({
				  title: 'Error!',
				  text: '${msg}',
				  type: 'error',
				  confirmButtonText: 'OK',
			}).then(function(){
			    location.href = '${url}';
			});
		}
	});
</script>


