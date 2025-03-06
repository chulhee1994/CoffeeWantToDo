package com.myspring.team.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.notice.vo.NoticeVO;

public interface NoticeDAO {
	public int selectToNotices() throws DataAccessException;
	public List selectAllNotices(Map paginMap) throws DataAccessException;
	public List<NoticeVO> searchNoticeLists(Map<String, Object> searchMap) throws DataAccessException;
	public int countSearchNotices(Map<String, Object> searchMap) throws DataAccessException;
	
	
	//공지사항 추가
	public int addNotice(Map noticeMap) throws DataAccessException;
	
	//하나의 공지사항 리턴
	public NoticeVO selectNotice(int notice_no) throws DataAccessException;
	
	public void updateNotice(Map<String, Object> noticeMap) throws DataAccessException;
	public void deleteNotice(int notice_no) throws DataAccessException;
	
	public int seq_notice_no() throws DataAccessException;
	public int selectNewNoticeNO() throws DataAccessException;
	public void updateNoticeFile(NoticeVO noticeVO) throws DataAccessException;
	public void updateViews(int notice_no) throws DataAccessException;
}
