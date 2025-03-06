package com.myspring.team.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.team.notice.vo.NoticeVO;




@Repository("noticeDAO")
public class NoticeDAOImpl implements NoticeDAO{

	@Autowired
	private SqlSession sqlSession;
		
	@Override
	public int selectToNotices() throws DataAccessException {
		int toNotices = sqlSession.selectOne("mapper.notice.selectToNotices");
		return toNotices;
	}

	@Override
	public int seq_notice_no() throws DataAccessException{
		return sqlSession.selectOne("mapper.notice.seq_notice_no");
	}
	
	@Override
	public List selectAllNotices(Map paginMap) throws DataAccessException {
		List<NoticeVO> noticesList = sqlSession.selectList("mapper.notice.selectAllNoticesList",paginMap);
		return noticesList;
	}
	
	//공지사항 번호 불러오는 메서드 seq_notice_no
	
	@Override
	public void deleteNotice(int notice_no) throws DataAccessException {
		sqlSession.delete("mapper.notice.deleteNotice", notice_no);
	}
	
	@Override
	public NoticeVO selectNotice(int notice_no) throws DataAccessException {
		return sqlSession.selectOne("mapper.notice.selectNotice", notice_no);
	}
	@Override
	public int countSearchNotices(Map<String, Object> searchMap) throws DataAccessException {
	    return sqlSession.selectOne("mapper.notice.countSearchNotices", searchMap);
	}
	@Override
	public List<NoticeVO> searchNoticeLists(Map<String, Object> searchMap) throws DataAccessException {
	    return sqlSession.selectList("mapper.notice.searchNoticeLists", searchMap);
	}
	
	@Override
	public int selectNewNoticeNO() throws DataAccessException {
	    return sqlSession.selectOne("mapper.notice.selectNewNoticeNO");
	}

	@Override
	public int addNotice(Map noticeMap) throws DataAccessException {
		int notice_no = sqlSession.selectOne("mapper.notice.seq_notice_no_nextval");
		noticeMap.put("notice_no", notice_no);
	    sqlSession.insert("mapper.notice.addNotice", noticeMap);
	    return notice_no;
	}


	@Override
	public void updateNoticeFile(NoticeVO noticeVO) throws DataAccessException {
	    sqlSession.update("mapper.notice.updateNoticeFile", noticeVO);
	}
	
	  @Override
	    public void updateNotice(Map<String, Object> noticeMap) throws DataAccessException {
		  for (Map.Entry<String, Object> entry : noticeMap.entrySet()) {
			    System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
			}
	        sqlSession.update("mapper.notice.updateNotice", noticeMap);
	    }

		//조회수 증가 기능
		@Override
		public void updateViews(int notice_no) throws DataAccessException{
			sqlSession.update("mapper.notice.updateViews", notice_no);
		}
	

}
