<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.vm-footer { padding: 20px 0; }
.vm-footer a {
	color : #555;
}

.vm-footer ul {
	padding-left : 0;
}

.vm-footer li {
	display : inline;
	border-left : 1px solid #999;
	font : bold .8rem Dotum;
	padding : 0 10px; 
}

.vm-footer li:first-child{
	border-left : none;
	padding-left : 0;
}

.vm-footer p:not(.vm-footer__donation-title) {
	font : bold .7rem Dotum;
	color : #999;
	margin-bottom : .5rem;
}

.vm-footer__donation-title {
	font : bold .8rem Dotum;
	color : #555;
	margin-bottom : 1.8rem;
}

.vm-footer__div-donation {
	position: absolute;
	right: 22rem;
	bottom: -.8rem;
}


.vm-footer__img-icon {
	width : 23px;
	margin : 0 8px 0 8px;
	opacity: .7;
}

.vm-footer__img-icon2 {	/*유튜브 이미지 잘못 잘라서 따로*/
	width : 30px;
	margin : 0 8px 0 8px;
	opacity: .7;
}

.vm-footer__div-outside {
	position: relative;
	width: 100%;
}

.vm-footer__div-icon-list {
	position: absolute;
	right: .5rem;
	bottom: 5.5rem;
}

.vm-footer__select-box {
	height : 25px;
	font-size:.8rem;
	width: 100px;
}

</style>

<div class="vm-footer">

	<%-- <div class="vm-container"> --%>
		<%-- <div class="vm-content">			 --%>
			<div class="vm-section">
			
			
				<div class="vm-footer__div-outside">
					<ul>
		                <li><a href="javascript:void(0);" target="_blank">사이트소개</a></li>
		                <li><a href="javascript:void(0);" target="_blank">이용약관</a></li>
		                <li><a href="javascript:void(0);" target="_blank">개인정보처리방침</a></li>
		                <li><a href="javascript:void(0);" title="준비중" target="_blank">고객센터</a></li>
		                <li>
		                    <select class="vm-footer__select-box" onchange="window.open(value,'_self');">
		                        <option value="">Site Map</option>
		                        <option value="/ChannelList">채널</option>
		                        <option value="/Streaming">LIVE</option>
		                        <option value="/Lab">연구소</option>
		                        <option value="/VolunteerApplyList">봉사</option>
		                        <option value="/VolunteerEpilogueList">봉사후기</option>
		                        <option value="/Adoption">입양</option>
		                        <option value="/AdoptionReview">입양후기</option>
		                        <option value="/FreeBoardList">자유</option>
		                        <option value="/NoticeList">공지</option>
		                        <option value="/ProductList">쇼핑몰</option>
		                    </select>
		                </li>
	            	</ul>
		            <br>
		            <p>서울특별시 강남구 강남구 테헤란로14길 6‎ (KH)Viewnimal 대표전화 154X-997X</p> 
		            <p>대표 : 랜선집사 뷰니멀&nbsp;&nbsp;사업자번호 1X1 01 10101X</p>
		            <p>Copyrightⓒ2018 Viewnimal Co., Ltd. All rights reserved.</p>
		            
		            <div class="vm-footer__div-icon-list">
		                <a href="javascript:void(0);"><img src="/resources/common/images/footer/facebook.png" title="준비중" class="vm-footer__img-icon"></a>
		                <a href="javascript:void(0);"><img src="/resources/common/images/footer/instagram.png" title="준비중" class="vm-footer__img-icon"></a>
		                <a href="javascript:void(0);"><img src="/resources/common/images/footer/twitter.png" title="준비중" class="vm-footer__img-icon"></a>
		                <a href="https://www.youtube.com/channel/UCgerhJlU8EWR6HdWbRH1V5A" target="_blank"><img src="/resources/common/images/footer/youtube.png" title="유튜브" class="vm-footer__img-icon2"></a>
		            </div>
	            
		            <div class="vm-footer__div-donation">
						<p class="vm-footer__donation-title">후원계좌</p>
			            <p style="color: #5e72e4;">예금주 : 뷰니멀(Viewnimal)</p>
			            <p>국민은행 : 043937-04-999999</p>
			            <p>기업은행 : 025-075183-04-999</p>
			            <p>농협은행 : 301-0052-1096-99</p>
			            
		            </div>			
				</div>


			</div>
		<%-- </div> --%>
	<%-- </div> --%>
	
</div>