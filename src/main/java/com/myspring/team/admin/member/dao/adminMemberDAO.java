package com.myspring.team.admin.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.member.vo.MemberVO;

public interface adminMemberDAO {

	public List<MemberVO> selectMemberList() throws DataAccessException;
	
	public boolean updateMemberGrade(MemberVO memberVO) throws DataAccessException;
	
	public boolean deleteMember(MemberVO memberVO) throws DataAccessException;
	
	public boolean updateMemberdelyn(MemberVO memberVO) throws DataAccessException;
}
