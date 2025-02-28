function confirmDelete(movieId) {
    if (confirm("해당 리뷰를 삭제하시겠습니까?")) {
        deleteReview(movieId);
    }
}

function deleteReview(movieId) {
    $.ajax({
        url: "Index", // 컨트롤러 메인 서블릿으로 요청 전송
        type: "POST",
        data: {
            t_gubun: "MyRatingDelete", // MyReviewDelete 클래스 호출을 위한 구분자
            movieId: movieId
        },
        success: function(response) {
            // DB에서 삭제는 성공했으므로 화면에서도 리뷰 카드 제거
            $("#review-" + movieId).fadeOut(300, function() {
                $(this).remove();
                
                // 남은 리뷰가 없는지 확인하고 메시지 표시
                if ($(".review-card").length === 0) {
                    $(".review-container").append(
                        '<div class="no-reviews"><p>작성한 리뷰가 없습니다.</p></div>'
                    );
                }
                
                // 성공 메시지 표시
                alert("리뷰가 삭제되었습니다!");
            });
        },
        error: function(xhr, status, error) {
            alert("리뷰 삭제 중 오류가 발생했습니다: " + error);
        }
    });
}