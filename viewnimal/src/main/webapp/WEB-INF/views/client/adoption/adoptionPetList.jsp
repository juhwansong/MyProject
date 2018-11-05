<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>			
	.vm-adoptionPetList__petContent {
	  font-family: 'Raleway', Arial, sans-serif;
	  color: #fff;
	  position: relative;
	  float: left;
	  overflow: hidden;
	  margin: 10px 1%;
	  width: 350px;
	  height: 250px;
	  color: #ffffff;
	  text-align: left;
	  background-color: #07090c;
	  font-size: 16px;
	  -webkit-perspective: 50em;
	  perspective: 50em;
	  border-radius: 10px;
	}	
	.vm-adoptionPetList__petContent * {
	  -webkit-box-sizing: border-box;
	  box-sizing: border-box;
	  -webkit-transition: all 0.6s ease;
	  transition: all 0.6s ease;
	}	
	.vm-adoptionPetList__petContent img {
	  opacity: 1;
	  width: 100%;
	  -webkit-transform-origin: 50% 0%;
	  -ms-transform-origin: 50% 0%;
	  transform-origin: 50% 0%;
	  width: 100%;
      height: 100%;
      background: white;
      object-fit: cover;
	}	
	.vm-adoptionPetList__petContent figcaption {
	  position: absolute;
	  top: 0;
	  left: 0;
	  bottom: 0;
	  width: 100%;
	  -webkit-transform: rotateX(90deg);
	  transform: rotateX(90deg);
	  -webkit-transform-origin: 50% 100%;
	  -ms-transform-origin: 50% 100%;
	  transform-origin: 50% 100%;
	  z-index: 1;
	  opacity: 0;
	  padding: 20px 30px;
	}	
	.vm-adoptionPetList__petContent h3,
	.vm-adoptionPetList__petContent p {
	  line-height: 1.5em;
	}
	.vm-adoptionPetList__petContent h3 {
	  margin: 0;
	  font-weight: 800;
	  text-transform: uppercase;
	}	
	.vm-adoptionPetList__petContent p {
	  font-size: 0.8em;
	  font-weight: 500;
	  margin: 0 0 15px;
	}	
	.vm-adoptionPetList__petContent .read-more {
	  border: 2px solid #ffffff;
	  padding: 0.5em 1em;
	  font-size: 0.8em;
	  text-decoration: none;
	  color: #ffffff;
	  display: inline-block;
	}	
	.vm-adoptionPetList__petContent .read-more:hover {
	  background-color: #ffffff;
	  color: #000000;
	}	
	.vm-adoptionPetList__petContent:hover img,
	.vm-adoptionPetList__petContent.hover img {
	  -webkit-transform: rotateX(-90deg);
	  transform: rotateX(-90deg);
	  opacity: 0;
	}	
	.vm-adoptionPetList__petContent:hover figcaption,
	.vm-adoptionPetList__petContent.hover figcaption {
	  -webkit-transform: rotateX(0deg);
	  transform: rotateX(0deg);
	  opacity: 1;
	  -webkit-transition-delay: 0.2s;
	  transition-delay: 0.2s;
	}
	.vm-adoptionPetList-modal tr,
	.vm-adoptionPetList-modal td {
		padding: 15px;
	}
	
	
	/******* 추가 *******/
	.vm-adoptionPetList__info-div-outline {
		position: relative;
		width: 100%;
		height: 490px;
		background:#333;
		border-radius: 10px;
		overflow: hidden;
	}
	
	.vm-adoptionPetList__info-img {
		float: center;
		height:490px;
	}	

	.vm-adoptionPetList__info-div-inline {
		display : inline;
		float : right;
		width : 400px;
		height : 490px;
		padding : 4rem 2rem 4rem 2rem;
	}

	.vm-adoptionPetList__info-div-text {
		text-align : center; 
		font-size : 20px; 
		color : #333; 
		margin : 10;
	}
	
	.vm-adoptionPetList__info-div-adoptionRule {
		margin : 10px 5px 20px 5px;
		color : #333;
	}
	
	
