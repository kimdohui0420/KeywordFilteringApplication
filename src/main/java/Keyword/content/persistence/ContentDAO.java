package Keyword.content.persistence;

import Keyword.content.domain.ContentVO;

import java.util.List;

public interface ContentDAO {
    void create(ContentVO contentVO) throws Exception;
    ContentVO read(String contentId) throws Exception;
    void update(ContentVO contentVO) throws Exception;
    void delete(String contentId) throws Exception;
    List<ContentVO> listAll() throws Exception;
}
