package com.myspring.team.goods.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.goods.vo.GoodsVO;

@Repository("mbtiDAO")
public class MbtiDAOImpl implements MbtiDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public List<GoodsVO> selectGoodsByMBTI(String mbti) throws DataAccessException {
		return sqlSession.selectList("mapper.goods.selectGoodsByMBTI", mbti);
	}

}
