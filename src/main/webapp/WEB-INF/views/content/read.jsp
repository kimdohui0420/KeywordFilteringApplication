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
            <div class="movie-card">

                <div class="containerMC">

                    <a href="#"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/195612/hobbit_cover.jpg" alt="cover" class="cover" /></a>

                    <div class="hero">

                        <div class="details">

                            <div class="title1">${content.title} (${content.year}) <span>${content.rated}</span></div>

                            <!-- TODO: 평점, like, 처리 -->
                            <fieldset class="rating">
                                <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
                                <input type="radio" id="star4half" name="rating" value="4 and a half" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
                                <input type="radio" id="star4" name="rating" value="4" checked /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
                                <input type="radio" id="star3half" name="rating" value="3 and a half" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
                                <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
                                <input type="radio" id="star2half" name="rating" value="2 and a half" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
                                <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
                                <input type="radio" id="star1half" name="rating" value="1 and a half" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
                                <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
                                <input type="radio" id="starhalf" name="rating" value="half" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
                            </fieldset>

                            <span class="likes">109 likes</span>

                        </div> <!-- end details -->

                    </div> <!-- end hero -->

                    <div class="description">

                        <div class="column1">
                            <span class="tag">action</span>
                            <span class="tag">fantasy</span>
                            <span class="tag">adventure</span>
                        </div>

                        <div class="column2">
                            Director: ${content.director}<br/>
                            Actors: ${content.actor}
                        </div>
                        <div class="column2">
                            ${content.plot}
                        </div>
                        <div class="column2 awards">
                            <c:if test="${not empty content.awardWin && content.awardWin ne 0}">
                                ${content.awardWin} <c:if test="${content.awardWin eq 1}">win</c:if><c:if test="${content.awardWin ne 1}">wins</c:if>
                            </c:if>
                            <c:if test="${not empty content.awardNominate && content.awardNominate ne 0}">
                            <img class="nomination" src="/dist/assets/img/nominated.png"/>
                            ${content.awardNominate} nominated
                            </c:if>
                            <c:if test="${!empty content.awardMajor}">
                            ${content.awardMajor}
                            ${content.awardMajorType}
                            </c:if>
                        </div>
                    </div> <!-- end description -->

                </div> <!-- end container -->
            </div> <!-- end movie-card -->

            <!-- 리뷰 작성 -->
            <div class="comments">
                <!-- TODO: 리뷰 페이징-->
                <div class="comment-menu commentMenu">
                    <%--${content.reviewCnt}개의 Review--%>
                </div>
                <!-- 내 리뷰 상단 고정 -->
                <div class="comment-wrap myComment">
                </div>
                <!-- 리뷰 목록 -->
                <div class="commentList">
                </div>
            </div>
            <!-- [12-2] 댓글 목록/페이징 --><!--
            <div class="box box-success collapsed-box">
                <div class="box-header with-border">
                    <%--댓글 유무 / 댓글 갯수 / 댓글 펼치기,접기--%>
                    <a href="" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i> </a>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <%--댓글 목록--%>
                <div class="box-body repliesDiv">

                </div>
                <%--댓글 페이징--%>
                <div class="box-footer">
                    <div class="text-center">
                        <ul class="pagination pagination-sm no-margin">

                        </ul>
                    </div>
                </div>
            </div>-->
        </main>
        <%@include file="../include/main_footer.jsp"%>
    </div>
</div>

