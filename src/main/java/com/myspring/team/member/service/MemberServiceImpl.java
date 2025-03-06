package com.myspring.team.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.member.dao.MemberDAO;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.member.vo.PointHistoryVO;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;

	//로그인
	@Override
	public MemberVO login(MemberVO memberVO) throws Exception {
		return memberDAO.loginById(memberVO);
	}
	
	//아이디 중복 검사
	@Override
	public String overlapped(String mem_id) throws Exception{
		return memberDAO.selectOverlappedID(mem_id);
	}	
	
	//일반 회원 가입
	@Override
	public void addCommon(MemberVO memberVO) throws Exception {
		memberDAO.insertNewCommon(memberVO);
	}
	
	//카카오 회원 가입
	@Override
	public void addKakao(MemberVO memberVO) throws Exception {
		memberDAO.insertNewKakao(memberVO);
	}
	
	//판매자 회원 가입
	@Override
	public void addSeller(MemberVO memberVO) throws Exception {
		memberDAO.insertNewSeller(memberVO);
	}

	//회원 정보 수정
	@Override
	public int modMembers(MemberVO member) throws DataAccessException {
		return memberDAO.updateMember(member);
	}

	//회원 주소 정보 수정
	@Override
	public int modDefaultAddress(MemberVO member) throws DataAccessException {
		return memberDAO.updateDefaultAddress(member);
	}
	
	//개인정보 동의내역 수정
	@Override
	public int modPersonalInfo(MemberVO member) throws DataAccessException {
		return memberDAO.updatePersonalInfo(member);
	}
	
	//회원 탈퇴
	@Override
	public int removeMember(MemberVO memberVO) throws DataAccessException {
		return memberDAO.SignOutMember(memberVO);
	}
	
	//아이디 비밀번호 찾기
	@Override
    public MemberVO selectMember(MemberVO memberVO) throws DataAccessException {
        return memberDAO.selectMember(memberVO);
    }
	
	//비밀번호 변경
	@Override
    public int updateMemPwd(MemberVO memberVO) throws DataAccessException {
        return memberDAO.updateMemPwd(memberVO);
    }
    
    //아이디 조회 ?
    @Override
    public MemberVO selectLoginInfo(MemberVO memberVO) throws DataAccessException {
        return memberDAO.selectLoginInfo(memberVO);
    }
    
    @Override
	public void updateMemberPoint(String mem_id, int point) throws DataAccessException {
		memberDAO.updateMemberPoint(mem_id,point);
	}

	@Override
	public void updateMemberPointHistory(String mem_id, int point,String actionType, int order_id) throws DataAccessException {
		memberDAO.updateMemberPointHistory(mem_id,point,actionType, order_id);
	}
	 // 일반 사용자 수 조회
    public int getCommonUserCount() {
        // DAO 메서드를 호출하여 결과를 반환
        return memberDAO.countCommonUsers();
    }
    
    @Override
    public List<MemberVO> selectSellerList() throws DataAccessException {
        // DAO 메서드를 호출하여 결과를 반환
        return memberDAO.selectSellerList();
    }    
    @Override
    public List<PointHistoryVO> listPoint_get(String mem_id) throws DataAccessException {
    	return memberDAO.selectListPoint_get(mem_id);
    }
    
    @Override
    public List<PointHistoryVO> listPoint_get_review(String mem_id) throws DataAccessException {
    	return memberDAO.selectListPoint_get_review(mem_id);
    }
    
    @Override
    public List<PointHistoryVO> listPoint_use(String mem_id) throws DataAccessException {
    	return memberDAO.selectListPoint_use(mem_id);
    }

}
