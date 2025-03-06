package com.myspring.team.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.notice.vo.NoticeVO;

public interface NoticeService {

	public Map searchNoticeLists(Map<String, Object> searchMap) throws DataAccessException;
	public Map listNotices(Map paginMap) throws DataAccessException;

	public int addNotice(Map noticeMap) throws DataAccessException;

	public NoticeVO selectNotice(int notice_no) throws DataAccessException;
	
	public void deleteNotice(int notice_no) throws DataAccessException;

	public void updateNoticeFile(NoticeVO noticeVO) throws DataAccessException;

	public int selectNewNoticeNO() throws DataAccessException;

	public void updateNotice(Map<String, Object> noticeMap) throws Exception;
	public void updateViews(int notice_no) throws DataAccessException;



	
}
