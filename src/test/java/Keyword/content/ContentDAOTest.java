package Keyword.content;

import Keyword.content.domain.ContentVO;
import Keyword.content.persistence.ContentDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-config/applicationContext.xml"})
public class ContentDAOTest {
    private static final Logger logger = LoggerFactory.getLogger(ContentDAO.class);

    @Inject
    private ContentDAO contentDAO;

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

    /*
    @Test
    public void ListSelected() throws Exception{
        System.out.println(contentDAO.listSelected("movie", ));
    }
    */

}
