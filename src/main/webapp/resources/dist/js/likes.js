// 좋아요 클릭 처리
$("#like-checkbox").change(function(){
    var cid = $(this).parent().parent().attr('id');
    if($("#like-checkbox").is(":checked")){
        $.ajax({
            type: "post",
            url: "/likes",
            headers: {
                "Content-type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                contentId: cid,
                userId: userId
            }),
            success: function (msg) {
                if(msg==="regSuccess"){
                    $("#totalLikesCnt").html();
                }
                else
                    $("input:checkbox[id='like-checkbox']").prop("checked", false);
            }
        });
    }else{
        $.ajax({
            type: "delete",
            url: "/likes",
            headers: {
                "Content-type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                contentId: cid,
                userId: userId
            }),
            success: function (msg) {
                if(msg!=="delSuccess")
                    $("input:checkbox[id='like-checkbox']").prop("checked", true);
            }
        });
    }
});