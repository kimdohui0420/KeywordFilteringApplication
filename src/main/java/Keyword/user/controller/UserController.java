package Keyword.user.controller;

import Keyword.likes.service.LikesService;
import Keyword.user.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;

@Controller
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    private final LikesService likesService;

    @Inject
    public UserController(UserService userService, LikesService likesService) {
        this.userService = userService;
        this.likesService = likesService;
    }

    // myInfo 페이지
    @RequestMapping(value = "/myInfo", method = RequestMethod.GET)
    public String myInfo(){
        return "user/myInfo";
    }

    // myLikes 페이지
    @RequestMapping(value = "/myLikes", method = RequestMethod.GET)
    public String myLikes(@RequestParam("userId") String userId, Model model) throws Exception{
        model.addAttribute("likes", likesService.getMyLikes(userId));

        return "user/myLikes";
    }
}
