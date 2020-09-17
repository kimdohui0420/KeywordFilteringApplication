package Keyword.review.service;

import Keyword.review.domain.ReviewVO;

import java.util.List;

public interface ReviewService {
    List<ReviewVO> getReviews(String contentId, String userName) throws Exception;
    void addReview(ReviewVO reviewVO) throws Exception;
    void modifyReview(ReviewVO reviewVO) throws Exception;
    void removeReview(Integer reviewNo) throws Exception;
    ReviewVO getMyReview(String contentId, String userName) throws Exception;
    // [11-3] 댓글 페이징
    //List<ReviewVO> getReviewsPaging(String contentId, Criteria criteria) throws Exception;
    //int countReviews(String contentId) throws Exception;
}
