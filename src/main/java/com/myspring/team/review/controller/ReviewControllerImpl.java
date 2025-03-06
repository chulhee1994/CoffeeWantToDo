package com.myspring.team.review.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.common.interceptor.BaseController;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.order.vo.OrderVO;
import com.myspring.team.review.service.ReviewService;
import com.myspring.team.review.vo.ImageFileVO;
import com.myspring.team.review.vo.ReviewVO;

@RequestMapping("/review")
@Controller("reviewController")
public class ReviewControllerImpl extends BaseController implements ReviewController{
	
	public static final String REVIEW_IMAGE_PATH ="C:\\shopping\\review_repo";
	
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReviewVO reviewVO;
	
	
		@Override
		@RequestMapping(value="/reviewLists.do", method = RequestMethod.GET)
		public  ModelAndView reviewList(HttpServletRequest req, HttpServletResponse res) throws Exception{
			ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
			
			 String _section = req.getParameter("section");
			    String _pageNum = req.getParameter("pageNum");
			    
			    int section = 1;
			    int pageNum = 1;
	
			    try {
			        if (_section != null && !_section.isEmpty()) {
			            section = Integer.parseInt(_section);
			        }
			        if (_pageNum != null && !_pageNum.isEmpty()) {
			            pageNum = Integer.parseInt(_pageNum);
			        }
			    } catch (NumberFormatException e) {
			        System.out.println("페이지 번호 형식 오류: " + e.getMessage());
			    }
	
			    System.out.println("section: " + section);
			    System.out.println("pageNum: " + pageNum);
	
			    Map<String, Object> pagingMap = new HashMap<>();
			    pagingMap.put("section", section);
			    pagingMap.put("pageNum", pageNum);
			    
			    Map reviewsMap = reviewService.reviewLists(pagingMap);
			    reviewsMap.put("section", section);
			    reviewsMap.put("pageNum", pageNum);
			    
			    List<ReviewVO> reviewsList = (List<ReviewVO>) reviewsMap.get("reviewList");
			    List<String> reviewNoList = new ArrayList<String>();
			    for (ReviewVO review : reviewsList) {
			    	String path = URLEncoder.encode(REVIEW_IMAGE_PATH+File.separator +  review.getReview_no(),StandardCharsets.UTF_8);
			    	reviewNoList.add(path);
			        System.out.println(reviewsList.toString()); 
			    }
			    
			    System.out.println(reviewsMap);
			    
			   mav.addObject("reviewsMap",reviewsMap);
			   mav.addObject("reviewNoList", reviewNoList);
			return mav;
		}
		
