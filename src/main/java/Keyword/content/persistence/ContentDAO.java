package Keyword.content.persistence;

import Keyword.commons.paging.Criteria;
import Keyword.content.domain.ContentVO;

import java.util.List;

public interface ContentDAO {
    void create(ContentVO contentVO) throws Exception;
    ContentVO read(String contentId) throws Exception;
    void update(ContentVO contentVO) throws Exception;
    void delete(String contentId) throws Exception;
    List<ContentVO> listAll() throws Exception;
    List<String> listType() throws Exception;
    List<String> listGenre() throws Exception;
    List<String> listRated() throws Exception;
    void updateReviewCnt(String contentId, int amount) throws Exception;
    List<ContentVO> listSelected(String selType, String[] selGenre, String[] selRated, int selRtime_start, int selRtime_end, String selSort, Criteria criteria) throws Exception;
    List<String> listMyGenre(String contentId) throws Exception;
    void updateLikesCnt(String contentId, int amount) throws Exception;
    int countResult(String selType, String[] selGenre, String[] selRated, int selRtime_start, int selRtime_end) throws Exception;   // 페이징
}
