package Keyword.review.controller;

import Keyword.review.domain.ReviewVO;
import Keyword.review.service.ReviewService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    private final ReviewService reviewService;

    @Inject
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    // 리뷰 등록처리
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<String> register(@RequestBody ReviewVO reviewVO){
        ResponseEntity<String> entity = null;
        try{
            reviewService.addReview(reviewVO);
            entity = new ResponseEntity<>("regSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 리뷰 목록
    @RequestMapping(value = "/all/{contentId}", method = RequestMethod.GET)
    public ResponseEntity<List<ReviewVO>> list(@PathVariable("contentId") String contentId){
        ResponseEntity<List<ReviewVO>> entity = null;
        try {
            entity = new ResponseEntity<>(reviewService.getReviews(contentId), HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 리뷰 수정
    @RequestMapping(value = "/{reviewNo}", method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<String> update(@PathVariable("reviewNo") Integer reviewNo, @RequestBody ReviewVO reviewVO){
        ResponseEntity<String> entity = null;
        try {
            reviewVO.setReviewNo(reviewNo);
            reviewService.modifyReview(reviewVO);
            entity = new ResponseEntity<>("modSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 리뷰 삭제
    @RequestMapping(value = "/{reviewNo}", method = RequestMethod.DELETE)
    public ResponseEntity<String> delete(@PathVariable("reviewNo") Integer reviewNo){
        ResponseEntity<String> entity = null;
        try{
            reviewService.removeReview(reviewNo);
            entity = new ResponseEntity<>("delSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    /*// 리뷰 페이징
    @RequestMapping(value = "/{articleNo}/{page}", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> listPaging(
            @PathVariable("articleNo") Integer articleNo,
            @PathVariable("page") Integer page){
        ResponseEntity<Map<String, Object>> entity = null;
        try {
            Criteria criteria = new Criteria();
            criteria.setPage(page);

            List<ReplyVO> replies = replyService.getRepliesPaging(articleNo, criteria);
            int repliesCount = replyService.countReplies(articleNo);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCriteria(criteria);
            pageMaker.setTotalCount(repliesCount);;

            Map<String, Object> mapp = new HashMap<>();
            mapp.put("replies", replies);
            mapp.put("pageMaker", pageMaker);

            entity = new ResponseEntity<>(mapp, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.OK);
        }
        return entity;
    }*/
}
