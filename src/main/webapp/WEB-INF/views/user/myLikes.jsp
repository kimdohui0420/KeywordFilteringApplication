<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<%@include file="../include/head.jsp"%>

<body class="sb-nav-fixed">
<%@include file="../include/main_header.jsp"%>
<div id="layoutSidenav">

    <%@include file="../include/left_column.jsp"%>

    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid">
                <div class="ResultWrapper">
                    <!-- 결과 갯수, 정렬 버튼 -->
                    <header class="ResultHeader">
                        <div class="ResultCounter">
                            <span class="ResultCounter_Number">${likes.size()}</span> 건의 작품이 있습니다.
                        </div>
                        <div class="tab">
                            <label class="switch" id="Latest">
                                <input type="radio" name="filter" checked="">
                                <span class="slider">최신순</span>
                            </label>
                            <label class="switch" id="imdb_rating">
                                <input type="radio" name="filter">
                                <span class="slider">imdb 평점순</span>
                            </label>
                            <label class="switch" id="self_rating">
                                <input type="radio" name="filter">
                                <span class="slider">자체 평점순</span>
                            </label>
                            <label class="switch" id="Most_reviews">
                                <input type="radio" name="filter">
                                <span class="slider">리뷰 많은순</span>
                            </label>
                        </div>
                    </header>
                    <!-- 내 좋아요 리스트 -->
                    <div class="resultLists">
                        <!-- TODO: 페이징-->
                        <c:forEach items="${likes}" var="like">
                        <div class="movie_card" id="${like.contentId}">
                            <div class="action-likes">
                                <input type="checkbox" id="like-checkbox" checked/>
                                <label for="like-checkbox">
                                    <svg id="heart-svg" class="likes-svg" viewBox="467 392 58 57" xmlns="http://www.w3.org/2000/svg">
                                        <g id="Group" fill="none" fill-rule="evenodd" transform="translate(467 392)">
                                            <path d="M29.144 20.773c-.063-.13-4.227-8.67-11.44-2.59C7.63 28.795 28.94 43.256 29.143 43.394c.204-.138 21.513-14.6 11.44-25.213-7.214-6.08-11.377 2.46-11.44 2.59z" id="heart" fill="#AAB8C2"/>
                                            <circle id="main-circ" fill="#E2264D" opacity="0" cx="29.5" cy="29.5" r="1.5"/>

                                            <g id="grp7" opacity="0" transform="translate(7 6)">
                                                <circle id="oval1" fill="#9CD8C3" cx="2" cy="6" r="2"/>
                                                <circle id="oval2" fill="#8CE8C3" cx="5" cy="2" r="2"/>
                                            </g>

                                            <g id="grp6" opacity="0" transform="translate(0 28)">
                                                <circle id="oval1" fill="#CC8EF5" cx="2" cy="7" r="2"/>
                                                <circle id="oval2" fill="#91D2FA" cx="3" cy="2" r="2"/>
                                            </g>

                                            <g id="grp3" opacity="0" transform="translate(52 28)">
                                                <circle id="oval2" fill="#9CD8C3" cx="2" cy="7" r="2"/>
                                                <circle id="oval1" fill="#8CE8C3" cx="4" cy="2" r="2"/>
                                            </g>

                                            <g id="grp2" opacity="0" transform="translate(44 6)">
                                                <circle id="oval2" fill="#CC8EF5" cx="5" cy="6" r="2"/>
                                                <circle id="oval1" fill="#CC8EF5" cx="2" cy="2" r="2"/>
                                            </g>

                                            <g id="grp5" opacity="0" transform="translate(14 50)">
                                                <circle id="oval1" fill="#91D2FA" cx="6" cy="5" r="2"/>
                                                <circle id="oval2" fill="#91D2FA" cx="2" cy="2" r="2"/>
                                            </g>

                                            <g id="grp4" opacity="0" transform="translate(35 50)">
                                                <circle id="oval1" fill="#F48EA7" cx="6" cy="5" r="2"/>
                                                <circle id="oval2" fill="#F48EA7" cx="2" cy="2" r="2"/>
                                            </g>

                                            <g id="grp1" opacity="0" transform="translate(24)">
                                                <circle id="oval1" fill="#9FC7FA" cx="2.5" cy="3" r="2"/>
                                                <circle id="oval2" fill="#9FC7FA" cx="7.5" cy="2" r="2"/>
                                            </g>
                                        </g>
                                    </svg>
                                </label>
                            </div>
                            <div class="info_section">
                                <div class="movie_header">
                                    <img class="locandina" src="https://occ-0-2568-2567.1.nflxso.net/art/5f5cb/3d5923c65399954d27493f553900df9daea5f5cb.jpg"/>
                                    <h1>${like.title}</h1>
                                    <h4 style="display: inline-block">${like.year}, ${like.director}</h4>
                                    <div style="display: block">
                                        <span class="boxinfo">${like.runtime} min</span>
                                        <span class="boxinfo">${like.rated}</span>
                                        <div class="star-ratings-sprite"><span style="width:60%" class="star-ratings-sprite-rating"></span></div>
                                        <div class="main_awards">
                                            <div class="awards_icon"><i class="fas fa-medal"></i></div>
                                                ${like.awardWin}
                                            <div class="awards_icon"><i class="fas fa-award"></i></div>
                                                ${like.awardNominate}
                                            <div class="awards_icon"><i class="fas fa-trophy"></i></div>
                                                ${like.awardMajor} ${like.awardMajorType}
                                        </div>
                                    </div>
                                </div>
                                <div class="movie_desc">
                                    <p class="text">
                                        ${like.plot}
                                    </p>
                                </div>
                                <div class="movie_genre">
                                    <ul>
                                        <li><i>#fantasy</i></li>
                                        <li><i>#fantasy</i></li>
                                        <li><i>#fantasy</i></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="blur_back bright_back"></div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../include/main_footer.jsp"%>
    </div>
</div>

<%@ include file="../include/plugin_js.jsp"%>
<script>
    var userId = "${login.userId}";

    $(document).on("click",".info_section",function(){
        var contentId = $(this).parent().attr('id');
        var link =  '/read?contentId=' + contentId;
        $(location).attr('href',link);
    });
</script>
</body>
</html>
