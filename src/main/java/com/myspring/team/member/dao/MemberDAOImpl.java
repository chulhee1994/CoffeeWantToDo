package com.myspring.team.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.member.vo.PointHistoryVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	 private SqlSession sqlSession;
	
	//로그인
	@Override
	public MemberVO loginById(MemberVO memberVO) throws DataAccessException {
			MemberVO vo = sqlSession.selectOne("mapper.member.loginById", memberVO);
			return vo;
	}
	
	//아이디 중복 검사
	@Override
	public String selectOverlappedID(String mem_id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.selectOverlappedID", mem_id);
		return result;
	}	
	
	//일반 사용자 회원 가입
	@Override
	public void insertNewCommon(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewCommon",memberVO);
	}
	
	//카카오 사용자 회원 가입
	@Override
	public void insertNewKakao(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewKakao",memberVO);
	}
	
	//판매자 회원 가입
	@Override
	public void insertNewSeller(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewSeller",memberVO);
	}
	
	//회원 정보 수정
	@Override
	 public int updateMember (MemberVO memberVO) throws DataAccessException {
	    	int result = sqlSession.update("mapper.member.updateMember", memberVO);
	    	return result;
	    }
	
	//회원 주소 정보 수정
	@Override
	 public int updateDefaultAddress (MemberVO memberVO) throws DataAccessException {
	    	int result = sqlSession.update("mapper.member.updateDefaultAddress", memberVO);
	    	return result;
	    }	
	
	//개인정보 동의 내역 수정
	 public int updatePersonalInfo(MemberVO memberVO) throws DataAccessException {
		 int result = sqlSession.update("mapper.member.updatePersonalInfo", memberVO);
	    	return result;
		}
		
	//회원 탈퇴
	 public int SignOutMember(MemberVO memberVO) throws DataAccessException {
		 int result = sqlSession.update("mapper.member.SignOutMember", memberVO);
	    	return result;
		}
	 
	 //아이디 비밀번호 찾기
	 @Override
	    public MemberVO selectMember(MemberVO memberVO) throws DataAccessException {
	        return sqlSession.selectOne("mapper.member.selectMember", memberVO);
	    }
	 
	 //비밀번호 변경
	   @Override
	    public int updateMemPwd(MemberVO memberVO) throws DataAccessException {
	        int result = sqlSession.update("mapper.member.updateMemPwd", memberVO);
	        return result;
	    }
	    
	    //아이디 존재 유무
	    @Override
	    public MemberVO selectLoginInfo(MemberVO memberVO) throws DataAccessException {
	        return sqlSession.selectOne("mapper.member.selectLoginInfo", memberVO);
	    }   
	    
	    @Override
	    public void updateMemberPoint(String mem_id, int point) throws DataAccessException {
	    	Map updateMap = new HashMap();
	    	updateMap.put("mem_id", mem_id);
	    	updateMap.put("point", point);
	    	
	    	sqlSession.update("mapper.member.updateMemberPoint", updateMap);
	    }   
	    
	    @Override
		public void updateMemberPointHistory(String mem_id, int point,String action_type, int order_id) throws DataAccessException {
			Map updateMap = new HashMap();
			updateMap.put("mem_id", mem_id);
			updateMap.put("point", point);
			updateMap.put("action_type", action_type);
			updateMap.put("order_id", order_id);
			
			sqlSession.insert("mapper.member.updateMemberPointHistory", updateMap);
		}

		@Override
	    public int countCommonUsers() {
	        // MyBatis 쿼리 호출
	        return sqlSession.selectOne("mapper.member.countCommonUsers");
	        
      
}
	    @Override
	    public List<MemberVO> selectSellerList() throws DataAccessException {
	        return sqlSession.selectList("mapper.member.selectSellerList", null);
	        }	  
        @Override
public List<PointHistoryVO> selectListPoint_get(String mem_id) throws DataAccessException {
    return sqlSession.selectList("mapper.member.selectGetPointList", mem_id);
    }

@Override
public List<PointHistoryVO> selectListPoint_get_review(String mem_id) throws DataAccessException {
    return sqlSession.selectList("mapper.member.selectGetPointListReview", mem_id);
    }	 

@Override
public List<PointHistoryVO> selectListPoint_use(String mem_id) throws DataAccessException {
    return sqlSession.selectList("mapper.member.selectUsePointList", mem_id);
    }	

}
