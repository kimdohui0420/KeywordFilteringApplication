package Keyword.user.controller;

import Keyword.user.domain.UserVO;
import Keyword.user.service.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;

@Controller
@RequestMapping("/user")
public class UserSignUpController {
    private final UserService userService;

    @Inject
    public UserSignUpController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.GET)
    public String registerGET() throws Exception{
        return "user/signUp";
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.POST)
    public String registerPOST(UserVO userVO, RedirectAttributes redirectAttributes) throws Exception{
        String hashedPw = BCrypt.hashpw(userVO.getUserPw(), BCrypt.gensalt());
        userVO.setUserPw(hashedPw);
        userService.signUp(userVO);
        redirectAttributes.addFlashAttribute("msg", "REGISTERED");

        return "redirect:/user/login";
    }
}