<%@ include file="../include/plugin_js.jsp"%>
<script>
    var contentId = "${content.contentId}";
    var mine = false;

    function myComment() {
        if(${empty login}){
            mine = false;
            var myReviewDiv = '';
            myReviewDiv += '<div class="photo"><div class="avatar"></div></div>';
            myReviewDiv += '<div class="comment-block"><p class="comment-text">리뷰를 남기려면 로그인이 필요합니다.</p></div>';
            $(".myComment").html(myReviewDiv);
            return;
        }

        $.ajax({
            type: "get",
            url: "/reviews/mine",
            data: {
                contentId: contentId,
                userName: "${login.userName}"
            },
            success: function (result) {
                var myReviewDiv = '';
                if(!result){
                    mine = false;
                    myReviewDiv += '<div class="photo"><div class="avatar"></div></div>';
                    myReviewDiv += '<div class="comment-block"><form action="">';
                    myReviewDiv += '<textarea id="newReviewText" cols="30" rows="3" placeholder="Add review..."></textarea>';
                    myReviewDiv += '<input id="newReviewWriter" type="text" value="${login.userId}" readonly hidden>';
                    myReviewDiv += '<div class="bottom-comment"><ul class="comment-actions">';
                    myReviewDiv += '<li class="comment-delete" onclick="commentAdd();">Reply</li>';
                    myReviewDiv += '</ul></div></form></div>';
                }
                else{
                    mine = true;
                    var formattedTime, dateStr='';
                    if(result.updateDate!==result.regDate){
                        formattedTime = new Date(result.updateDate).toISOString().slice(0, 19).replace('T', ' ');
                        dateStr = '(수정됨)';
                    }
                    var formattedTime = new Date(result.updateDate).toISOString().slice(0, 19).replace('T', ' ');

                    myReviewDiv += '<div class="photo"><div class="avatar"></div><div class="writer">'+result.reviewWriter+'</div></div>';
                    myReviewDiv += '<div class="comment-block commentContent'+result.reviewNo+'"><p class="comment-text">'+result.reviewText+'</p>';
                    myReviewDiv += '<div class="bottom-comment"><div class="comment-date">'+formattedTime+dateStr+'</div>';
                    if("${login.userName}"===result.reviewWriter) {
                        myReviewDiv += '<ul class="comment-actions">';
                        myReviewDiv += '<li class="comment-modify" onclick="commentUpdate('+result.reviewNo+',\''+result.reviewText+'\');return false;"> 수정 </li>';
                        myReviewDiv += '<li class="comment-delete" onclick="commentDelete('+result.reviewNo+');"> 삭제</li></ul>';
                    }
                    myReviewDiv += '</div> </div>';
                }
                $(".myComment").html(myReviewDiv);
            }
        });
    }

    function commentList(){
        $.ajax({
            type: "get",
            url: "/reviews/all",
            data: {
                contentId: contentId,
                userName: "${login.userName}"
            },
            success: function(result){
                var reviewNum = mine?result.length+1:result.length;
                $(".commentMenu").html(reviewNum+'개의 Review');

                var eachReview ='';
                $.each(result, function(key, value){
                    var formattedTime, dateStr='';
                    if(value.updateDate!==value.regDate){
                        formattedTime = new Date(value.updateDate).toISOString().slice(0, 19).replace('T', ' ');
                        dateStr = '(수정됨)';
                    }
                    formattedTime = new Date(value.regDate).toISOString().slice(0, 19).replace('T', ' ');

                    // TODO: 리뷰 목록에서 작성자 이미지 불러오기 해야 함
                    eachReview += '<div class="comment-wrap"><div class="photo"><div class="avatar"></div><div class="writer">'+value.reviewWriter+'</div></div>';
                    eachReview += '<div class="comment-block commentContent'+value.reviewNo+'"><p class="comment-text">'+value.reviewText+'</p>';
                    eachReview += '<div class="bottom-comment"><div class="comment-date">'+formattedTime+dateStr+'</div></div> </div> </div>';
                });

                $(".commentList").html(eachReview);
            }
        });
    }

    // 리뷰 등록 처리
    function commentAdd(text) {
        var reviewWriterObj = $("#newReviewWriter");
        var reviewTextObj = $("#newReviewText");
        var reviewWriter = reviewWriterObj.val();
        var reviewText = reviewTextObj.val();

        $.ajax({
            type: "post",
            url: "/reviews/",
            headers: {
                "Content-type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                contentId: contentId,
                reviewText: reviewText,
                reviewWriter: reviewWriter
            }),
            success: function (result) {
                if (result == "regSuccess") {
                    alert("리뷰가 등록되었습니다.");
                    myComment()
                    commentList();
                }
            }
        });
    }

    // 리뷰 수정 버튼 누름
    function commentUpdate(no, text){
        var modifyForm = '';
        modifyForm += '<textarea type="text" name="content_'+no+'">'+text+'</textarea>';
        modifyForm += '<div class="bottom-comment"><ul class="comment-actions">';
        modifyForm += '<li class="comment-modify"><a onclick="commentUpdateProc('+no+');return false;">수정완료</a></li>';
        modifyForm += '</ul></div>';

        $('.commentContent'+no).html(modifyForm);
    }

    // 리뷰 수정 처리
    function commentUpdateProc(no){
        var updateContent = $('[name=content_'+no+']').val();
        $.ajax({
            type: 'put',
            url: '/reviews/'+ no,
            headers: {
                "Content-type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                reviewText: updateContent
            }),
            success: function(result){
                if(result=="modSuccess"){
                    alert("리뷰가 수정되었습니다.");
                    myComment();
                    commentList();
                }
            }
        });
    }

    // 리뷰 삭제
    function commentDelete(no){
        $.ajax({
            type: 'delete',
            url: '/reviews/'+no,
            success: function(result){
                if(result=="delSuccess"){
                    alert("댓글이 삭제되었습니다.");
                    myComment();
                    commentList();
                }
            }
        });
    }

    $(document).ready(function () {
        myComment();
        commentList();
    });
</script>
</body>
</html>
