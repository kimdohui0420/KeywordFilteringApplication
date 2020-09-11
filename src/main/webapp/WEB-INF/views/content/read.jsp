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
                <div class="comment-wrap">
                    <div class="photo">
                        <div class="avatar" style="background-image: url('https://s3.amazonaws.com/uifaces/faces/twitter/dancounsell/128.jpg')"></div>
                    </div>
                    <div class="comment-block">
                            <form action="">
                                <textarea id="newReviewText" cols="30" rows="3" placeholder="Add comment..."></textarea>
                                <input id="newReviewWriter" type="text" value="${login.userId}" readonly hidden>
                                <div class="bottom-comment">
                                    <ul class="comment-actions">
                                        <li class="reply reviewAddBtn">Reply</li>
                                    </ul>
                                </div>
                            </form>
                    </div>
                </div>

                <div class="commentList">
                    <!--div class="comment-wrap">
                        <div class="photo">
                            <div class="avatar" style="background-image: url('https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg')"></div>
                        </div>
                        <div class="comment-block">
                            <p class="comment-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto temporibus iste nostrum dolorem natus recusandae incidunt voluptatum. Eligendi voluptatum ducimus architecto tempore, quaerat explicabo veniam fuga corporis totam reprehenderit quasi
                                sapiente modi tempora at perspiciatis mollitia, dolores voluptate. Cumque, corrupti?</p>
                            <div class="bottom-comment">
                                <div class="comment-date">Aug 24, 2014 @ 2:35 PM</div>
                                <ul class="comment-actions">
                                    <li class="complain">Complain</li>
                                    <li class="reply">Reply</li>
                                </ul>
                            </div>
                        </div>
                    </div-->
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
            <!-- [12-2] 댓글 수정 modal --><!--
            <div class="modal fade" id="modModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="model-header">
                            <button type="button" class="close" date-dimiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">댓글 수정</h4>
                        </div>
                        <div class="modal-body" data-rno>
                            <input type="hidden" class="replyNo" />
                            <%-- <input type="text" id="replytext" class="form-control" /> --%>
                            <textarea class="form-control" id="replyText" rows="3" style="resize: none"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left exitModBtn" date-dimiss="modal">닫기</button>
                            <button type="button" class="btn btn-primary modalModBtn">수정</button>
                        </div>
                    </div>
                </div>
            </div>-->
            <!-- [12-2] 댓글 삭제 modal --><!--
            <div class="modal fade" id="delModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" date-dimiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">댓글 삭제</h4>
                            <input type="hidden" class="rno" />
                        </div>
                        <div class="modal-body" data-rno>
                            <p>댓글을 삭제하겠습니까?</p>
                            <input type="hidden" class="rno" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left exitDelBtn" date-dimiss="modal">아니요</button>
                            <button type="button" class="btn btn-primary modalDelBtn">네. 삭제!</button>
                        </div>
                    </div>
                </div>
            </div>-->
        </main>
        <%@include file="../include/main_footer.jsp"%>
    </div>
</div>

<%@ include file="../include/plugin_js.jsp"%>
<script>
    $(document).ready(function () {

        var contentId = "${content.contentId}";
        console.log('contentId is '+contentId);

        // 리뷰 목록 출력
        commentList();
        function commentList(){
            $.ajax({
                type: "get",
                url: "/reviews/all/"+contentId,
                data: {
                    contentId: contentId
                },
                success: function(result){
                    var eachReview ='';
                    $.each(result, function(key, value){
                        var formattedTime = new Date(value.regDate).toISOString().slice(0, 19).replace('T', ' ');

                        // TODO: 리뷰 목록에서 작성자 이미지 불러오기 해야 함
                        eachReview += '<div class="comment-wrap"><div class="photo"><div class="avatar"></div><div class="writer">'+value.reviewWriter+'</div></div>';
                        eachReview += '<div class="comment-block"><p class="comment-text">'+value.reviewText+'</p>';
                        eachReview += '<div class="bottom-comment"><div class="comment-date">'+formattedTime+'</div>';
                        if("${login.userName}"===value.reviewWriter) {
                            eachReview += '<ul class="comment-actions"><li class="complain">Complain</li><li class="reply">Reply</li></ul>';
                        }
                        eachReview += '</div> </div> </div>';
                    });

                    $(".commentList").html(eachReview);
                }
            });
        }



        // 리뷰 등록 처리
        $(".reviewAddBtn").on("click", function () {
            if (${empty login}){
                alert("로그인시에만 리뷰 작성이 가능합니다.");
                return;
            }

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
                success: function(result){
                    console.log("result: " +result);
                    if(result=="regSuccess"){
                        alert("리뷰가 등록되었습니다.");
                        commentList();

                        reviewTextObj.val("");   // 댓글 내용 초기화
                    }
                }
            });
        });


    });
</script>
</body>
</html>
