package Keyword.user.controller;

import Keyword.commons.paging.Criteria;
import Keyword.commons.paging.PageMaker;
import Keyword.content.domain.ContentVO;
import Keyword.content.service.ContentService;
import Keyword.likes.service.LikesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    private final ContentService contentService;
    private final LikesService likesService;

    @Inject
    public UserController(ContentService contentService, LikesService likesService) {
        this.contentService = contentService;
        this.likesService = likesService;
    }

    // myInfo 페이지
    @RequestMapping(value = "/myInfo", method = RequestMethod.GET)
    public String myInfo(){
        return "user/myInfo";
    }

    // myLikes 페이지
    @RequestMapping(value = "/myLikes", method = RequestMethod.GET)
    public String myLikes(@RequestParam("userId") String userId, Model model, Criteria criteria) throws Exception{

        List<ContentVO> likes = contentService.getMyLikes(userId, criteria);
        model.addAttribute("likes", likes);

        Map<String, List<String>> genres = new HashMap<>();
        for(int i=0; i<likes.size(); i++){
            String contentId = likes.get(i).getContentId();
            genres.put(contentId, contentService.listMyGenre(contentId));
        }
        model.addAttribute("genres", genres);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(likesService.countMyLikes(userId));
        model.addAttribute("pageMaker", pageMaker);

        return "user/myLikes";
    }
}
