package Keyword.review.persistence;

import Keyword.review.domain.ReviewVO;

import java.util.List;

public interface ReviewDAO {
    List<ReviewVO> list(String contentId, String userName) throws Exception;
    void create(ReviewVO reviewVO) throws Exception;
    void update(ReviewVO reviewVO) throws Exception;
    void delete(Integer reviewNo) throws Exception;
    String getContentId(Integer reviewNo) throws Exception;
    ReviewVO getMyReview(String contentId, String userName) throws Exception;   // 내 리뷰 가져오기
    // 댓글 페이징
    //List<ReviewVO> listPaging(String contentId, Criteria criteria) throws Exception;
    //int countReplies(Integer contentId) throws Exception;
}
