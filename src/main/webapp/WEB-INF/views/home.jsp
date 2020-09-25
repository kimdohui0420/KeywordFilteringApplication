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
                            <div class="row">
                                <div class="col-lg-auto col-md-auto">
                                    <h4 style="margin-top: 5px; margin-bottom:0px">
                                        <i class="fas fa-search"></i>
                                        키워드로 검색
                                    </h4>
                                </div>
                                <div class="col" style="padding-top: 8px">
                                    <sub>키워드로 마음에 드는 컨텐츠를 찾아보세요!</sub>
                                </div>
                                <div class="col-lg-auto col-md-auto">
                                    <button class="btn btn-secondary" id="All-off">전체 해제</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <h5>TYPE</h5>
                                    <div id="list-TYPE" class="list-group" style="height: auto;">
                                        <c:forEach items="${keywordMaker.totalType}" var="contentType">
                                            <a class="list-group-item list-group-item-action">${contentType}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <h5>GENRE</h5>
                                    <div id="list-GENRE" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <c:forEach items="${keywordMaker.totalGenre}" var="contentGenre">
                                            <a class="list-group-item list-group-item-action">${contentGenre}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <h5>RATED</h5>
                                    <div id="list-RATED" class="list-group" style="height: 200px; overflow-y: scroll">
                                        <c:forEach items="${keywordMaker.totalRated}" var="contentRated">
                                            <a class="list-group-item list-group-item-action">${contentRated}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <h5>RUNNING TIME</h5>
                                    <div id="list-RTIME" class="list-group" style="height: auto;">
                                        <a class="list-group-item list-group-item-action">1h 미만</a>
                                        <a class="list-group-item list-group-item-action">1h 이상 2h 미만</a>
                                        <a class="list-group-item list-group-item-action">2h 이상</a>
                                    </div>
                                    <div class="filter">
                                        <div style="width: 100%" class="row">
                                            <div class="col-sm-10">
                                                <label class="filter__label">
                                                    <input type="text" class="filter__input" readonly>
                                                </label>
                                                ~
                                                <label class="filter__label">
                                                    <input type="text" class="filter__input" readonly>
                                                </label>
                                            </div>
                                            <div class="col-sm-2">
                                                <button id="Rtime-btn" class="btn btn-light" type="button"><i class="fas fa-search"></i></button>
                                            </div>
                                        </div>
                                        <div id="Rtime_range" class="filter__slider-price" data-min="0" data-max="10" data-step="1"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--로딩시 블러 처리 하고 싶으면 loading-overlay blurEffect 이 클래스 두개 추가하기 -->
                    <div class="ResultWrapper">
                        <div class="EmptyResult">
                            <div class="Guide">
                                <svg class="GuideIcon" viewBox="0 0 48 48" width="48" height="48">
                                    <path d="M24 0L0 24h15v24h18V24h15z"></path>
                                </svg>
                            </div>
                            좋아하는 키워드를 선택해보세요.
                        </div>
                        <div class="Result">
                            <div class="SelectedKeywordLists">
                                <h2 class="invisible">선택된 키워드</h2>
                                <ul class="KeywordLists">
                                    <li class="Keyword">
                                    </li>
                                </ul>
                            </div>
                            <header class="ResultHeader">
                                <div class="ResultCounter">
                                    <span class="ResultCounter_Number">374</span> 건의 작품이 있습니다.
                                </div>
                                <div class="tab">
                                    <label class="switch" id = "Latest">
                                        <input type="radio" name="filter" checked>
                                        <span class="slider">최신순</span>
                                    </label>
                                    <label class="switch" id = "imdb_rating">
                                        <input type="radio" name="filter">
                                        <span class="slider">imdb 평점순</span>
                                    </label>
                                    <label class="switch"  id = "self_rating">
                                        <input type="radio" name="filter">
                                        <span class="slider">자체 평점순</span>
                                    </label>
                                    <label class="switch" id = "Most_reviews">
                                        <input type="radio" name="filter">
                                        <span class="slider">리뷰 많은순</span>
                                    </label>
                                </div>
                            </header>
                            <div class="ResultLists" id="ResultLists">
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

