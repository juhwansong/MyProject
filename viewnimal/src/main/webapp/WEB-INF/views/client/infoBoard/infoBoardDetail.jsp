<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/infoBoardDetail.css?${verQuery}" />
<script type='text/javascript' src='/resources/each/js/infoBoardDetail.js'></script>
<style>

input[type="submit"]
 {
	background: #172b4d;;
	border-radius: 0 !important;
	border: 2px solid #172b4d;;
	color: #fff;
	font-size: 20px;
	font-weight: bold;
	height: 50px;
	letter-spacing: 1px;
	line-height: 48px;
	max-width: 250px;
	padding: 0;
	width: 100%;
    align-items: flex-start;
    text-align: center;
    float: right;

}
 
.comments input[type="submit"] {
	max-width: 25%;
	float: right;
}

textarea {
	width: 100%;
	background: #f5f5f5;
	border-radius: 0;
	padding: 16px 20px;
}

.vm-infoBoardDetail__fn {
	font-size: 1.3rem;
	color: #172b4d;
}
.vm-infoBoardDetail #content-tag-area{
	min-height:400px;
	margin-left:20px;
	margin-top:10px;
}  
.vm-infoBoardDetail .vm-infoBoardDetail__content{
	margin:32px;
}
.vm-infoBoardDetail .vm-infoBoardDetail__btn-box{
	display:flex; 
	flex-direction:row; 
	justify-content:center;
}
.vm-infoBoardDetail .vm-infoBoardDetail__btn-box__left{
	width:50%;
}
.vm-infoBoardDetail .vm-infoBoardDetail__btn-box__right{
	width:50%;
	text-align:right;
}
.vm-infoBoardDetail .vm-volunteerEpilogueDetail_reply-box{
	display:flex;	
	flex-direction:row;
}
.vm-infoBoardDetail .vm-volunteerEpilogueDetail_reply-box__write-box{ 
	width: 90%;
}
.vm-infoBoardDetail .vm-volunteerEpilogueDetail_reply-box__write-box__textarea{ 
	resize: none;
	width: 100%; 
	height: 80px;
	vertical-align: middle;
}
.vm-infoBoardDetail .vm-volunteerEpilogueDetail__reply-box__btn-box{ 
	width: 10%;	
	text-align: right;	
}

.vm-infoBoardDetail .vm-volunteerEpilogueDetail__reply-box__btn-box__btn{ 
	width: 90%; 
	height: 80px;
	font-size: 20px;
	letter-spacing: 5px; 
}
.vm-infoBoardDetail .vm-volunteerEpilogueDetail__content-table tr > *{
	vertical-align: middle!important;
}
.vm-infoBoardDetail .vm-infoBoardDetail__content-table__comment-text-td{
	position:relative;
}	
.vm-infoBoardDetail .vm-infoBoardDetail__comment-box{
	margin-top: 10px; 
	margin-bottom: 10px;
}
.vm-infoBoardDetail .vm-infoBoardDetail__comment-box__write-info-box{
	display:flex; 
	flex-direction:row;
}
.vm-infoBoardDetail .info-box__left-box{
	width:50%;
}
.vm-infoBoardDetail .info-box__right-box{
	width:50%; 
	text-align:right;
}
.vm-infoBoardDetail .vm-infoBoardDetail__comment-box__content-box{
	margin-top:30px; 
	margin-right:5px;
}

</style>


