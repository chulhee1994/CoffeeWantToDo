package com.myspring.team.member.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.member.vo.PointHistoryVO;

public interface MemberService {
	//로그인
	public MemberVO login(MemberVO memberVO) throws Exception;
	
	//아이디 중복 검사
	public String overlapped(String mem_id) throws Exception;
	
	//일반 회원 가입
	public void addCommon(MemberVO memberVO) throws Exception;
	
	//카카오 회원 가입
	public void addKakao(MemberVO memberVO) throws Exception;
		
	//판매자 회원 가입
	public void addSeller(MemberVO memberVO) throws Exception;
	
	//회원 정보 수정
	public int modMembers(MemberVO memberVO) throws DataAccessException;
	
	//회원 주소 정보 수정
	public int modDefaultAddress(MemberVO memberVO) throws DataAccessException;
	
	//회원 정보 수정
	public int modPersonalInfo(MemberVO member1) throws DataAccessException;

	//회원 탈퇴
	public int removeMember(MemberVO memberVO) throws DataAccessException;

	//아이디 비밀번호 찾기
	public MemberVO selectMember(MemberVO memberVO) throws DataAccessException;
	
	//비밀번호 변경
	public int updateMemPwd(MemberVO memberVO) throws DataAccessException;
	
	//아이디 조회?
	public MemberVO selectLoginInfo(MemberVO memberVO) throws DataAccessException;
	
	public void updateMemberPoint(String mem_id, int point) throws DataAccessException;
	
	public void updateMemberPointHistory(String mem_id, int point,String actionType, int order_id) throws DataAccessException;
	public int getCommonUserCount();
	public List<MemberVO> selectSellerList() throws DataAccessException;
	public List<PointHistoryVO> listPoint_get(String mem_id) throws DataAccessException;
	public List<PointHistoryVO> listPoint_get_review(String mem_id) throws DataAccessException;
	public List<PointHistoryVO> listPoint_use(String mem_id) throws DataAccessException;
}
