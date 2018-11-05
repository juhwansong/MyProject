<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/views/common/top.jsp" />

<link rel="stylesheet" href="/resources/each/css/searchAll.css?${verQuery}" />

<%-- -------- JSP -------- --%>
<div class="vm-container">
	<div class="vm-content vm-searchAll">
		<div class="vm-section">
			<div class="vui-headline">통합검색</div>

			<div class="vm-searchAll__section">
				<div class="vm-searchAll__header">
					<strong>${param.keyword}</strong> 검색결과
				</div>

				<div class="vm-searchAll__result">

					<c:forEach var="board" items="${boardList}" varStatus="boardStatus">
						<div class="vm-searchAll__block">
							<div class="vm-searchAll__block__inner">
								<div class="vm-searchAll__board-type">
									<i class="ni ni-bullet-list-67"></i>
									<div class="vm-searchAll__board-type__text">
										<c:choose>
											<c:when test="${ board.key == 'channelList' 			}">채널리스트</c:when>
											<c:when test="${ board.key == 'freeBoardList' 			}">자유게시판</c:when>
											<c:when test="${ board.key == 'volunteerApplyList' 		}">자원봉사</c:when>
											<c:when test="${ board.key == 'volunteerEpilogueList' 	}">봉사후기</c:when>
										</c:choose>
									</div>
								</div>

								<div class="vm-searchAll__list">
									<c:choose>
										<c:when test="${ board.value.size() > 0 }">
											<c:forEach var="item" items="${board.value}" varStatus="status">
												<c:choose>
													<c:when test="${ board.key == 'channelList' 			}">
														<c:set var="boardUrl" value="/ChannelDetail?no=${item.no}" />
													</c:when>
													<c:when test="${ board.key == 'freeBoardList' 			}">
														<c:set var="boardUrl" value="/FreeBoardDetail?no=${item.no}" />
													</c:when>
													<c:when test="${ board.key == 'volunteerApplyList' 		}">
														<c:set var="boardUrl" value="/VolunteerApplyDetail?volunteer_date=${item.volunteer_date}" />
													</c:when>
													<c:when test="${ board.key == 'volunteerEpilogueList' 	}">
														<c:set var="boardUrl" value="/VolunteerEpilogueDetail?no=${item.no}" />
													</c:when>
												</c:choose>

												<a class="vm-searchAll__item" href="${boardUrl}">
													<div class="vm-searchAll__item__head vm-flex-row">
														<div class="vm-searchAll__board-title">
															<i class="fa fa-envelope-open-o" aria-hidden="true"></i>
															<span class="vm-searchAll__board-title__text vm-ellipsis">${item.title}</span>
														</div>
														<div class="vm-searchAll__board-date">
															<i class="fa fa-calendar" aria-hidden="true"></i>
															<span class="vm-searchAll__board-date__text">${item.write_date}</span>
														</div>
													</div>

													<div class="vm-searchAll__item__body">
														<div class="vm-searchAll__board-content">${item.content}</div>
													</div>
												</a>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<div class="vm-searchAll__no-data">
												<i class="fa fa-info" aria-hidden="true"></i>
												<span class="vm-searchAll__no-data__text">일치하는 게시글이 없습니다.</span>
											</div>
										</c:otherwise>
									</c:choose>

								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
		</div>
	</div>
</div>
<%-- -------- //JSP -------- --%>

<c:import url="/WEB-INF/views/common/bottom.jsp" />

<%-- -------- JavaScript -------- --%>
<script src="/resources/each/js/searchAll.js?${verQuery}"></script>
<%-- -------- //JavaScript -------- --%>