<br>
<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-infoBoardDetail">
		<div class="vm-section">

			<div class="vui-board">
				<table class="table vm-infoBoardDetail__content-table">
					<tr>
						<th width="12%">1</th>
						<th width="90%">반려동물 동물등록, 꼭 해야 하는 이유</th>
						<th width="30%">작성자 </th>
						<th width="20%"><i class="fa fa-clock-o"></i>09-09 16:30</th>	
						
					</tr>
					
					
					<tr>
						<td colspan="4">
							<div id="content-tag-area">			
								<p>
									반려동물 등록제가 의무화된 지 어느새 4년이 지났다. 등록률은 각 지자체의 홍보에 따라 높아지고 있으나, 아직도 ‘완전 등록’의 상태를 도달하기에는 역부족이다.
								</p> 
								<p title="존귀져?" >
								<img width="1170" height="550" src="https://images.mypetlife.co.kr/content/uploads/2018/10/09223831/puppies-1871260_1920-1024x683.jpg" class="single-featured wp-post-image" alt="" srcset="" sizes="(max-width: 1170px) 100vw, 1170px" />
								</p>
								<p>
								동물등록제란 동물보호법상 3개월령 이상의 반려견에 대해 등록을 의무화하는 제도다. 이에 따라, 견주는 내장칩, 외장칩 혹은 인식표 중 한 방법으로 반려견을 등록해야 한다. 미등록 시 최고 100만원의 과태료가 부과될 수 있다.
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="4" height="120px">
							<!-- 목록,신청 등 버튼 영역 -->
							<div class="vm-infoBoardDetail__btn-box">
								<div class="vm-infoBoardDetail__btn-box__left">
									<button class="btn btn-default" type="button" onclick="location.href='InfoBoard'">목록</button>
								</div>
								<div class="vm-infoBoardDetail__btn-box__right">
							   		<button class="btn btn-default" type="submit" style="outline: none;">수정</button>
							   		<button class="btn btn-default" type="submit" style="outline: none;">삭제</button>
							   	</div>
							</div>
						</td>
					</tr>
					<!-- 댓글 작성부분 -->
					<tr>
						<td class="vm-infoBoardDetail__content-table__comment-text-td" colspan="4" height="200px">
							
							<!-- 댓글 입력창 영역 -->		
							<!-- <div class="vm-volunteerEpilogueDetail_reply-box">
								<div class="vm-volunteerEpilogueDetail_reply-box__write-box">									
									<textarea class="vm-volunteerEpilogueDetail_reply-box__write-box__textarea" rows="2"></textarea>
								</div>
								<div class="vm-volunteerEpilogueDetail__reply-box__btn-box">
									<button class="btn btn-default vm-volunteerEpilogueDetail__reply-box__btn-box__btn" type="button">등록</button>
								</div>
							</div> -->
						<div id="respond" class="comment-respond">
						<h3 id="reply-title" class="comment-reply-title">댓글 달기
							<small>
								<a rel="nofollow" id="cancel-comment-reply-link" href="" style="display: none; font-size: 15px;">취소</a>
							</small> 
						</h3>
						
						
						<form action="" method="post" id="commentform" class="comment-form" novalidate>
							
							<textarea placeholder="인터넷은 우리가 함께 만들어가는 소중한 공간입니다.&#10;댓글 작성 시 타인에 대한 배려와 책임을 담아주세요.&#10;" id="comment" name="comment" cols="45" rows="8" aria-required="true" required="required"></textarea>
							
							<p class="form-submit">
								<input name="submit" type="submit" id="submit" class="submit" value="등록"/> 
								<input type='hidden' name='comment_post_ID' value='155' id='comment_post_ID' />
								<input type='hidden' name='comment_parent' id='comment_parent' value='0' />
								<br>
							</p>
							
							<p style="display: none;">
								<input type="hidden" id="akismet_comment_nonce" name="akismet_comment_nonce" value="ea25e3c9b9" />
							</p>
							
							<p style="display: none;">
								<input type="hidden" id="ak_js" name="ak_js" value="216" />
							</p>
						</form>
					</div>
							<!-- /댓글 입력창 영역 끝-->
						</td>					
					</tr>	
					
					
					
					<tr>
					<th></th>
					</tr>

					
					<!-- /댓글 끝 -->					
				</table>
				
				<div class="row">
				<div id="primary" class="vm-infoBoardDetailReply">

				
				<!-- #post-## -->

				<div id="comments" class="comments-area comments  nolist">
					<h5 class="comments-title" style="color: Default;">15 COMMENTS</h5>
					<hr>
					


					<ul class="comments-list">
						<li class="comment even thread-even depth-1" id="comment-3">
							<div id="div-comment-3" class="comment-body">
								<!-- div class="avatar">
									<img alt=''
										src='https://secure.gravatar.com/avatar/ef331c6e33890a8fa68e36cb7a7f0f87?s=75&#038;d=mm&#038;r=g'
										srcset='https://secure.gravatar.com/avatar/ef331c6e33890a8fa68e36cb7a7f0f87?s=150&#038;d=mm&#038;r=g 2x'
										class='avatar avatar-75 photo' height='75' width='75' />
								</div> -->
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">짱절미</b>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
									      
									      
									
									<div class="comment-date">
										<!-- <time datetime="2016-01-28T12:43:17+00:00">
											September 4, 2007 at 10:49 am </time> -->
											<a>September 4, 2007 at 10:52 am</a>
									
									<a rel='nofollow' class='btn btn-xs comment-reply'
										href='#comment-3'
										onclick='return addComment.moveForm( "div-comment-3", "3", "respond", "155" )'
										aria-label='Reply to tellyworthtest2'>답글</a></div>

									<p>댓글입니다. 넘나,, 시간 순삭이었습니다. 한것도 없는데 어떻게 이럴 수가 있죠? 창문을 열어뒀더니 손이 시렵습니다. 아까 외출하고 왔을때 모기가 같이 따라 들어온 듯 합니다. 다리에 4방이나 물렸습니다. 긁지 않아야겠죠 모기,,,가만두지 않을거야</p>

								</div>
							</div>
						</li>
						<hr>
						
						
						
						<!-- #comment-## -->
						<li class="comment odd alt thread-odd thread-alt depth-1"
							id="comment-2">
							<div id="div-comment-2" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">인절미 악개</b>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
									<div class="comment-date">
									<a>September 4, 2007 at 10:50 am</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'
										href='#comment-2'
										onclick='return addComment.moveForm( "div-comment-2", "2", "respond", "155" )'
										aria-label='Reply to Anon'>답글</a></div>

									<p>흰색 검은색 빨간색이 있었습니다. 통관번호를 어딘가에 적어놨었는데 찾아보니 전 노트북에 있어서 직접 홈페이지에 가서 조회하는 동안 화이트가 매진이 되었습니다. 마음이 조급해졌죠,, 그래서 얼른 블랙을 골랐습니다. 왜냐하면 진정한 간지는 블랙이니까요. 그런데 결제 마지막에 품절이라고 튕겨 나왔습니다. 새벽이었는데 왜이렇게 사람들이 많이 깨어있나요,, 따흑 사실 저는 원래 레드를 좋아하기때문에 레드를 얼른 골랐고 겨우,, 결제를 했습니다. 그리고 품절이 되었죠.  </p>

								</div>
							</div>
						</li>
						</li>
						<hr>
						
						<!-- #comment-## -->
						<li class="comment even thread-even depth-1 parent" id="comment-4">
							<div id="div-comment-4" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">허니콤보</b>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>		
									<div class="comment-date">
										<a>September 4, 2007 at 10:48 am </a>
									
										<a rel='nofollow' class='btn btn-xs comment-reply'
											href='#comment-4'
											onclick='return addComment.moveForm( "div-comment-4", "4", "respond", "155" )'
											aria-label='Reply to John Doe'>답글</a></div>

									<p>야행성이라서 밤에 커피머신을 켜봤는데 소리가 생각보다 커서 놀랐습니다. 어서 이 진동이 끝났으면 싶고, 아무도 이 소음을 듣지 말아주었으면 하는 간절한 바람,,, 설명서를 읽어보니 적어도 3번은 물만 넣고 작동 시켜서 세척하라고 하더군요. </p>

								</div>
							</div>
						</li>
						<ol class="children">
							<li class="comment odd alt depth-2 parent" id="comment-36">
								<div id="div-comment-36" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">궁구미</b>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
										<div class="comment-date">
											<a> April 27, 2016 at 11:57 pm </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-36'
												onclick='return addComment.moveForm( "div-comment-36", "36", "respond", "155" )'
												aria-label='Reply to asd'>답글</a></div>

										<p>몇 번 헹구셨나요?</p>

									</div>
								</div>
							</li>
							<ol class="children">
								<li class="comment even depth-3 parent" id="comment-92">
									<div id="div-comment-92" class="comment-body">
										<div class="comment">
											<b class="vm-infoBoardDetail__fn">허니콤보</b>
											<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
											<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
											<div class="comment-date">
												<a>December 2, 2016 at 10:22 pm </a>
											
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-92'
												onclick='return addComment.moveForm( "div-comment-92", "92", "respond", "155" )'
												aria-label='Reply to Sai @BloggerStop.Net'>답글</a></div>

											<p>아무래도 3번은 찝찝해서,, 6번을 해주었습니다.  사실,,, 7번인가 8번 한 것같습니다. 죄송합니다.</p>

										</div>
									</div>
								</li>
								<ol class="children">
									<li class="comment even depth-5" id="comment-120">
										<div id="div-comment-120" class="comment-body">
											<div class="comment">
												<b class="vm-infoBoardDetail__fn">홀리데이</b>
												<div class="comment-date">
													<a>February 23, 2017 at 3:29 am </a>
												
													<a rel='nofollow' class='btn btn-xs comment-reply'
														href='#comment-120'
														onclick='return addComment.moveForm( "div-comment-120", "120", "respond", "155" )'
														aria-label='Reply to laranz'>답글</a></div>

												<p>어떤 색이 맛있나요? 궁금쓰해여😉</p>

											</div>
										</div>
									</li>
									<ol class="children">
										<li class="comment even depth-5" id="comment-128">
											<div id="div-comment-128" class="comment-body">
												<div class="comment">
													<b class="vm-infoBoardDetail__fn">익명1</b>
													<div class="comment-date">
														<a>March 9, 2017 at 4:16 am </a>
													</div>

													<p>빨간색이 무난하죠 😛</p>

												</div>
											</div>
										</li>
										</li>
										<!-- #comment-## -->
										<li class="comment odd alt depth-5" id="comment-138">
											<div id="div-comment-138" class="comment-body">
												<div class="comment">
													<b class="vm-infoBoardDetail__fn">허니콤보</b>
													<div class="comment-date">
														<a>March 30, 2017 at 10:42 am </a>
													</div>

													<p>검정색도 괜찮아요. 포장지 제대로 안 보고 넣었다가 조금 나와서 고장난 줄 알고 순간 식겁했는데ㅠ 따흑 보니까 에스프레소였습니다^^ 네, 한 개 더 뜯었습니다. 그리고 더이상 궁물 안 합니다. </p>

												</div>
											</div>
										</li>
										</li>
										<li class="comment even depth-5" id="comment-8810">
											<div id="div-comment-8810" class="comment-body">
												<div class="comment">
													<b class="vm-infoBoardDetail__fn">tㅔ슷흐</b>
													<div class="comment-date">
														<a>March 9, 2017 at 4:16 am </a>
													</div>

													<p>클래는 even과 odd만 지켜주면 되는걸까 연속으로 even이라고 쓰면 어떻게 될 것인가. 하지만 실험하기에는 너무나 귗낳다. </p>

												</div>
											</div>
										</li>
										</li>
										<li class="comment even depth-5" id="comment-010">
											<div id="div-comment-010" class="comment-body">
												<div class="comment">
													<b class="vm-infoBoardDetail__fn">tㅔ슷흐</b>
													<div class="comment-date">
														<a>March 9, 2017 at 4:16 am </a>
													</div>

													<p>클래는 even과 odd만 지켜주면 되는걸까 연속으로 even이라고 쓰면 어떻게 될 것인가. 하지만 실험하기에는 너무나 귗낳다. 걍 위에것 붙여넣었는데 even인데도  숫자 4가 붙음 걍 li로 되나 아디만 다르면 되나 </p>

												</div>
											</div>
										</li>
										</li>
										<!-- #comment-## -->
									</ol>
									<!-- .children -->
									</li>
									<!-- #comment-## -->
								</ol>
								<!-- .children -->
								</li>
								<!-- #comment-## -->
								<li class="comment even depth-3" id="comment-168">
									<div id="div-comment-168" class="comment-body">
										<div class="comment">
											<b class="vm-infoBoardDetail__fn">따흑</b>
											<div class="comment-date">
												<a> May 23, 2017 at 7:30 pm </a>
											
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-168'
												onclick='return addComment.moveForm( "div-comment-168", "168", "respond", "155" )'
												aria-label='Reply to gda'>답글</a></div>

											<p>저도 엊그제 배송 왔는데 물이 아예 안 나와여,,, 어떻게 해야할까요ㅠㅠㅠㅠ고장인 걸까요</p>

										</div>
									</div>
								</li>
								</li>
								<!-- #comment-## -->
							</ol>
							<!-- .children -->
							</li>
							<!-- #comment-## -->
							<li class="comment odd alt depth-2" id="comment-278">
								<div id="div-comment-278" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">지니</b>
										<div class="comment-date">
											<a>September 17, 2017 at 9:38 am </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-278'
												onclick='return addComment.moveForm( "div-comment-278", "278", "respond", "155" )'
												aria-label='Reply to god'>답글</a></div>

										<p>세척하고 작동해야 하는 거 이제 알았네요.. 저는 그냥 먹었는데 죽진 않았습니다. </p>

									</div>
								</div>
							</li>
							</li>
							
							<li class="comment even alt depth-2" id="comment-6909">
								<div id="div-comment-6909" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">테스트</b>
										<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
										<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
										<div class="comment-date">
											<a>September 17, 2017 at 9:38 am </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-6909'
												onclick='return addComment.moveForm( "div-comment-6909", "6909", "respond", "155" )'
												aria-label='Reply to god'>답글</a></div>

										<p>테스트입니다. 될까욤 </p>

									</div>
								</div>
							</li>
							</li>
							
							
							
							
							
							<!-- #comment-## -->
						</ol>
						<!-- .children -->
						</li>
						<hr>
						<!-- #comment-## -->
						<li class="comment even thread-odd thread-alt depth-1 parent"
							id="comment-56">
							<div id="div-comment-56" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">나태지옥 일등석</b>
									<div class="comment-date">
										<a> July 31, 2016 at 10:53 pm </a>
									
										<a rel='nofollow' class='btn btn-xs comment-reply'
											href='#comment-56'
											onclick='return addComment.moveForm( "div-comment-56", "56", "respond", "155" )'
											aria-label='Reply to Billy Bogus'>답글</a></div>

									<p>고해성사를 합니다. 주말동안 아무것도 하지 않았고,, 뒤늦게 이렇게 하게 되었는데 아무래도 이 페이지를 날릴 것같은 불길한 예감이 듭니다. 불길한 예감은 언제나 틀리 지 않습니다. 하지만 괜찮아요,, 사후세계가 있다면 나태지옥에 이미 티켓이 준비되어 있을것같습니다. 하지만 저는 거기에서도 나태할 거예요. 하지만 내 흔적을 남길거얌 룰루</p>

								</div>
							</div>
						</li>
						<ol class="children">
							<li class="comment odd alt depth-2" id="comment-336">
								<div id="div-comment-336" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">레이지</b>
										<div class="comment-date">
											<a>December 13, 2017 at 9:24 am </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-336'
												onclick='return addComment.moveForm( "div-comment-336", "336", "respond", "155" )'
												aria-label='Reply to Claude Michaud'>답글</a></div>

										<p>이럴 시간에 잠을 자는 게 나을 텐데,, 따흑이다진짜  아무것도 하고싶지않아서 이러고있다. 오늘 무조건 재활용 버린다. 자식 댓글 하나 더 맨두러 볼까 될까,,,^^ </p>

									</div>
								</div>
							</li>
							</li>
							<!-- #comment-## -->
						</ol>
						<!-- .children -->
						</li>
						<hr>
						<!-- #comment-## -->
						<li class="comment even thread-even depth-1" id="comment-106">
							<div id="div-comment-106" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">온누리약국</b>
									<div class="comment-date">
										<a>January 11, 2017 at 12:42 pm </a>
									
										<a rel='nofollow' class='btn btn-xs comment-reply'
											href='#comment-106'
											onclick='return addComment.moveForm( "div-comment-106", "106", "respond", "155" )'
											aria-label='Reply to adict'>답글</a></div>

									<p>치킨과 피자 나는 무조건 피자. 피자가 좋아. 피자는,,,,,,,,, 뼈가 없잖아</p>

								</div>
							</div>
						</li>
						</li>
						<hr>
						<!-- #comment-## -->
						<li class="comment odd alt thread-odd thread-alt depth-1"
							id="comment-145">
							<div id="div-comment-145" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">닉넴뭐하지</b>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">수정</a>
									<a rel='nofollow' class='btn btn-xs comment-reply'  onclick="location.href='?no='">삭제</a>
									<div class="comment-date">
										<a>April 15, 2017 at 7:35 am </a>
									
										<a rel='nofollow' class='btn btn-xs comment-reply'
											href='#comment-145'
											onclick='return addComment.moveForm( "div-comment-145", "145", "respond", "155" )'
											aria-label='Reply to IanC'>답글</a></div>

									<p>작년 이맘때에 굉장히 행복했던 기억이 난다. 근데 피곤도 했지 사실 피곤하지 않은 날은 죽을 때까지 없을 것같다. 생각해보니 여행 다닐때만 유일하게 부지런 한 것같음. 그래서 집이 좋아 </p>

								</div>
							</div>
						</li>
						</li>
						<hr>
						<!-- #comment-## -->
						<li
							class="comment byuser comment-author-staygoldsp even thread-even depth-1"
							id="comment-188">
							<div id="div-comment-188" class="comment-body">
								<div class="comment">
									<b class="vm-infoBoardDetail__fn">코코이빈후과</b>
									<div class="comment-date">
										<a> June 28, 2017 at 11:41 am </a>
									
										<a rel='nofollow' class='btn btn-xs comment-reply'
											href='#comment-188'
											onclick='return addComment.moveForm( "div-comment-188", "188", "respond", "155" )'
											aria-label='Reply to staygoldsp'>답글</a></div>

									<p>올 해는 이상하게 감기기운 만 있고 감기에 걸리지 않은 것같다. 아파본 적도 없는 것같고,, 신기함. 근데 올해 신년사주에 병치레 없이 지나간다고 했었음. 역시 사주는 통계학일까. 부모님께 이상하게 안 아프고 있다고 말 하면 말이 씨가 된다며 그런 말 하지 말라고 하는데 신기한 걸요 껄껄.. 그러고 보니 동물도 사주가 있을깤ㅋㅋㅋㅋㅋㅋㅋㅋ뜬금쓰 </p>

								</div>
							</div>
						</li>
						</li>
						<ol class="children">
							<li class="comment odd alt depth-2" id="comment-2121">
								<div id="div-comment-2121" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">레이지</b>
										<div class="comment-date">
											<a>December 13, 2017 at 9:24 am </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-336'
												onclick='return addComment.moveForm( "div-comment-2121", "2121", "respond", "155" )'
												aria-label='Reply to Claude Michaud'>답글</a></div>

										<p>클래스 이름은 뭔가 노상관인것같다. odd와 even의 끔찍한 혼종의 댓글판이다. even짝수인데 1이 왜 짝수인가 0부터 시작되는건가. id만 다르면,, 될것같음 aria label은 뭔가. 따흑 여기에 블로그 하나 개설한둡 아무도 읽지 말아주세요. 결론은 아이디가 중요한것같다. </p>

									</div>
								</div>
							</li>
							</li>
							<li class="comment odd alt depth-2" id="comment-13131">
								<div id="div-comment-13131" class="comment-body">
									<div class="comment">
										<b class="vm-infoBoardDetail__fn">레이지</b>
										<div class="comment-date">
											<a>December 13, 2017 at 9:24 am </a>
										
											<a rel='nofollow' class='btn btn-xs comment-reply'
												href='#comment-336'
												onclick='return addComment.moveForm( "div-comment-13131", "13131", "respond", "155" )'
												aria-label='Reply to Claude Michaud'>답글</a></div>

										<p>왜 선생님은 월욜날 수업을 하시는 걸까,, 그렇지 ㅇ낳았다면 나또한 휴가를 썼을텐데,, 나는 힘이 없다. 수업을 하니까 가야겠지,,, 휴가,,,,,,,,,,,못 써보고 수료하는 거 아닌가</p>

									</div>
								</div>
							</li>
							</li>
							<!-- #comment-## -->
						</ol>
						</li>
						<hr>
						<!-- #comment-## -->
					</ul>
					<!-- .comment-list -->


					<!-- <div id="respond" class="comment-respond">
						<h3 id="reply-title" class="comment-reply-title">댓글 달기
							<small>
								<a rel="nofollow" id="cancel-comment-reply-link" href="/shapely/about/page-with-comments/#respond" style="display: none; font-size: 15px;">취소</a>
							</small> 
						</h3>
						
						
						<form action="" method="post" id="commentform" class="comment-form" novalidate>
							
							<textarea placeholder="인터넷은 우리가 함께 만들어가는 소중한 공간입니다.&#10;댓글 작성 시 타인에 대한 배려와 책임을 담아주세요.&#10;" id="comment" name="comment" cols="45" rows="8" aria-required="true" required="required"></textarea>
							
							<p class="form-submit">
								<input name="submit" type="submit" id="submit" class="submit" value="등록"/> 
								<input type='hidden' name='comment_post_ID' value='155' id='comment_post_ID' />
								<input type='hidden' name='comment_parent' id='comment_parent' value='0' />
								<br>
							</p>
							
							<p style="display: none;">
								<input type="hidden" id="akismet_comment_nonce" name="akismet_comment_nonce" value="ea25e3c9b9" />
							</p>
							
							<p style="display: none;">
								<input type="hidden" id="ak_js" name="ak_js" value="216" />
							</p>
						</form>
					</div>  -->
					<!-- #respond -->

				</div>
				<!-- #comments -->
			</div>
			<!-- #primary -->


			
			<!-- #secondary -->
		</div>
				
				
				
				
				
				
				</div>
				</div>
				</div>
				</div>
				

</html>
