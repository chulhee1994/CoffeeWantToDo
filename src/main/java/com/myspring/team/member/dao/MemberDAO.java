package com.myspring.team.member.dao;


import java.util.List;

import org.springframework.dao.DataAccessException;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.member.vo.PointHistoryVO;

public interface MemberDAO {
	//로그인
	public MemberVO loginById(MemberVO memberVO) throws DataAccessException;
	
	//아이디 중복 검사
	public String selectOverlappedID(String mem_id) throws DataAccessException;
	
	//일반 사용자 회원 가입
	public void insertNewCommon(MemberVO memberVO) throws DataAccessException;
	
	//카카오 회원 가입
	public void insertNewKakao(MemberVO memberVO) throws DataAccessException;
	
	//판매자 회원 가입
	public void insertNewSeller(MemberVO memberVO) throws DataAccessException;
	
	//회원 정보 수정
	public int updateMember(MemberVO memberVO) throws DataAccessException;
	
	//회원 주소 정보 수정
	public int updateDefaultAddress(MemberVO memberVO) throws DataAccessException;	
	
	//개인정보 동의 내역 수정
	public int updatePersonalInfo(MemberVO memberVO) throws DataAccessException;
	
	//회원 탈퇴
	public int SignOutMember(MemberVO memberVO) throws DataAccessException;
	
	//아이디 비밀번호 찾기
	public MemberVO selectMember(MemberVO memberVO) throws DataAccessException;
	
	//비밀번호 변경
	public int updateMemPwd(MemberVO memberVO) throws DataAccessException;
	
	//아이디 존재유무 판단
	public MemberVO selectLoginInfo(MemberVO memberVO) throws DataAccessException;
	
	public void updateMemberPoint(String mem_id, int point) throws DataAccessException;
	
	public void updateMemberPointHistory(String mem_id, int point,String action_type, int order_id) throws DataAccessException;
	
	public int countCommonUsers();
	
	public List<MemberVO> selectSellerList() throws DataAccessException;
	public List<PointHistoryVO> selectListPoint_get(String mem_id) throws DataAccessException;
	public List<PointHistoryVO> selectListPoint_get_review(String mem_id) throws DataAccessException;
	public List<PointHistoryVO> selectListPoint_use(String mem_id) throws DataAccessException;
}
