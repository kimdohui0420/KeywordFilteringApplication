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
            <c:forEach items="${likes}" var="like">
                <tr>
                    <td>${like.contentId}</td>
                    <td><span class="badge bg-red">${like.regDate}</span></td>
                </tr>
            </c:forEach>
        </main>
        <%@include file="../include/main_footer.jsp"%>
    </div>
</div>

<%@ include file="../include/plugin_js.jsp"%>
<script>
    var msg = "${msg}";
    if(msg==="REGISTERED")
        alert("회원가입이 완료되었습니다. 로그인해주세요:)");
    else if(msg==="FAILURE")
        alert("아이디와 비밀번호를 확인해주세요");

</script>

</body>
</html>
