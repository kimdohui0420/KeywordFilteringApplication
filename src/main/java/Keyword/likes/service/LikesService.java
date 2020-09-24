package Keyword.likes.service;

import Keyword.likes.domain.LikesVO;

import java.util.List;

public interface LikesService {
    void liked(LikesVO likesVO) throws Exception;
    void unliked(LikesVO likesVO) throws Exception;
    LikesVO isLiked(String contentId, String userId) throws Exception;
    List<LikesVO> getMyLikes(String userId) throws Exception;
}