<!-- 키워드 선택 제어-->
<script>
    $(document).ready(function() {

        //초기상태 세팅
        $(".EmptyResult").show();
        $(".Result").hide();

        //선택 키워드 저장할 배열 선언
        var selTmArr = new Array();

        //ajax로 넘길 데이터
        var selType = "";
        var selGenre = new Array();
        var selRated = new Array();
        var selRtime_start = -1;
        var selRtime_end = -1;
        var selSort = "Latest"; //초기상태는 최신순


        //리스트 클릭 ---------------------------
        //TYPE 키워드 선택
        $("#list-TYPE a").click(function (e) {

            //리스트 값 가져오기
            var val = $(this).text();
            selType = val;

            //이전 선택 제거 (중복 막기 위해)
            $('#list-TYPE a').each(function (index, item) {
                if($(item).hasClass('active') === true) {
                    if($(item).text() !== val) {
                        $(item).removeClass('active');
                        addArray($(item).text(), selTmArr, 1);
                    }
                }
            })

            //리스트  선택 처리
            selList(this, 1);

            //배열 업데이트
            addArray(val, selTmArr, 1);

            //db넘겨주기 위한 값 세팅
            selType = ""
            $('#list-TYPE a').each(function (index, item) {
                if($(item).hasClass('active') === true) {
                   selType = $(item).text();
                }
            });
            printResult();
        })
        //GENRE 키워드 선택
        $("#list-GENRE a").click(function (e) {

            //리스트  선택 처리
            selList(this, 1);

            //리스트 값 가져오기
            var val = $(this).text();

            //배열 업데이트
            addArray(val, selTmArr, 1);
            addArray(val, selGenre, 1);

            printResult();
            //alert(selType + "/" + selGenre + "/" + selRated + "/" + selRtime_start + "/" + selRtime_end);

        })
        //RATED 키워드 선택
        $("#list-RATED a").click(function (e) {
            //리스트  선택 처리
            selList(this, 1);

            //리스트 값 가져오기
            var val = $(this).text();

            //배열 업데이트
            addArray(val, selTmArr, 1);
            addArray(val, selRated, 1);

            printResult();
            //alert(selType + "/" + selGenre + "/" + selRated + "/" + selRtime_start + "/" + selRtime_end);
        })
        //RUNNING TIME 키워드 선택
        $("#list-RTIME a").click(function (e) {

            //선택 리스트 값 가져오기
            var val = $(this).text();

            //이전에 선택 된 게 있으면 배열에서 지우기.
            for(var index in selTmArr) {
                if(selTmArr[index].includes( '이상' ) || selTmArr[index].includes( '미만' )){
                    selTmArr.splice($.inArray(selTmArr[index], selTmArr),1);
                }
            }

            //이전 선택된 게 있으면 리스트에서 지우기. 자기 자신 제외
            $('#list-RTIME a').each(function (index, item) {
                if($(item).hasClass('active') === true) {
                    if($(item).text() !== val) {
                        $(item).removeClass('active');
                    }
                }
            });

            //리스트  선택 처리
            selList(this, 1);

            //선택된 게 있다면
            $('#list-RTIME a').each(function (index, item) {
                if($(item).hasClass('active') === true) {
                    //배열 업데이트
                    addArray($(item).text(), selTmArr, 1);
                }
            });


            if($.inArray(val, selTmArr) !== -1) { //배열이 값이 있다면
                if (val === "1h 미만") {
                    selRtime_start = 0;
                    selRtime_end = 1;
                } else if (val === "1h 이상 2h 미만") {
                    selRtime_start = 1;
                    selRtime_end = 2;
                } else if (val === "2h 이상") {
                    selRtime_start = 2;
                    selRtime_end = 10; //최대값
                }
            }
            else { //배열이 값이 없다면
                selRtime_start = -1;
                selRtime_end = -1;
            }


            printResult();
            //alert(selType + "/" + selGenre + "/" + selRated + "/" + selRtime_start + "/" + selRtime_end);
        })

        //Running time slider bar 제어 --------
        const slider = document.getElementById('Rtime_range');
        const rangeMin = parseInt(slider.dataset.min);
        const rangeMax = parseInt(slider.dataset.max);
        const step = parseInt(slider.dataset.step);
        const filterInputs = document.querySelectorAll('input.filter__input');

        noUiSlider.create(slider, {
            start: [rangeMin, rangeMax],
            connect: true,
            step: step,
            range: {
                'min': rangeMin,
                'max': rangeMax
            },
            margin: 1,

            // make numbers whole
            format: {
                to: value => value,
                from: value => value
            }
        });

        // bind inputs with noUiSlider
        slider.noUiSlider.on('update', (values, handle) => {
            filterInputs[handle].value = values[handle];
        });

        filterInputs.forEach((input, indexInput) => {
            input.addEventListener('change', () => {
                slider.noUiSlider.setHandle(indexInput, input.value);
            })
        });

        //Runtime 슬라이더 검색 버튼 클릭시
        $("#Rtime-btn").click(function (e) {

            //리스트에서 선택 된 게 있으면 선택 제거 (중복 막기 위해)
            $('#list-RTIME a').each(function (index, item) {
                if($(item).hasClass('active') === true) {
                    $(item).removeClass('active');
                    addArray($(item).text(), selTmArr, 1);
                }
            });

            //슬라이더에서 값 받아오기
            var slider_val = slider.noUiSlider.get();
            var slider_keyword = slider_val[0] + 'h 이상 ' + slider_val[1] + 'h 미만';

            //이전에 슬라이더로 선택 된 게 있으면 지우기.
            for(var index in selTmArr) {
                if(selTmArr[index].includes( '이상' )){
                    selTmArr.splice($.inArray(selTmArr[index], selTmArr),1);
                }
            }

            //배열에 추가
            selTmArr.push(slider_keyword);

            selRtime_start = slider_val[0];
            selRtime_end = slider_val[1];

            printResult();
        })

        //키워드 버튼 클릭시
        $(document).on("click",".Keyword_DeleteButton",function(){

            //값 가져오기
            var val = $(this).text();
            //해쉬태그 제거
            if( val.charAt( 0 ) === '#' )
                val = val.slice( 1 );
            //리스트 선택 처리
            selList( $('.list-group a').filter(function() {return $(this).text() === val;}), 1);
            //배열 업데이트
            addArray(val, selTmArr, 1);

            //db 값들 세팅
            if(selType === val){
                selType = "";
            }
            else if(val.includes( '이상' )){
                selRtime_start =-1;
                selRtime_end = -1;
            }
            else if(val.includes( '미만' )){
                selRtime_start =-1;
                selRtime_end = -1;
            }
            else if($.inArray(val, selGenre) !== -1) {
                addArray(val, selGenre, 1);
            }
            else if($.inArray(val, selRated) !== -1){
                addArray(val, selRated, 1);
            }
            printResult();
        })

        //전체 해제 버튼 클릭
        $("#All-off").click(function (e) {
            //리스트 선택 해제
            for (var i = 0; i <selTmArr.length; i++) {
                $('.list-group a').filter(function() {return $(this).text() === selTmArr[i];}).removeClass( 'active' );
            }
            //배열에서 지우기
            for (var i = selTmArr.length; i > 0; i--) {
                selTmArr.pop();
            }

            //배열값이 비었으면 빈 화면 다시 보여주기
            if (!selTmArr.length) {
                $(".Result").hide();
                $(".EmptyResult").show();
            }

            //ajax 데이터 초기화
            selType = "";
            for (var i = selGenre.length; i > 0; i--) {
                selGenre.pop();
            }
            for (var i = selRated.length; i > 0; i--) {
                selRated.pop();
            }
            selRtime_start = -1;
            selRtime_end = -1;
        })

        //리스트 태그 선택처리 함수
        function selList(el, toggle) {
            if(toggle == 1){
                $(el).toggleClass('active');
            }
            else{
                $(el).addClass('active');
            }
        }

        //배열 값 업데이트 함수
        function addArray(value, arr, toggle) {
            if($.inArray(value, arr) != -1){ //배열에 값이 있다면
                if(toggle == 1){
                    //존재하는 값을 지운다
                    arr.splice($.inArray(value, arr),1);
                }
            }
            else{
                //배열추가
                arr.push(value);
            }
        }

        //선택 키워드 나열(프린트) 함수
        function printKeyword() {
            var textToInsert = [];
            var i = 0;
            for (var a = 0; a <selTmArr.length; a++) {
                textToInsert[i++] = '<button aria-label="선택 해제" class="btn btn-primary Keyword_DeleteButton">' +
                    '<span class="Keyword_Hash">#</span>';
                textToInsert[i++] = selTmArr[a];
                textToInsert[i++] = '<svg class="RSGIcon RSGIcon-close RSGIcon-close2 DeleteIcon" viewBox="0 0 48 48" width="48" height="48">' +
                    '<path d="M48 5.3L29.3 24 48 42.7 42.7 48 24 29.3 5.3 48 0 42.7 18.7 24 0 5.3 5.3 0 24 18.7 42.7 0 48 5.3z"></path>' +
                    '</svg>' +
                    '</button>' ;
            }

            $(".Keyword").html("").append(textToInsert.join(''));
        }

        //결과 화면 출력
        function printResult() {
            //배열에 값이 있으면 결과창 보이게
            if (selTmArr.length) {
                $(".EmptyResult").hide();
                $(".Result").show();
                //영화 리스트 불러오기
                get_movie_list();
                //선택 키워드 나열하기
                printKeyword();
            }
            //배열에 값이 없으면 빈 화면 보여주기
            else{
                $(".Result").hide();
                $(".EmptyResult").show();
            }
        }

        <!-- 정렬 탭 제어 -->
        $('.tab label').click(function(){

            var id = $(this).attr('id');
            if(id == 'Latest'){
                selSort = "Latest";
            }
            else if(id == 'imdb_rating'){
                selSort = "imdb_rating";
            }
            else if(id == 'self_rating'){
                selSort = "self_rating";
            }
            else if(id == 'Most_reviews'){
                selSort = "Most_reviews";
            }
            //새로고침 코드
            $ ('.ResultWrapper .ResultLists').load ( window.location + '.ResultWrapper .ResultLists').hide().fadeIn('slow');
            get_movie_list();
        });

        //선택된 조건에 맞게 영화 리스트 받아오는 함수
        function get_movie_list() {
            var values = [];
            //배열을 넘기기 위한 세팅
            $.ajaxSettings.traditional = true;
            $.ajax({
                type: "get",
                url: "/list",
                data: {
                    selType: selType,
                    selGenre: selGenre,
                    selRated: selRated,
                    selRtime_start: selRtime_start,
                    selRtime_end : selRtime_end,
                    selSort : selSort
                },
                success: function(result){
                    //var resultNum = result.pageMaker.totalCount;
                    //$(".ResultCounter").html('<span class="ResultCounter_Number">'+ resultNum + '</span> 건의 작품이 있습니다.');
                    var eachContent = '';
                    //이미지, 별 평점, 장르 바꿔야 함.
                    $.each(result.contents, function(key, value){
                        eachContent += '<div class="movie_card">' +
                                        '<div class="info_section">' +
                                            '<div class="movie_header">' +
                                                '<img class="locandina" src="https://occ-0-2568-2567.1.nflxso.net/art/5f5cb/3d5923c65399954d27493f553900df9daea5f5cb.jpg"/>' +
                                                '<h1>'+ value.title +'</h1>' +
                                                '<h4 style="display: inline-block">'+value.year;
                                                if(value.director != null){
                                                    eachContent += ', ' + value.director;
                                                }
                                                else{
                                                    eachContent += ', No Data';
                                                }
                                                eachContent += '</h4>' +
                                                '<div style="display: block">';
                                                    if(value.runtime != null){
                                                        eachContent += '<span class="boxinfo">' + value.runtime +' min</span>';
                                                    }
                                                    else{
                                                        eachContent += '<span class="boxinfo">no data</span>';
                                                    }
                                                    if(value.rated != null){
                                                        eachContent += '<span class="boxinfo">'+ value.rated +'</span>';
                                                    }
                                                    else{
                                                        eachContent += '<span class="boxinfo">no data</span>';
                                                    }
                                                    eachContent += '<div class="star-ratings-sprite"><span style="width:';
                                                    if(value.imdbRating == null){
                                                        eachContent += 0;
                                                    }
                                                    else{
                                                        eachContent += value.imdbRating*10;
                                                    }
                                                    eachContent += '%" class="star-ratings-sprite-rating"></span></div>' +
                                                    '<div class="main_awards">';
                                                        if(value.awardWin !== 0 && value.awardWin != null) {
                                                            eachContent += '<div class="awards_icon"><i class="fas fa-medal"></i></div>'+ value.awardWin;
                                                        }
                                                        if(value.awardNominate !== 0 && value.awardNominate != null){
                                                            eachContent += '<div class="awards_icon"><i class="fas fa-award"></i></div>' + value.awardNominate;
                                                        }
                                                        if(value.awardMajor != null){
                                                            eachContent += '<div class="awards_icon"><i class="fas fa-trophy"></i></div>' + value.awardMajor + ' ' + value.awardMajorType;
                                                        }
                                                    eachContent += '</div>' +
                                                '</div>' +
                                            '</div>' +
                                            '<div class="movie_desc">';
                                                if(value.plot != "" && value.plot != null){
                                                    eachContent += '<p class="text">' + value.plot + '</p>';
                                                }
                                                else{
                                                    eachContent += '<p class="text">no data</p>';
                                                }
                                            eachContent += '</div>' +
                                            '<div class="movie_genre">' +
                                                '<ul>';
                                                for(var index in value.genres) {
                                                    eachContent += '<li><i>#'+ value.genres[index].genre +'</i></li>';
                                                }
                                                eachContent += '</ul>' +
                                            '</div>' +
                                        '</div>' +
                                        '<div class="blur_back bright_back"></div>' +
                                        '</div>';
                    });
                    //결과가 안 비었을 때
                    if(eachContent != ''){
                        $(".ResultHeader").show();
                        $(".ResultLists").html(eachContent);
                    }
                    //결과가 비었을 때
                    else{
                        var EmptyResult = '';
                        EmptyResult = '<div class="EmptyResult"><h2 style="color: #0b2e13; font-weight: 700; margin-top: 25px;">검색 결과가 없습니다.</h2>키워드를 다시 선택해보세요. </div>';
                        $(".ResultHeader").hide();
                        $ ('.ResultWrapper .ResultLists').html(EmptyResult);
                    }
                }
            });
        }

    });
</script>

</body>
</html>