</style>
<c:import url="/WEB-INF/views/common/top.jsp" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-section">	
		<div class="vm-content vm-adoptionPetList">
			<div class="vui-headline">입양 동물 리스트</div><%--추가 --%>
			
			<hr>
			
			<div class="vm-adoptionPetList__info-div-outline">
				<img class="vm-adoptionPetList__info-img" src="/resources/images/adoption/info/infoImg.jpg">
				<div class="vm-adoptionPetList__info-div-inline">
					<p style="font : bold 4rem batang; color: #f06199;">사지말고,<br>입양하세요</p>
					<br><br>
					<p style="color: white;">&nbsp;누구든지 돈을 주고 동물을 산다면<br>
					&nbsp;그 이면에는 죽을때까지 고통 받아야 하는<br>
					&nbsp;또 다른 생명들이 존재해야 하는 것을<br>
					&nbsp;기억해주세요.</p>
				</div>
			</div>
			
			<div class="vm-adoptionPetList__info-div-adoptionRule">
				<p style="font : bold 1.1rem nanum;">새로운 가족을 입양하는 일입니다. 소요기간이 길어지더라도 양해부탁드립니다.</p>
				<ul>
					<li>입양 신청이 완료된 이후 기재하신 연락처로 <span style="color: #5b75e7;"><b>Viewnim@l</b></span>에서 직접 연락을 드립니다.</li>
					<li>미성년자는 보호자의 동의 및 직접적인 보호자와의 인터뷰 절차를 거치게 됩니다.</li>
					<li>입양된 이후에 입양인은 반드시 사후 관리 모니터링에 응해주셔야 합니다.</li>
				</ul>
			</div>
			
			
			<hr class="mt-3 mb-5">
			
			<div class="vm-adoptionPetList__info-div-text">
				<b> 아이들의 가족이 되어주세요  </b>
			</div>
			<hr class="mt-5 mb-1">
			<h6 class="mb-3 ml-1">총 아이들 수 : ${ listCount }</h6>
			<%-- //추가 끝 --%>
			
			<table cellpadding="20">
				<tr>
				<c:forEach items="${ requestScope.petList }" var="pet" varStatus="status">
				<c:if test="${ status.count ge 1 && status.count le 3 }">
					<td>		
						<figure class="vm-adoptionPetList__petContent">
						<input type="hidden" name="pet_id" value="${ pet.pet_id }">
					  	<img src="resources/images/adoption/${ pet.image }"/>
						 	<figcaption>
						   		<p align="center">
						  			<br>${ pet.bdetail }<br>	
						  						  			
						  			<c:choose>
						  				<c:when test="${ pet.gender eq 'F'.charAt(0) }">
						  					여아
						  				</c:when>
						  				<c:otherwise>
						  					남아
						  				</c:otherwise>
						  			</c:choose><br>
						  			
							   		${ pet.weight }kg<br>
							   		
							   		<c:choose>
							   			<c:when test="${ pet.age >= 0 && pet.age < 1}">
							   				<fmt:parseNumber var="ages" value="${ pet.age * 10}" integerOnly="true"/>${ ages }개월
							   			</c:when>
							   			<c:when test="${ pet.age >=1 }">
							   				<fmt:parseNumber var="ages" value="${ pet.age }" integerOnly="true"/>${ ages }세
							   			</c:when>
							   		</c:choose><br>
							   		
							   		중성화${ pet.neuter }<br><br>	
							   		
							   		<c:if test="${ loginMemberDto.type == 'ADMIN' }">
								   		<button type="button" class="btn btn-primary btn-sm" onclick="location.href='MoveAdoptionPetUpdate?id=${ pet.pet_id }'">수정하기</button>					   	
						   			</c:if>
						   			<c:if test="${ loginMemberDto.type  == 'USER' }">
						   				<button type="button" class="btn-adoption btn btn-primary btn-sm">입양하기</button>
						   			</c:if>
						   			<c:if test="${ loginMemberDto == null }">
						   				<span style="color: #5e72e4;">입양 서비스는 로그인 후 사용 가능합니다 :)</span>
						   			</c:if>
						   		</p>						   						   							   
						    </figcaption>						    			    	    				 
						</figure>					
						<br>					
						<center><b>${ pet.name }</b></center>
						
					</td>
					</c:if>
					</c:forEach>										
				</tr>
				<tr>
				<c:forEach items="${ requestScope.petList }" var="pet" varStatus="status">
				<c:if test="${ status.count ge 4 }">
					<td>		
						<figure class="vm-adoptionPetList__petContent">
						<input type="hidden" name="pet_id" value="${ pet.pet_id }">
					  	<img src="resources/images/adoption/${ pet.image }"/>
						 	<figcaption>
						   		<p align="center">
						  			<br>	
						  			${ pet.bdetail }<br>				  			
						  			
						  			<c:choose>
						  				<c:when test="${ pet.gender eq 'F'.charAt(0) }">
						  					여아
						  				</c:when>
						  				<c:otherwise>
						  					남아
						  				</c:otherwise>
						  			</c:choose><br>
						  			
							   		${ pet.weight }kg<br>
							   		
							   		<c:choose>
							   			<c:when test="${ pet.age >= 0 && pet.age < 1}">
							   				<fmt:parseNumber var="ages" value="${ pet.age * 10}" integerOnly="true"/>${ ages }개월
							   			</c:when>
							   			<c:when test="${ pet.age >=1 }">
							   				<fmt:parseNumber var="ages" value="${ pet.age }" integerOnly="true"/>${ ages }세
							   			</c:when>
							   		</c:choose><br>
							   		
							   		중성화${ pet.neuter }<br><br>							   		
							   		
							   		<c:if test="${ loginMemberDto.type == 'ADMIN' }">
								   		<button type="button" class="btn btn-primary btn-sm" onclick="location.href='MoveAdoptionPetUpdate?id=${ pet.pet_id }'">수정하기</button>					   	
						   			</c:if>
						   			<c:if test="${ loginMemberDto.type  == 'USER' }">
						   				<button type="button" class="btn-adoption btn btn-primary btn-sm">입양하기</button>
						   			</c:if>
						   			<c:if test="${ loginMemberDto == null }">
						   				<span style="color: #5e72e4;"><b>입양 서비스는 로그인 후 사용 가능합니다 :)</b></span>
						   			</c:if>
						   		</p>						   						   							   
						    </figcaption>						    			    	    				 
						</figure>					
						<br>					
						<center><b>${ pet.name }</b></center>
						
					</td>
					</c:if>
					</c:forEach>			
				</tr>
			</table>				
				
								
		</div>
		
		
		
		
		
		<div class="vui-board__box vui-board__box--b row">
			<div class="col">
					
			</div>
		
			<div class="col">
				<nav class="vui-navigation" aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${ requestScope.prev }">
							<li class="page-item">
								<a class="page-link" href="javascript:page(${ currentPage - 1 });" tabindex="-1">
								<i class="fa fa-angle-left"></i>
								<span class="sr-only">Previous</span>
								</a>
							</li>
						</c:if>
						<c:forEach begin="${ startPage }" end="${ endPage }" var="pageIdx">
							<c:choose>
								<c:when test="${ currentPage eq pageIdx }">
									<li class="page-item active"><a class="page-link" href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="javascript:page(${ pageIdx });">${ pageIdx }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${ requestScope.next }">
							<li class="page-item">
							<c:if test="${ requestScope.totalPage eq requestScope.currentPage }">
								<a class="page-link" href="#">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</c:if>
							<c:if test="${ requestScope.totalPage ne requestScope.currentPage }">
								<a class="page-link" href="javascript:page(${ currentPage + 1 });">
								<i class="fa fa-angle-right"></i>
								<span class="sr-only">Next</span>
								</a>
							</c:if>	
							</li>
						</c:if>
					</ul>
				</nav>
			</div>	
			
			<div class="col text-right">
				<c:if test="${ loginMemberDto.type == 'ADMIN' }">
					<button type="button" class="btn btn-primary" onclick="location.href='MoveAdoptionPetEnroll'">등록하기</button>					
				</c:if>
			</div>								
		</div>	
		
		
		<!-- Modal -->	
		<form id="adoptPet">
		<div class="modal fade" id="detail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content" style="width:330px; height:370px;">
		      <div class="modal-header"><p><p><p><p>
		        <h5 class="modal-title" id="exampleModalLabel"><b>입 양 하 기</b></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>		      
		      	<input type="hidden" name="pet_id" value="pet_id">	
				<input type="hidden" name="id" value="${ sessionScope.loginMemberDto.id }">
		      <table class="vm-adoptionPetList-modal">			     	
		      	<tr>
		      		<td>성 함 &nbsp;&nbsp;</td>
		      		<td><input type="text" id="username" name="username" class="form-control form-control-alternative" style="width:150px;" value=""></td>
		      	<tr>
		      	<tr>
		      		<td>연락처 &nbsp;&nbsp;&nbsp;</td>
		      		<td><input type="tel" id="tel" name="phone" class="form-control form-control-alternative" style="width:150px;" value="${ sessionScope.loginMemberDto.phone }"></td>
		      	</tr>
		      </table>
		      	<br>
		      	<p style="text-align:center;">자세한 사항은<br>전화상으로 진행하겠습니다.</p>
		      <div class="modal-footer">		        
		        <button type="button" class="btn btn-primary btn" onclick="apply();">신 청</button>
		      </div>
		    </div>
		  </div>		
		</div>
		</form>
		<br><br><br>
	</div>
