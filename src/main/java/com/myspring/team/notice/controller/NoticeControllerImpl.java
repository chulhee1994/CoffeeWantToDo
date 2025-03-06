package com.myspring.team.notice.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.common.FileUtil;
import com.myspring.team.common.interceptor.BaseController;
import com.myspring.team.goods.vo.ImageFileVO;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.notice.service.NoticeService;
import com.myspring.team.notice.vo.NoticeVO;



@Controller
@RequestMapping(value = "/notice")
public class NoticeControllerImpl extends BaseController implements NoticeController  {
	
	private static final String NOTICE_IMAGE_PATH = "C:\\shopping\\notice_repo";
	
	@Autowired
	private NoticeService noticeService;

	@Autowired
	private NoticeVO noticeVO;
	
	@Override
	@RequestMapping(value = "/noticeLists.do",method = {RequestMethod.GET,RequestMethod.POST})
	//공지사항 게시판 리스트 전체 출력
	public ModelAndView listNotices(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String _section = req.getParameter("section");
		String _pageNum = req.getParameter("pageNum");
		int section = Integer.parseInt(((_section == null) ?"1" :_section));
		int pageNum = Integer.parseInt(((_pageNum == null) ?"1" :_pageNum));
		 
		System.out.println("section :" + section);
		System.out.println("pageNum :" + pageNum);
		
		Map pagingMap = new HashMap();
		pagingMap.put("section",section);
		pagingMap.put("pageNum", pageNum);
		
		Map noticesMap = noticeService.listNotices(pagingMap);
		noticesMap.put("section",section);
		noticesMap.put("pageNum", pageNum);
		
		String viewName = (String)req.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		mav.addObject("noticesMap", noticesMap);
		return mav;
		
	}
	@Override
	@RequestMapping(value = "/searchNoticeLists.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView searchNoticeLists(@RequestParam Map<String, String> searchParams, HttpServletRequest req) {
	    ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));

	    // ✅ 페이징 관련 파라미터 추가 (section과 pageNum을 안전하게 처리)
	    int section = 1;
	    int pageNum = 1;

	    if (searchParams.get("section") != null && !searchParams.get("section").isEmpty()) {
	        section = Integer.parseInt(searchParams.get("section"));
	    }
	    if (searchParams.get("pageNum") != null && !searchParams.get("pageNum").isEmpty()) {
	        pageNum = Integer.parseInt(searchParams.get("pageNum"));
	    }

	    // ✅ 검색어 및 검색 타입을 Map에 저장
	    Map<String, Object> searchMap = new HashMap<>();
	    searchMap.put("searchType", searchParams.get("searchType"));
	    searchMap.put("searchQuery", searchParams.get("searchQuery"));
	    searchMap.put("section", section);
	    searchMap.put("pageNum", pageNum);

	    // ✅ 검색 결과 가져오기
	    Map<String, Object> noticesMap = noticeService.searchNoticeLists(searchMap);

	    // ✅ 디버깅용 로그 출력
	    System.out.println("검색 타입: " + searchMap.get("searchType"));
	    System.out.println("검색어: " + searchMap.get("searchQuery"));
	    System.out.println("Section: " + section);
	    System.out.println("PageNum: " + pageNum);
	    System.out.println("검색 결과 개수: " + ((List<NoticeVO>) noticesMap.get("noticesList")).size());

	    // ✅ 검색 결과를 ModelAndView에 추가
	    mav.addObject("noticesMap", noticesMap);
	    mav.addObject("searchType", searchMap.get("searchType"));
	    mav.addObject("searchQuery", searchMap.get("searchQuery"));
	    mav.addObject("section", section);
	    mav.addObject("pageNum", pageNum);

	    return mav;
	}




	
	
	@Override
	@RequestMapping(value = "/noticeForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	//공지시항 글 작성 폼 출력
	public ModelAndView noticeForm(HttpServletRequest req , HttpServletResponse res) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		MemberVO memberVO =  (MemberVO)session.getAttribute("member");
		res.setContentType("text/html; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		
		// 세션이 없으면 (로그인 안 된 상태)
	    if (memberVO == null) {
	        out.println("<script>");
	        out.println("alert('로그인 상태가 아닙니다.');");
	        out.println("location.href='" + req.getContextPath() + "/member/loginForm.do';"); // 공지사항 리스트 페이지로 이동
	        out.println("</script>");
	        out.flush();
	        return null;
	    }
		
		//관리자일경우 글작성폼으로 이동
		if(memberVO.getMem_grade().trim().equals("admin")) {
			mav.setViewName((String)req.getAttribute("viewName"));
			mav.addObject(memberVO);
			return mav;
		}else {
		//관리자 의외의 사용자는 alter창으로 관리자만 사용 가능합니다. 창으로 띄어주고 공지리스트 페이지로 이동
		
			out.println("<script>");
			out.println("alert('관리자만 글작성 가능합니다.');");
			out.println("location.href='" + req.getContextPath() + "/notice/noticeLists.do';"); // 공지사항 리스트 페이지로 이동
			out.println("</script>");
			out.flush();
			  return null;
		}
	}
	
	
	@Override
	@RequestMapping(value = "/addNotice.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity addNotice(MultipartHttpServletRequest req, HttpServletResponse res) {
	    ResponseEntity resEnt;
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=utf-8");

	    try {
	    	MemberVO memberVO = (MemberVO)req.getSession().getAttribute("member");
	    	
	    	if(memberVO == null || !memberVO.getMem_grade().equals("admin")) {
	    	     String errorMessage = "<script>";
		            errorMessage += "alert('관리자만 글작성이 가능합니다.');";
		            errorMessage += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
		            errorMessage += "</script>";

		            return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    		
	    	}
	    	
	    	
	        Map<String, Object> noticeMap = new HashMap<>();
	        Enumeration<String> enu = req.getParameterNames();

	        while (enu.hasMoreElements()) {
	            String name = enu.nextElement();
	            String value = req.getParameter(name).trim();
	            System.out.println(name + " : " + value);
	            noticeMap.put(name, value);
	        }

	        // 🚨 제목과 내용이 없으면 등록 불가
	        if (!noticeMap.containsKey("notice_title") || noticeMap.get("notice_title").toString().isEmpty() ||
	            !noticeMap.containsKey("notice_content") || noticeMap.get("notice_content").toString().isEmpty()) {

	            String errorMessage = "<script>";
	            errorMessage += "alert('제목과 내용을 입력해야 합니다.');";
	            errorMessage += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
	            errorMessage += "</script>";

	            return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	        }

	        // 🚀 파일 처리 (파일이 없으면 NULL 저장)
	        MultipartFile file = req.getFile("fileName");
	        String fileName = null;

	        if (file != null && !file.isEmpty()) {
	            fileName = file.getOriginalFilename();
	        }

	        // 📌 파일명을 noticeMap에 추가 (DB 저장 전)
	        noticeMap.put("fileName", fileName);

	        // 🚀 공지사항 등록
	        int notice_no = noticeService.addNotice(noticeMap); // 📌 DB 저장

	        // 🚀 파일 저장 경로 설정
	        String filePath = NOTICE_IMAGE_PATH + File.separator + notice_no;

	        // 🚀 폴더가 존재하지 않으면 생성 (파일이 없어도 폴더 생성)
	        File folder = new File(filePath);
	        if (!folder.exists()) {
	            folder.mkdirs(); // 💡 폴더가 없으면 생성
	            System.out.println("📁 폴더 생성 완료: " + filePath);
	        }

	        // 🚀 파일 업로드 실행
	        if (file != null && !file.isEmpty()) {
	            uploadToPath(req, filePath);
	            System.out.println("📂 파일 업로드 완료: " + filePath + File.separator + fileName);
	        }

	        // 🚀 성공 메시지
	        String message = "<script>";
	        message += "alert('공지글 작성이 완료되었습니다.');";
	        message += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
	        message += "</script>";

	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.CREATED);
	    } catch (Exception e) {
	        e.printStackTrace();

	        // 🚨 예외 발생 시 리스트로 이동
	        String errorMessage = "<script>";
	        errorMessage += "alert('공지글 작성 중 오류가 발생했습니다. 관리자에게 문의하세요.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
	        errorMessage += "</script>";

	        resEnt = new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }

	    return resEnt;
	}

	
	@Override
	@RequestMapping(value = "/deleteNotice.do", method = RequestMethod.GET)
	public ResponseEntity<String> deleteNotice(@RequestParam("notice_no") int notice_no, HttpServletRequest req, HttpServletResponse res) {
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=utf-8");

	    try {
	    	
	MemberVO memberVO = (MemberVO)req.getSession().getAttribute("member");
	    	
	    	if(memberVO == null || !memberVO.getMem_grade().equals("admin")) {
	    	     String errorMessage = "<script>";
		            errorMessage += "alert('관리자만 글삭제가 가능합니다.');";
		            errorMessage += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
		            errorMessage += "</script>";

		            return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    		
	    	}
	        // 🚀 1. 파일이 저장된 경로 설정
	        String filePath = NOTICE_IMAGE_PATH + File.separator + notice_no;
	        File targetFolder = new File(filePath);

	        // 🚀 2. 해당 공지사항에 포함된 파일 삭제
	        if (targetFolder.exists() && targetFolder.isDirectory()) {
	            File[] files = targetFolder.listFiles();
	            if (files != null) {
	                for (File file : files) {
	                    deleteFileToPath(file.getName(), filePath);
	                }
	            }
	            // 🚀 3. 공지사항 폴더 삭제
	            targetFolder.delete();
	        }

	        // 🚀 4. 공지사항 DB 삭제
	        noticeService.deleteNotice(notice_no);

	        // 🚀 5. 성공 메시지 및 리스트 페이지로 이동
	        String message = "<script>";
	        message += "alert('공지사항이 삭제되었습니다.');";
	        message += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
	        message += "</script>";

	        return new ResponseEntity<>(message, headers, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 🚨 오류 발생 시 알림 메시지
	        String errorMessage = "<script>";
	        errorMessage += "alert('공지사항 삭제 중 오류가 발생했습니다.');";
	        errorMessage += "history.back();"; // 이전 페이지로 이동
	        errorMessage += "</script>";
	        return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }
	}

	@RequestMapping(value = "/viewNotice.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewNotice(@RequestParam(required = false) int notice_no, HttpServletRequest req, HttpServletResponse res) {
	    ModelAndView mav = new ModelAndView((String) req.getAttribute("viewName"));

	    String encodedFileName = "";
	    if (noticeVO.getFileName() != null) {
	        encodedFileName = URLEncoder.encode(noticeVO.getFileName(), StandardCharsets.UTF_8);
	    }
		
		//조회수 증가 
		// 회원 여부와 관계없이 동일한 쿠키 키 사용
	    String notice_id = "notice_"+notice_no;

	    // 요청자의 기존 쿠키 목록 가져오기
	    Cookie[] cookies = req.getCookies();
	    boolean exists = false;
	    
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals(notice_id)) { // 특정 리뷰 ID 쿠키 확인
	                exists = true;
	                break;
	            }
	        }
	    }

	    // 쿠키가 없으면 조회수 증가
	    if (!exists) {
	        noticeService.updateViews(notice_no); // 조회수 증가
	        Cookie cookie = new Cookie(notice_id, "viewed"); // 새 쿠키 생성
	        cookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 기간: 1일 (초 단위)
	        res.addCookie(cookie); // 쿠키 저장
	    }
		//조회수 증가 
	    NoticeVO noticeVO = noticeService.selectNotice(notice_no);
	    String encodedFilePath = URLEncoder.encode(NOTICE_IMAGE_PATH + File.separator + notice_no, StandardCharsets.UTF_8);

	    mav.addObject("noticeVO", noticeVO);
	    mav.addObject("image_path", encodedFilePath);
	    mav.addObject("encodedFileName", encodedFileName);
	    
	    return mav;
	}
	@Override
	@RequestMapping(value = "/editNotice.do")
	public ModelAndView editNotice(@RequestParam(required = false) int  notice_no,HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
		 NoticeVO noticeVO =  noticeService.selectNotice(notice_no);
		
		 String encodedFileName = "";
		    if (noticeVO.getFileName() != null) {
		        encodedFileName = URLEncoder.encode(noticeVO.getFileName(), StandardCharsets.UTF_8);
		    }
		    
		    String encodedFilePath = URLEncoder.encode(NOTICE_IMAGE_PATH + File.separator + notice_no, StandardCharsets.UTF_8);

		 mav.addObject("noticeVO",noticeVO);
		 mav.addObject("image_path", encodedFilePath);
		return mav;
	}
	
	@RequestMapping(value="/updateNotice.do", method = RequestMethod.POST)
	@Override
	public ResponseEntity<String> updateNotice(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
	    ResponseEntity<String> resEnt;
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=UTF-8");

	    MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");

	    // ✅ 관리자만 수정 가능하도록 체크
	    if (memberVO == null || !memberVO.getMem_grade().equals("admin")) {
	        String errorMessage = "<script>";
	        errorMessage += "alert('관리자만 글작성이 가능합니다.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/notice/noticeLists.do';";
	        errorMessage += "</script>";
	        return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }

	    String message;
	    Map<String, Object> noticeMap = new HashMap<>();
	    Enumeration<String> enu = req.getParameterNames();

	    while (enu.hasMoreElements()) {
	        String name = enu.nextElement();
	        String value = req.getParameter(name).trim();
	        System.out.println(name + " : " + value);
	        noticeMap.put(name, value);
	    }

	    MultipartFile newFile = req.getFile("fileName"); // ✅ 새로운 파일
	    String existingFileName = req.getParameter("existingFileName"); // ✅ 기존 파일명
	    String noticeNo = (String) noticeMap.get("notice_no");

	    // ✅ 저장될 폴더 경로 설정
	    String noticeImagePath = "C:\\shopping\\notice_repo\\" + noticeNo;
	    File folder = new File(noticeImagePath);

	    // ✅ 폴더가 없으면 생성
	    if (!folder.exists()) {
	        folder.mkdirs();
	        System.out.println("📁 폴더 생성 완료: " + noticeImagePath);
	    }

	    // ✅ 기존 파일 삭제 (기존 파일명이 있을 때만 삭제)
	    if (existingFileName != null && !existingFileName.isEmpty() && newFile != null && !newFile.isEmpty()) {
	        File oldFile = new File(noticeImagePath, existingFileName);
	        if (oldFile.exists()) {
	            if (oldFile.delete()) {
	                System.out.println("🗑 기존 파일 삭제 성공: " + oldFile.getAbsolutePath());
	            } else {
	                System.out.println("❌ 기존 파일 삭제 실패: " + oldFile.getAbsolutePath());
	            }
	        }
	    }

	    // ✅ 새 파일 저장
	    if (newFile != null && !newFile.isEmpty()) {
	        String newFileName = newFile.getOriginalFilename();
	        File newSaveFile = new File(noticeImagePath, newFileName);
	        
	        try {
	            newFile.transferTo(newSaveFile);
	            noticeMap.put("fileName", newFileName); // ✅ 새로운 파일명 저장
	            System.out.println("✅ 새 파일 저장 완료: " + newSaveFile.getAbsolutePath());
	        } catch (Exception e) {
	            e.printStackTrace();
	            message = "<script>alert('파일 저장 중 오류 발생!'); history.go(-1);</script>";
	            return new ResponseEntity<>(message, headers, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        // ✅ 기존 파일이 없고 새로운 파일도 없을 경우 fileName을 빈 값으로 설정
	        if (existingFileName == null || existingFileName.isEmpty()) {
	            noticeMap.put("fileName", ""); // ✅ 기존 파일이 없을 때 빈 값 설정
	        } else {
	            noticeMap.put("fileName", existingFileName); // ✅ 기존 파일 유지
	        }
	    }

	    try {
	        // ✅ 공지사항 업데이트
	        noticeService.updateNotice(noticeMap);

	        message = "<script>alert('공지사항이 수정되었습니다.'); location.href='" + req.getContextPath() + "/notice/noticeLists.do';</script>";
	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.OK);
	    } catch (Exception e) {
	        message = "<script>alert('공지사항 수정 중 오류 발생!'); history.go(-1);</script>";
	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
	        e.printStackTrace();
	    }

	    return resEnt;
	}



	





	

	

	

}