		@Override
		@RequestMapping(value = "/searchReviewLists.do", method = {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView searchReviewLists(@RequestParam Map<String, String> searchParams, HttpServletRequest req) throws Exception {
		    ModelAndView mav = new ModelAndView((String) req.getAttribute("viewName"));

		    // ✅ 페이징 관련 파라미터 추가 (section과 pageNum을 안전하게 처리)
		    int section = 1;
		    int pageNum = 1;

		    if (searchParams.get("section") != null && !searchParams.get("section").isEmpty()) {
		        section = Integer.parseInt(searchParams.get("section"));
		    }
		    if (searchParams.get("pageNum") != null && !searchParams.get("pageNum").isEmpty()) {
		        pageNum = Integer.parseInt(searchParams.get("pageNum"));
		    }

		    String searchQuery = searchParams.get("searchQuery");
		    if (searchQuery == null || searchQuery.trim().isEmpty()) {
		        searchQuery = "%";  // 모든 레시피 검색
		    }
		    
		    // ✅ 검색어 및 검색 타입을 Map에 저장
		    Map<String, Object> searchMap = new HashMap<>();
		    searchMap.put("searchType", searchParams.get("searchType"));
		    searchMap.put("searchQuery", searchParams.get("searchQuery"));
		    searchMap.put("section", section);
		    searchMap.put("pageNum", pageNum);
		    System.out.println(" 검색 타입: " + searchParams.get("searchType"));
		    System.out.println(" 검색어: " + searchParams.get("searchQuery"));

		    // ✅ 검색 결과 가져오기 (Service 호출)
		    Map<String, Object> reviewsMap = reviewService.searchReviewLists(searchMap);

		    // ✅ 디버깅용 로그 출력
		    System.out.println("검색 타입: " + searchMap.get("searchType"));
		    System.out.println("검색어: " + searchMap.get("searchQuery"));
		    System.out.println("Section: " + section);
		    System.out.println("PageNum: " + pageNum);
		    System.out.println("검색 결과 개수: " + ((List<ReviewVO>) reviewsMap.get("reviewList")).size());
		    System.out.println("toReviews : " + reviewsMap.get("toReviews"));
		    // ✅ 검색 결과를 ModelAndView에 추가
		    mav.addObject("reviewsMap", reviewsMap);
		    mav.addObject("searchType", searchMap.get("searchType"));
		    mav.addObject("searchQuery", searchMap.get("searchQuery"));
		    mav.addObject("section", section);
		    mav.addObject("pageNum", pageNum);


		    
		    return mav;
		}
		
		@Override
	    @RequestMapping(value = "/reviewForm.do", method = RequestMethod.GET)
	    public ModelAndView reviewForm(HttpServletRequest req, HttpServletResponse res) throws Exception {
	        ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
	        HttpSession session =  req.getSession();
	        MemberVO memberVO = (MemberVO) session.getAttribute("member");
	        String mem_id = (String)session.getAttribute("mem_id");

	        res.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = res.getWriter();

	     // ✅ 로그인 상태 확인
	        if (memberVO == null) {
	            out.println("<script>");
	            out.println("alert('로그인 상태가 아닙니다.');");
	            out.println("location.href='" + req.getContextPath() + "/member/loginForm.do';");
	            out.println("</script>");
	            out.flush();
	            out.close();
	            return null;
	        }

	        // ✅ 회원 등급 확인
	        String memGrade = memberVO.getMem_grade().trim();
	        if ("common".equals(memGrade.trim()) ) {
	            mav.setViewName((String) req.getAttribute("viewName")); // 레시피 작성 폼으로 이동
	            mav.addObject("mem_id", mem_id);
	            mav.addObject(memberVO);
	            return mav;
	        } else {
	            out.println("<script>");
	            out.println("alert('사용자만 글 작성이 가능합니다..');");
	            out.println("location.href='" + req.getContextPath() + "/review/reviewLists.do';");
	            out.println("</script>");
	            out.flush();
	            out.close();
	            return null;
	        }

	    }
	
	@Override
	@Transactional
	@RequestMapping(value = "/addReview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> addReview(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
	    ResponseEntity<String> resEnt;
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=utf-8");
	    
	   String mem_id = (String)req.getSession().getAttribute("mem_id");
	   int order_id = 0;
	    
	    try {
	        Map<String, Object> reviewsMap = new HashMap<>();
	        Enumeration<String> enu = req.getParameterNames();

	        while (enu.hasMoreElements()) {
	            String name = enu.nextElement();
	            String value = req.getParameter(name).trim();
	            reviewsMap.put(name, value);
	            System.out.println("이름 : " + name + " 값: " + value);
	        }

	        // 🚨 제목과 내용이 없으면 등록 불가
	        if (!reviewsMap.containsKey("review_title") || reviewsMap.get("review_title").toString().isEmpty() ||
	            !reviewsMap.containsKey("review_content") || reviewsMap.get("review_content").toString().isEmpty()) {

	            String errorMessage = "<script>";
	            errorMessage += "alert('제목과 내용을 입력해야 합니다.');";
	            errorMessage += "location.href='" + req.getContextPath() + "/review/reviewLists.do';";
	            errorMessage += "</script>";

	            return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	        }

	        // ✅ 리뷰 정보 저장 후 review_no 생성
	        int review_no = reviewService.addReview(reviewsMap);
	        System.out.println("생성된 리뷰 번호 : " + review_no);

	        // ✅ 파일 업로드 처리
	        List<MultipartFile> files = req.getFiles("images"); // 여러 개의 파일 가져오기
	        String filePath = REVIEW_IMAGE_PATH + File.separator + review_no;
	        File folder = new File(filePath);
	        if (!folder.exists()) {
	            folder.mkdirs(); // 폴더 생성
	        }

	        // ✅ 파일 저장 및 DB 입력
	        int index = 0;
	        boolean hasImage = false; // 이미지 업로드 여부 체크
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	            	hasImage = true;
	                String originalFilename = file.getOriginalFilename();
	                File uploadFile = new File(filePath + File.separator + originalFilename);
	                file.transferTo(uploadFile);

	                // ✅ 첫 번째 파일은 main_image, 이후 파일은 detail_image1, detail_image2...
	                String fileType = (index == 0) ? "main_image" : "detail_image" + index;

	                // ✅ DB 저장
	                Map<String, Object> imageMap = new HashMap<>();
	                imageMap.put("fileName", originalFilename);
	                imageMap.put("review_no", review_no);
	                imageMap.put("fileType", fileType);

	                reviewService.addReviewImage(imageMap); // DB에 저장
	                index++; // 다음 이미지 인덱스 증가
	            }
	        }

	        // 이미지 포함여부에 따라 다르게 설정하기
	        //포인트내역에 행추가랑 멤버에 포인트 추가하기
	        String message = "<script>";
	        if (hasImage) {
	            message += "alert('이미지 리뷰 작성으로 500포인트 적립했습니다.');";
	            memberService.updateMemberPoint(mem_id, 500);
	            memberService.updateMemberPointHistory(mem_id, 500, "리뷰 작성", order_id);
	        } else {
	            message += "alert('리뷰를 작성했습니다.');";
	        }
	        message += "location.href='" + req.getContextPath() + "/review/reviewLists.do';";
	        message += "</script>";

	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.CREATED);

	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.CREATED);
	    } catch (Exception e) {
	        e.printStackTrace();

	        //  예외 발생 시 리스트로 이동
	        String errorMessage = "<script>";
	        errorMessage += "alert('리뷰 작성 중 오류가 발생했습니다.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/review/reviewLists.do';";
	        errorMessage += "</script>";

	        resEnt = new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }

	    return resEnt;
	}


	
	
	
	@Override
	@RequestMapping(value="/reviewGoods.do" , method = RequestMethod.GET)
	public ModelAndView reviewProducts(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		MemberVO memberVO = (MemberVO)req.getSession().getAttribute("member");
		String mem_id = memberVO.getMem_id();
		
		
		List reviewList = reviewService.selectPossibleReviewList(mem_id);
		for(Object vo : reviewList) {
			vo.toString();
		}
		System.out.println(reviewList.toString());
		
		
		ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
		mav.addObject("reviewList", reviewList);
		return mav;
	}

	@Override
	@RequestMapping(value = "/viewReview.do" , method = RequestMethod.GET)
	public ModelAndView viewReview(@RequestParam int review_no, HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("받아온 review_no : " + review_no);
		ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
		
		HttpSession session = req.getSession();
	    String mem_id = (String) session.getAttribute("mem_id");
		
	    if (reviewVO == null) {
	        System.out.println("reviewVO가 NULL입니다. review_no: " + review_no);
	    } else {
	        System.out.println("조회된 review_no: " + reviewVO.getReview_no());
	    }
	    
	    
	    //쿠키가 없으면 조회수 증가
	    String review_id = "review_" + review_no;
	    boolean exists = false;

	    // 요청자의 기존 쿠키 확인
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals(review_id)) {
	            	exists = true;
	                break;
	            }
	        }
	    }

	    // ✅ 쿠키가 없으면 조회수 증가 & 쿠키 생성
	    if (!exists) {
	        reviewService.updateViews(review_no);  // 조회수 증가
	        Cookie newCookie = new Cookie(review_id, "viewed");
	        newCookie.setMaxAge(24 * 60 * 60); // 1일 (24시간) 유지
	        newCookie.setPath("/"); // 모든 경로에서 유효하도록 설정
	        res.addCookie(newCookie); // 쿠키 저장
	    }
	    
	    
	    
	    
		
	    ReviewVO reviewVO =  reviewService.viewReview(review_no);
	    
	    
	    System.out.println("review_no : "+reviewVO.getReview_no());
	    List<ImageFileVO> reviewImages = reviewService.selectReviewImages(review_no);
	    String filePath = URLEncoder.encode(REVIEW_IMAGE_PATH + File.separator + review_no, StandardCharsets.UTF_8);
	    mav.addObject("reviewImages", reviewImages);
		mav.addObject("reviewVO", reviewVO);
	    mav.addObject("filePath", filePath);
	    mav.addObject("mem_id", mem_id);

		return mav;
	
	}
	@Override
	@RequestMapping(value="/editReview.do", method = RequestMethod.GET )
	public ModelAndView editReview(@RequestParam int review_no, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
		
		ReviewVO reviewVO =  reviewService.viewReview(review_no);
	    List<ImageFileVO> reviewImages = reviewService.selectReviewImages(review_no);
	    String filePath = URLEncoder.encode(REVIEW_IMAGE_PATH + File.separator + review_no, StandardCharsets.UTF_8);

	    mav.addObject("reviewImages", reviewImages);
		mav.addObject("reviewVO", reviewVO);
	    mav.addObject("filePath", filePath);
		
		return mav;
	}
	
	@Override
	@Transactional
	@RequestMapping(value = "/updateReview.do", method = {RequestMethod.POST})
	public ResponseEntity<String> updateReview(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
	    ResponseEntity<String> resEnt;
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=UTF-8");

	    try {
	        // ✅ 기존 리뷰 정보 및 파라미터 수집
	        Map<String, Object> reviewMap = new HashMap<>();
	        Enumeration<String> enu = req.getParameterNames();

	        while (enu.hasMoreElements()) {
	            String name = enu.nextElement();
	            String value = req.getParameter(name).trim();
	            reviewMap.put(name, value);
	        }

	        int review_no = Integer.parseInt((String) reviewMap.get("review_no"));

	        // ✅ 기존 등록된 이미지 가져오기
	        List<ImageFileVO> existingImages = reviewService.selectReviewImages(review_no);

	        // ✅ 기존 main_image 찾기
	        String mainImageFileName = "";
	        for (ImageFileVO image : existingImages) {
	            if ("main_image".equals(image.getFileType())) {
	                mainImageFileName = image.getFileName();
	                break;
	            }
	        }

	        // ✅ 삭제할 이미지 목록 처리
	        String[] deleteImageNames = req.getParameterValues("deleteImage");
	        List<String> deletedFileNames = new ArrayList<>();
	        if (deleteImageNames != null) {
	            deletedFileNames.addAll(Arrays.asList(deleteImageNames));
	        }

	        // ✅ main_image가 삭제 요청되었을 경우 제외 (삭제 방지)
	        deletedFileNames.remove(mainImageFileName);

	        // ✅ DB에서 이미지 삭제
	        for (String deleteFileName : deletedFileNames) {
	            reviewService.deleteReviewImage(review_no, deleteFileName);
	            File file = new File(REVIEW_IMAGE_PATH + File.separator + review_no + File.separator + deleteFileName);
	            if (file.exists()) {
	                file.delete();
	            }
	        }

	        // ✅ 새로운 이미지 업로드 처리
	        List<MultipartFile> newImages = req.getFiles("images");
	        String filePath = REVIEW_IMAGE_PATH + File.separator + review_no;
	        File folder = new File(filePath);
	        if (!folder.exists()) {
	            folder.mkdirs();
	        }

	        // ✅ 기존 main_image가 있는지 여부 확인
	        boolean hasMainImage = !mainImageFileName.isEmpty();

	        int index = 0; //  새 이미지의 인덱스 관리
	        for (MultipartFile file : newImages) {
	            if (!file.isEmpty()) {
	                String originalFilename = file.getOriginalFilename();
	                File uploadFile = new File(filePath + File.separator + originalFilename);
	                file.transferTo(uploadFile);

	                // ✅ 첫 번째 이미지가 main_image가 되는 조건 수정
	                String fileType;
	                if (!hasMainImage && index == 0) {
	                    fileType = "main_image"; // 기존 main_image가 없는 경우 첫 번째 이미지 main_image 설정
	                    hasMainImage = true; // main_image가 추가되었으므로 true 설정
	                } else {
	                    fileType = "detail_image" + (index + 1);
	                }

	                Map<String, Object> imageMap = new HashMap<>();
	                imageMap.put("review_no", review_no);
	                imageMap.put("fileName", originalFilename);
	                imageMap.put("fileType", fileType);

	                reviewService.addReviewImage(imageMap);
	                index++;
	            }
	        }

	        // ✅ 리뷰 정보 업데이트
	        reviewService.updateReview(reviewMap);

	        // ✅ 성공 메시지 반환
	        String message = "<script>";
	        message += "alert('리뷰가 성공적으로 수정되었습니다.');";
	        message += "location.href='" + req.getContextPath() + "/review/reviewLists.do';";
	        message += "</script>";

	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 🚨 예외 발생 시 리스트로 이동
	        String errorMessage = "<script>";
	        errorMessage += "alert('리뷰 수정 중 오류가 발생했습니다.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/review/reviewLists.do';";
	        errorMessage += "</script>";

	        resEnt = new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }
	    return resEnt;
	}



	
	
	
	
	@Override
	@RequestMapping(value = "/incrementLike.do", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> incrementLike(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws Exception {
	    Map<String, Object> response = new HashMap<>();

	    String mem_id = (String) session.getAttribute("mem_id");
	    try {
	        // 사용자 ID 가져오기 (세션에서 불러오기)
	        if (mem_id == null) {
	            response.put("success", false);
	            response.put("message", "로그인이 필요합니다.");
	            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
	        }

	        int review_no = Integer.parseInt(req.getParameter("review_no"));
	        String cookieName = "liked_review_" + review_no;

	        // 쿠키 확인하여 이미 좋아요 눌렀는지 체크
	        Cookie[] cookies = req.getCookies();
	        if (cookies != null) {
	            for (Cookie cookie : cookies) {
	                if (cookie.getName().equals(cookieName) && cookie.getValue().equals(mem_id)) {
	                    response.put("success", false);
	                    response.put("message", "이미 좋아요를 누른 게시글입니다.");
	                    return new ResponseEntity<>(response, HttpStatus.OK);
	                }
	            }
	        }

	        // 좋아요 증가
	        reviewService.incrementLike(review_no);

	        // 좋아요 쿠키 생성 (30일 유지)
	        Cookie likeCookie = new Cookie(cookieName, mem_id);
	        likeCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 유지
	        likeCookie.setPath("/"); // 모든 경로에서 접근 가능하도록 설정
	        res.addCookie(likeCookie);

	        // 성공 응답
	        response.put("success", true);
	        response.put("message", "좋아요를 반영했습니다.");
	        response.put("review_no", review_no);

	        return new ResponseEntity<>(response, HttpStatus.OK);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류 발생: " + e.getMessage());
	        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	@Override
	@RequestMapping(value = "/deleteReview.do", method = RequestMethod.GET)
	public ResponseEntity deleteReview(@RequestParam int review_no, HttpServletRequest req, HttpServletResponse res) throws Exception{
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=UTF-8");
		
		try {
			MemberVO memberVO = (MemberVO)req.getSession().getAttribute("member");
			reviewVO = reviewService.viewReview(review_no);
			
			  StringBuilder message = new StringBuilder();
		        message.append("<script>");

			
			if(memberVO==null) {
				  message.append("alert('세션에 저장된 정보가 없습니다.');");
		            message.append("location.href='").append(req.getContextPath()).append("/review/reviewLists.do';");
		            message.append("</script>");
				return new ResponseEntity<>(message, headers, HttpStatus.FORBIDDEN);

			}
			//세션이랑 게시글 멤버의 회원값이 같을떄만 삭제 시도
			
			if(memberVO.getMem_id().trim().equals(reviewVO.getMem_id().trim())) {
				reviewService.deleteReview(review_no, REVIEW_IMAGE_PATH+ File.separator + review_no);
				System.out.println("리뷰 삭제에 성공 하였습니다. ");
				 message.append("alert('리뷰와 관련된 모든 데이터가 삭제되었습니다.');");
		         message.append("location.href='").append(req.getContextPath()).append("/review/reviewLists.do';");
			}else {
	            message.append("alert('삭제 권한이 없습니다.');");
	            message.append("location.href='").append(req.getContextPath()).append("/review/viewReview.do?review_no=").append(review_no).append("';");
	        }
			 message.append("</script>");
			return new ResponseEntity<>(message, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			System.out.println("리뷰 삭제에 실패하였습니다. ");
			  e.printStackTrace();
		        StringBuilder errorMessage = new StringBuilder();
		        errorMessage.append("<script>");
		        errorMessage.append("alert('삭제 중 오류가 발생했습니다.');");
		        errorMessage.append("location.href='").append(req.getContextPath()).append("/review/viewReview.do?review_no=").append(review_no).append("';");
		        errorMessage.append("</script>");

		        return new ResponseEntity<>(errorMessage, headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}

	
	
	
	
	
}
