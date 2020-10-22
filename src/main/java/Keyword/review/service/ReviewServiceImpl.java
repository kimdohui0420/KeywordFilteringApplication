package Keyword.review.service;

import Keyword.commons.paging.Criteria;
import Keyword.content.persistence.ContentDAO;
import Keyword.review.domain.ReviewVO;
import Keyword.review.persistence.ReviewDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public List<ReviewVO> getReviews(String contentId, String userId) throws Exception {
        return reviewDAO.list(contentId, userId);
    }

    @Transactional
    @Override
    public void addReview(ReviewVO reviewVO) throws Exception {
        reviewDAO.create(reviewVO);
        contentDAO.updateReviewCnt(reviewVO.getContentId(), 1);
    }

    @Override
    public void modifyReview(ReviewVO reviewVO) throws Exception {
        reviewDAO.update(reviewVO);
    }

    @Transactional
    @Override
    public void removeReview(Integer reviewNo) throws Exception {
        String contentId = reviewDAO.getContentId((reviewNo));
        reviewDAO.delete(reviewNo);
        contentDAO.updateReviewCnt(contentId, -1);
    }

    @Override
    public ReviewVO getMyReview(String contentId, String userId) throws Exception {
        return reviewDAO.getMyReview(contentId, userId);
    }

    @Override
    public List<ReviewVO> getReviewsPaging(String contentId, Criteria criteria) throws Exception {
        return reviewDAO.listPaging(contentId, criteria);
    }

    @Override
    public int countReviews(String contentId) throws Exception {
        return reviewDAO.countReviews(contentId);
    }
}
