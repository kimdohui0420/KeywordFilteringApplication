<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>

<%@include file="include/head.jsp"%>

<body class="sb-nav-fixed">

<%@include file="include/main_header.jsp"%>

<div id="layoutSidenav">

    <%@include file="include/left_column.jsp"%>

    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid">
                <h1 class="mt-4">디즈니 컨텐츠</h1>
                <div class="mt-4">
                    <div class="card mb-4">
                        <div class="card-header">
                            <div class="row align-middle">
                                <div class="col-lg-auto col-md-auto nopadding">
                                    <h4>
                                        <i class="fas fa-search"></i>
                                        키워드로 검색
                                    </h4>
                                </div>
                                <div class="col-lg-9 col-md-7 nopadding" >
                                    <sub>키워드로 마음에 드는 컨텐츠를 찾아보세요!</sub>
                                </div>
                                <div class="col-lg-auto col-md-auto nopadding">
                                    <button class="btn btn-secondary">전체 해제</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-header">
                            <ul class="nav nav-tabs card-header-tabs" id="bologna-list" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#movie" role="tab" aria-controls="movie" aria-selected="true">Movie</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link"  href="#series" role="tab" aria-controls="series" aria-selected="false">Series / Episode</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>TYPE</h5>
                                    <div id="list-example1" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <c:forEach items="${keywordMaker.totalType}" var="contentType">
                                            <a class="list-group-item list-group-item-action" href="#list-item-1">${contentType}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <h5>GENRE</h5>
                                    <div id="list-example2" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <c:forEach items="${keywordMaker.totalGenre}" var="contentGenre">
                                            <a class="list-group-item list-group-item-action" href="#list-item-1">${contentGenre}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <h5>RATED</h5>
                                    <div id="list-example3" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <c:forEach items="${keywordMaker.totalRated}" var="contentRated">
                                            <a class="list-group-item list-group-item-action" href="#list-item-1">${contentRated}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <h5>RUNNING TIME</h5>
                                    <div id="list-example4" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <a class="list-group-item list-group-item-action" href="#list-item-1">1h 미만</a>
                                        <a class="list-group-item list-group-item-action" href="#list-item-1">1h 이상 2h 미만</a>
                                        <a class="list-group-item list-group-item-action" href="#list-item-1">2h 미만</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="include/main_footer.jsp"%>
    </div>
</div>

<%@ include file="include/plugin_js.jsp"%>
<script>
    $('#bologna-list a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
</script>

</body>
</html>
