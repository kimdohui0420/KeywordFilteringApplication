package Keyword.review.service;

import Keyword.content.persistence.ContentDAO;
import Keyword.review.domain.ReviewVO;
import Keyword.review.persistence.ReviewDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService{
    private final ReviewDAO reviewDAO;
    private final ContentDAO contentDAO;

    @Inject
    public ReviewServiceImpl(ReviewDAO reviewDAO, ContentDAO contentDAO) {
        this.reviewDAO = reviewDAO;
        this.contentDAO = contentDAO;
    }

    @Override
    public List<ReviewVO> getReviews(String contentId) throws Exception {
        return reviewDAO.list(contentId);
    }

    //TODO: @Transactional content 테이블에 댓글 갯수 컬럼 추
    @Override
    public void addReview(ReviewVO reviewVO) throws Exception {
        reviewDAO.create(reviewVO);
        //articleDAO.updateReplyCnt(replyVO.getArticleNo(), 1); // 댓글 갯수 1 증가
    }

    @Override
    public void modifyReview(ReviewVO reviewVO) throws Exception {
        reviewDAO.update(reviewVO);
    }

    // @Transactional
    @Override
    public void removeReview(Integer reviewNo) throws Exception {
        //int articleNo = replyDAO.getArticleNo((replyNo));   // 댓글 삭제 전에, 댓글이 달린 게시글 번호 먼저 받아오기
        reviewDAO.delete(reviewNo);
        //articleDAO.updateReplyCnt(articleNo, -1);   // 댓글 갯수 1 감소
    }
}
