package Keyword.content;

import Keyword.commons.paging.Criteria;
import Keyword.commons.paging.SearchCriteria;
import Keyword.content.domain.ContentVO;
import Keyword.content.persistence.ContentDAO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.inject.Inject;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-config/applicationContext.xml"})
public class ContentDAOTest {
    private static final Logger logger = LoggerFactory.getLogger(ContentDAO.class);

    @Inject
    private ContentDAO contentDAO;

    @Test
    public void testSearch() throws Exception{
        SearchCriteria searchCriteria = new SearchCriteria();
        searchCriteria.setSearchType("c");
        searchCriteria.setSearchKeyword("Robert");
        System.out.println(contentDAO.listSearch(searchCriteria));
    }

    @Test
    public void testMyGenre() throws Exception{
        System.out.println(contentDAO.listMyGenre("tt3521164"));
    }

    @Test
    public void testCreate() throws Exception{
        ContentVO content = new ContentVO();
        content.setContentId("tt0000000");
        content.setTitle("CREATE 테스트 제목");
        content.setPlot("CREATE 테스트 줄거리");
        content.setYear(2020);
        contentDAO.create(content);
    }

    @Test
    public void testRead() throws Exception{
        logger.info(contentDAO.read("tt0019422").toString());
    }

    @Test
    public void testUpdate() throws Exception{
        ContentVO content = new ContentVO();
        content.setContentId("tt0000000");
        content.setTitle("UPDATE 테스트");
        contentDAO.update(content);
    }

    @Test
    public void testDelete() throws Exception{
        contentDAO.delete("tt0000000");
    }

    @Test
    public void testListAll() throws Exception{
        System.out.println(contentDAO.listAll());
    }


    @Test
    public void ListSelected() throws Exception{
        String[] selGenre = null;
        String[] selRated = null;
        int selRtime_start = -1;
        int selRtime_end = -1;

        Criteria criteria = new Criteria();
        criteria.setPage(1);

        List<ContentVO> contents = contentDAO.listSelected("episode", selGenre, selRated, selRtime_start, selRtime_end,"Latest", criteria);

        for(ContentVO content : contents) {
            logger.info(content.getContentId() + " : " + content.getTitle());
        }
    }

    @Test
    public void testURI() throws Exception {
        UriComponents uriComponents= UriComponentsBuilder.newInstance()
                .path("/article/read")
                .queryParam("articleNo", 12)
                .queryParam("perPageNum",20)
                .build();

        logger.info(uriComponents.toString());
    }

    //db에 포스터 이미지 넣기
    @Test
    public void testCrawling() throws Exception {
        List<ContentVO> contents = contentDAO.listAll();
        for (ContentVO s : contents) {

            //System.out.println(s.getContentId());
            String imdbsrc = "https://www.imdb.com/title/";
            imdbsrc += s.getContentId() + "/";

            Document doc;
            doc = Jsoup.connect(imdbsrc).get();

            Element imageElement = doc.select(".poster > a > img").first();
            String poster = imageElement.attr("src");

            contentDAO.setPoster(s.getContentId(), poster);

        }
    }


}