</div>



<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<script src="/resources/each/js/adoptionPetList.js?${verQuery}"></script>

<%-- -------- JavaScript -------- --%>
<script>
	//유효성 검사 - 정규식
	$("#tel").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	$("#username").on("keyup", function(){
		$(this).val($(this).val().replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g,""));
	});

	function apply(){
		var userName = $("#username").val();
		var phone = $("#tel").val();
		var userId = $('[name="id"]').val();
		
		// 유효성 검사
		if(userName == ""){
			alert("성함을 입력해주세요!");
			$("#username").focus();
			return false;
		}		
		if(phone == ""){
			alert("연락처를 입력해주세요!");
			$("#tel").focus();
			return false;
		}
		if(userName.length > 6){
			alert("성함을 확인해주세요!");
			$("#username").select();
			return false;
		}
		if(phone.length > 12){
			alert("연락처를 확인해주세요!");
			$("#tel").select();
			return false;
		}


		var serialize = $("#adoptPet").serializeArray();
		console.log(serialize);
		  
		$.ajax({	
			url : "/ApplyAdoption",
			data : serialize,
			type : "post",			
			success : function(data){
				alert($("#username").val() + "님 입양 신청이 완료되었습니다! \n곧 연락드리겠습니다.");
				$("#detail").modal('hide');
			},
			error : function(request, status, errorData){
				alert("error code : " + request.status + "\n" +
						"message : " + request.responseText + "\n" +
						"error + " + errorData);
			}
		})
	} //apply()
		
	
	function page(pageIdx){
		
		var nowPage = pageIdx;
		location.href = "/AdoptionPage?currentPage="+pageIdx+"&limit=6";	
	}; //page()
</script>
<%-- -------- //JavaScript -------- --%>