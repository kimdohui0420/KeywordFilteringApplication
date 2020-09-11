package Keyword.review.persistence;

import Keyword.review.domain.ReviewVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO{
    private static String NAMESPACE = "Keyword.mappers.review.ReviewMapper";
    private final SqlSession sqlSession;

    @Inject
    public ReviewDAOImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<ReviewVO> list(String contentId) throws Exception {
        return sqlSession.selectList(NAMESPACE+".list", contentId);
    }

    @Override
    public void create(ReviewVO reviewVO) throws Exception {
        sqlSession.insert(NAMESPACE+".create", reviewVO);
    }

    @Override
    public void update(ReviewVO reviewVO) throws Exception {
        sqlSession.update(NAMESPACE+".update", reviewVO);
    }

    @Override
    public void delete(Integer reviewNo) throws Exception {
        sqlSession.delete(NAMESPACE+".delete", reviewNo);
    }
}
