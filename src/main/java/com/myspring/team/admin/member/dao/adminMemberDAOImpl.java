package com.myspring.team.admin.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.member.vo.MemberVO;

@Repository("adminMemberDAO")
public class adminMemberDAOImpl implements adminMemberDAO {

	@Autowired
	 private SqlSession sqlSession;
	
	@Override
	public List<MemberVO> selectMemberList() throws DataAccessException {
		List<MemberVO> membersList = sqlSession.selectList("mapper.member.selectMemberList");
		return membersList;
	}
	
	@Override
	 public boolean updateMemberGrade(MemberVO memberVO) throws DataAccessException {
	        sqlSession.update("mapper.member.modMemberGrade", memberVO);
	        return true;
	    }
	
	@Override
	 public boolean deleteMember(MemberVO memberVO) throws DataAccessException {
	        sqlSession.delete("mapper.member.deleteMember", memberVO);
	        return true;
	    }
	
	@Override
	 public boolean updateMemberdelyn(MemberVO memberVO) throws DataAccessException {
	        sqlSession.update("mapper.member.modMemberdelyn", memberVO);
	        return true;
	    }
	
	
}
