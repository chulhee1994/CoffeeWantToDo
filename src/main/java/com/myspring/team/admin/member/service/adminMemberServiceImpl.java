package com.myspring.team.admin.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.myspring.team.admin.member.dao.adminMemberDAO;
import com.myspring.team.member.vo.MemberVO;

@Service("adminMemberService")
public class adminMemberServiceImpl implements adminMemberService {

	@Autowired
	private adminMemberDAO adminmemberDAO;
	
	@Override
	public List<MemberVO> listMembers() throws DataAccessException {
		List<MemberVO> membersList = adminmemberDAO.selectMemberList();
		return membersList;
	}
	
	@Override
	public boolean updateMemberGrade(MemberVO memberVO) throws DataAccessException {
		return adminmemberDAO.updateMemberGrade(memberVO);
        
    }
	
	@Override
	public boolean deleteMember(MemberVO memberVO) throws DataAccessException {
		return adminmemberDAO.deleteMember(memberVO);
        
    }
	
	@Override
	public boolean updateMemberdelyn(MemberVO memberVO) throws DataAccessException {
		return adminmemberDAO.updateMemberdelyn(memberVO);
        
    }
}
