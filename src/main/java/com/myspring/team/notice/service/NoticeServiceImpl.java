package com.myspring.team.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.myspring.team.notice.dao.NoticeDAO;
import com.myspring.team.notice.vo.NoticeVO;



@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDAO noticeDAO;

	@Override
	public Map listNotices(Map paginMap) throws DataAccessException {
		
		Map noticesMap = new HashMap();
		List<NoticeVO> noticesList = noticeDAO.selectAllNotices(paginMap);
		
		int toNotices = noticeDAO.selectToNotices();
		noticesMap.put("noticesList", noticesList);
		noticesMap.put("toNotices", toNotices);
		return noticesMap;
	}
	@Override
	public Map<String, Object> searchNoticeLists(Map<String, Object> searchMap) throws DataAccessException {
	    Map<String, Object> noticesMap = new HashMap<>();

	    // ✅ 검색된 공지사항 리스트 (페이징 적용)
	    List<NoticeVO> noticesList = noticeDAO.searchNoticeLists(searchMap);

	    // ✅ 검색된 전체 공지사항 개수 (페이징을 위해)
	    int toNotices = noticeDAO.countSearchNotices(searchMap); // 🔥 검색 개수만 가져오기

	    noticesMap.put("noticesList", noticesList);
	    noticesMap.put("toNotices", toNotices); // 페이징 처리를 위해 전체 개수 추가
	    noticesMap.put("section", searchMap.get("section"));
	    noticesMap.put("pageNum", searchMap.get("pageNum"));

	    
	    return noticesMap;
	}


	
	

	@Override
	public int selectNewNoticeNO() throws DataAccessException {
	    return noticeDAO.selectNewNoticeNO();
	}

	@Override
	public int addNotice(Map noticeMap) throws DataAccessException {
	    return noticeDAO.addNotice(noticeMap);
	}
	
	@Override
	public void deleteNotice(int notice_no) throws DataAccessException {
	    noticeDAO.deleteNotice(notice_no);
	}
	

	@Override
	public void updateNoticeFile(NoticeVO noticeVO) throws DataAccessException {
	    noticeDAO.updateNoticeFile(noticeVO);
	}

	
	
	@Override
	public NoticeVO selectNotice(int notice_no) throws DataAccessException {
		return noticeDAO.selectNotice(notice_no);
	}
	
	
	   @Override
	    public void updateNotice(Map<String, Object> noticeMap) throws Exception {
	        noticeDAO.updateNotice(noticeMap);
	    }
	 //게시글 상세보기시에 조회수 증가 기능
		@Override
		public void updateViews(int notice_no) throws DataAccessException {
			noticeDAO.updateViews(notice_no);
		}
	
	
}
