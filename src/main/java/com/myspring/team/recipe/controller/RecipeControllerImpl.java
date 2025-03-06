package com.myspring.team.recipe.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.DataFormatException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.common.interceptor.BaseController;
import com.myspring.team.goods.service.GoodsService;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.recipe.service.RecipeService;
import com.myspring.team.recipe.vo.CommentVO;
import com.myspring.team.recipe.vo.ImageFileVO;
import com.myspring.team.recipe.vo.RecipeVO;

@Controller
@RequestMapping("/recipe")
public class RecipeControllerImpl extends BaseController implements RecipeController {
	
	private static final String RECIPE_IMAGE_PATH ="C:\\shopping\\recipe_repo";
	
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private RecipeVO recipeVO;
	
	@Autowired
	private CommentVO commentVO;
	
	//레시피 글 전체 출력 or 옵션에 따라 출력
	    // ✅ 레시피 목록 출력
	@RequestMapping(value = "/recipeLists.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView recipeLists(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    
	    ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));

	    String _section = req.getParameter("section");
	    String _pageNum = req.getParameter("pageNum");
	    int section = Integer.parseInt(((_section == null) ? "1" : _section));
	    int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));

	    System.out.println("section: " + section);
	    System.out.println("pageNum: " + pageNum);

	    Map<String, Object> pagingMap = new HashMap<>();
	    pagingMap.put("section", section);
	    pagingMap.put("pageNum", pageNum);

	    Map<String, Object> recipesMap = recipeService.recipeLists(pagingMap);
	    recipesMap.put("section", section);
	    recipesMap.put("pageNum", pageNum);

	    // recipesMap 내용 출력
	    System.out.println("recipesMap: " + recipesMap);

	    // 개별 요소 확인 (recipesList 확인)
	    List<RecipeVO> recipesList = (List<RecipeVO>) recipesMap.get("recipesList");
	    System.out.println("Recipes List:");
	    for (RecipeVO recipe : recipesList) {
	        System.out.println(recipe.toString()); // RecipeVO에 toString()이 구현되어 있어야 함
	    }

	    mav.addObject("recipesMap", recipesMap);
	    return mav;
	}

	
	@Override
	@RequestMapping(value = "/SearchRecipeLists.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView searchRecipeLists(@RequestParam Map<String, String> searchParams, HttpServletRequest req) throws Exception {
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
	    Map<String, Object> recipesMap = recipeService.searchRecipeLists(searchMap);

	    // ✅ 디버깅용 로그 출력
	    System.out.println("검색 타입: " + searchMap.get("searchType"));
	    System.out.println("검색어: " + searchMap.get("searchQuery"));
	    System.out.println("Section: " + section);
	    System.out.println("PageNum: " + pageNum);
	    System.out.println("검색 결과 개수: " + ((List<RecipeVO>) recipesMap.get("recipesList")).size());

	    // ✅ 검색 결과를 ModelAndView에 추가
	    mav.addObject("recipesMap", recipesMap);
	    mav.addObject("searchType", searchMap.get("searchType"));
	    mav.addObject("searchQuery", searchMap.get("searchQuery"));
	    mav.addObject("section", section);
	    mav.addObject("pageNum", pageNum);


	    
	    return mav;
	}

	
	
	

	@Override
	@RequestMapping(value = "/recipeForm.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView recipeForm(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    HttpSession session = req.getSession();
	    MemberVO memberVO = (MemberVO) session.getAttribute("member");

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
	    if ("admin".equals(memGrade.trim()) || "seller".equals(memGrade.trim())) {
	        mav.setViewName((String) req.getAttribute("viewName")); // 레시피 작성 폼으로 이동
	        mav.addObject(memberVO);
	        return mav;
	    } else {
	        out.println("<script>");
	        out.println("alert('관리자 또는 판매자만 글 작성이 가능합니다.');");
	        out.println("location.href='" + req.getContextPath() + "/recipe/recipeLists.do';");
	        out.println("</script>");
	        out.flush();
	        out.close();
	        return null;
	    }
	}

	@RequestMapping(value = "/recipeGoods.do", method = RequestMethod.GET)
	public ModelAndView recipeGoods(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    
	    ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName")); // JSP 뷰 설정
	    
	    // 세션에서 mem_id 가져오기
	    HttpSession session = req.getSession();
	    String mem_id = (String) session.getAttribute("mem_id");
	    MemberVO memberVO = (MemberVO)session.getAttribute("member");
	    String role = memberVO.getMem_grade();
	    // mem_id가 없는 경우 로그인 페이지로 리다이렉트
	    if (mem_id == null) {
	        mav.setViewName("redirect:/member/login.do");
	        return mav;
	    }


	    // 상품 목록 조회
	    List<GoodsVO> goodsList;
	    if ("admin".equals(role)) {
	        goodsList = goodsService.getAllGoods(); // 모든 상품 조회
	    } else if ("seller".equals(role)) {
	        goodsList = goodsService.getGoodsBySeller(mem_id); // 해당 seller의 상품만 조회
	    } else {
	        mav.setViewName("error/accessDenied"); // 권한 없음 페이지로 이동 가능
	        return mav;
	    }

	    // 모델에 데이터 추가
	    mav.addObject("goodsList", goodsList);
	    mav.addObject("role", role);
	    return mav;
	}

	
	@Override
	@Transactional
	@RequestMapping(value = "/addRecipe.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> addRecipe(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
	    ResponseEntity<String> resEnt;
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=utf-8");

	    try {
	        Map<String, Object> recipesMap = new HashMap<>();
	        Enumeration<String> enu = req.getParameterNames();

	        while (enu.hasMoreElements()) {
	            String name = enu.nextElement();
	            String value = req.getParameter(name).trim();
	            recipesMap.put(name, value);
	        }

	        // 🚨 제목과 내용이 없으면 등록 불가
	        if (!recipesMap.containsKey("recipe_title") || recipesMap.get("recipe_title").toString().isEmpty() ||
	            !recipesMap.containsKey("recipe_content") || recipesMap.get("recipe_content").toString().isEmpty()) {

	            String errorMessage = "<script>";
	            errorMessage += "alert('제목과 내용을 입력해야 합니다.');";
	            errorMessage += "location.href='" + req.getContextPath() + "/recipe/recipeLists.do';";
	            errorMessage += "</script>";

	            return new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	        }

	        // ✅ 먼저 레시피 추가 후, 생성된 레시피 번호 가져오기
	        int recipe_no = recipeService.addRecipe(recipesMap);
	        System.out.println("생성된 레시피 번호 : "  +recipe_no);
	        // ✅ 여러 개의 파일 가져오기
	        List<MultipartFile> files = req.getFiles("fileName");
	        String filePath = RECIPE_IMAGE_PATH + File.separator + recipe_no;
	        File folder = new File(filePath);
	        if (!folder.exists()) {
	            folder.mkdirs(); // 폴더 생성
	        }

	        // ✅ 파일 업로드 및 DB 저장
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                String originalFilename = file.getOriginalFilename();
	                File uploadFile = new File(filePath + File.separator + originalFilename);
	                file.transferTo(uploadFile);

	                // ✅ 파일 정보를 DB에 저장
	                Map<String, Object> imageMap = new HashMap<>();
	                imageMap.put("fileName", originalFilename);
	                imageMap.put("recipe_no", recipe_no);
	                recipeService.addRecipeImage(imageMap);
	            }
	        }

	        // ✅ 성공 메시지
	        String message = "<script>";
	        message += "alert('레시피 글 작성이 완료되었습니다.');";
	        message += "location.href='" + req.getContextPath() + "/recipe/recipeLists.do';";
	        message += "</script>";

	        resEnt = new ResponseEntity<>(message, headers, HttpStatus.CREATED);
	    } catch (Exception e) {
	        e.printStackTrace();

	        // 🚨 예외 발생 시 리스트로 이동
	        String errorMessage = "<script>";
	        errorMessage += "alert('레시피 글 작성 중 오류가 발생했습니다.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/recipe/recipeLists.do';";
	        errorMessage += "</script>";

	        resEnt = new ResponseEntity<>(errorMessage, headers, HttpStatus.BAD_REQUEST);
	    }

	    return resEnt;
	}


	
	@Override
	@RequestMapping(value = "/viewRecipe.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewRecipe(
	        @RequestParam("recipe_no") int recipe_no,
	        @RequestParam(value = "section", required = false, defaultValue = "1") int section,
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
	        HttpServletRequest req,HttpServletResponse res) throws Exception {
	    
	    ModelAndView mav = new ModelAndView((String) req.getAttribute("viewName"));
	    
	    HttpSession session = req.getSession();
	    String mem_id = (String) session.getAttribute("mem_id");

	    System.out.println("section: " + section);
	    System.out.println("pageNum: " + pageNum);
	    
	    //쿠키가 없으면 조회수 증가
	    String recipe_id = "recipe_" + recipe_no;
	    boolean exists = false;

	    // 요청자의 기존 쿠키 확인
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals(recipe_id)) {
	            	exists = true;
	                break;
	            }
	        }
	    }

	    // ✅ 쿠키가 없으면 조회수 증가 & 쿠키 생성
	    if (!exists) {
	        recipeService.updateViews(recipe_no);  // 조회수 증가
	        Cookie newCookie = new Cookie(recipe_id, "viewed");
	        newCookie.setMaxAge(24 * 60 * 60); // 1일 (24시간) 유지
	        newCookie.setPath("/"); // 모든 경로에서 유효하도록 설정
	        res.addCookie(newCookie); // 쿠키 저장
	    }
	    
	    
	    // 📌 1️⃣ 해당 글 정보 가져오기
	    RecipeVO recipeVO = recipeService.viewRecipe(recipe_no);

	    // 📌 2️⃣ 레시피 이미지 리스트 가져오기
	    List<ImageFileVO> recipeImages = recipeService.viewRecipeImages(recipe_no);

	    // 📌 3️⃣ 파일 경로 설정 (JSP에서 사용할 `filePath`)
	    String filePath = URLEncoder.encode(RECIPE_IMAGE_PATH + File.separator + recipe_no, StandardCharsets.UTF_8);

	    // 📌 4️⃣ 페이징을 위한 `Map<String, Object>` 사용
	    Map<String, Object> pagingMap = new HashMap<>();
	    pagingMap.put("section", section);
	    pagingMap.put("pageNum", pageNum);
	    pagingMap.put("recipe_no", recipe_no);

	    // 📌 5️⃣ 댓글 목록 및 총 댓글 수 조회
	    Map<String, Object> commentsMap = recipeService.viewRecipeComment(pagingMap);

	    // 📌 6️⃣ 데이터 JSP로 전달
	    mav.addObject("recipeVO", recipeVO);
	    mav.addObject("recipeImages", recipeImages); //  이미지 리스트 추가
	    mav.addObject("filePath", filePath); //  JSP에서 사용할 파일 경로 추가
	    mav.addObject("commentsList", commentsMap.get("commentsList"));  // 댓글 리스트
	    mav.addObject("toComments", commentsMap.get("toComments"));  // 총 댓글 수
	    mav.addObject("section", section);
	    mav.addObject("pageNum", pageNum);
	    mav.addObject("mem_id", mem_id);
	    
	    System.out.println("toComments : " +commentsMap.get("toComments") );

	    return mav;
	}



	
	
	
	@Override
	@RequestMapping(value = "/editRecipe.do",  method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView editRecipe(@RequestParam(required = false) int recipe_no ,HttpServletRequest req, HttpServletResponse res) throws Exception{
		ModelAndView mav = new ModelAndView((String)req.getAttribute("viewName"));
		
		RecipeVO recipeVO = recipeService.viewRecipe(recipe_no);
		List<ImageFileVO> recipeImages = recipeService.viewRecipeImages(recipe_no);
		
	    String filePath = URLEncoder.encode(RECIPE_IMAGE_PATH + File.separator + recipe_no, StandardCharsets.UTF_8);
	    
	    
	    mav.addObject("recipeVO", recipeVO);
	    mav.addObject("recipeImages", recipeImages); // ✅ 이미지 리스트 추가
	    mav.addObject("filePath", filePath); // ✅ JSP에서 사용할 파일 경로 추가
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/updateRecipe.do", method = RequestMethod.POST)
	public ResponseEntity<String> updateRecipe(MultipartHttpServletRequest request,HttpServletResponse res) throws Exception {
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=UTF-8");
	    String message = "";
	    
	    try {
	    	
	        HttpSession session = request.getSession();
	        MemberVO loggedInUser = (MemberVO) session.getAttribute("member");
	        String userRole = loggedInUser.getMem_grade();
	        
	        // 🔹 권한 체크: 작성자 또는 관리자만 삭제 가능
	        if (!loggedInUser.equals(recipeVO.getMem_id()) && !"admin".equals(userRole)) {
	             message = "<script>alert('권한이 없습니다.'); history.go(-1);</script>";
	            return new ResponseEntity<>(message, headers, HttpStatus.FORBIDDEN);
	        }
	    	
	    	
	    	
	        // 폼 데이터 수동 추출
	        RecipeVO recipeVO = new RecipeVO();
	        String recipeNoStr = request.getParameter("recipe_no");
	        if (recipeNoStr != null && !recipeNoStr.isEmpty()) {
	            recipeVO.setRecipe_no(Integer.parseInt(recipeNoStr));
	        }
	        recipeVO.setRecipe_title(request.getParameter("title"));
	        recipeVO.setRecipe_content(request.getParameter("recipe_content"));
	        System.out.println("수정할 recipeVO : " + recipeVO);
	        Map updateMap = new HashMap();
	        
	        int recipe_no = Integer.parseInt(request.getParameter("recipe_no"));
	        String recipe_title = request.getParameter("title");
	        String recipe_content = request.getParameter("recipe_content");
	        updateMap.put("recipe_no", recipe_no);
	        updateMap.put("recipe_title", recipe_title);
	        updateMap.put("recipe_content", recipe_content);
	        // 필요한 다른 필드도 수동으로 설정 (예: goods_name 등)
	        
	        // 1. 레시피 기본 정보 업데이트
	        recipeService.updateRecipe(updateMap);
	        
	        // 🔹 3. 기존 이미지 삭제 처리 (체크된 이미지만)
	        String[] deleteImages = request.getParameterValues("deleteImage");  
	        if (deleteImages != null) {
	            for (String fileName : deleteImages) {
	                // (1) DB에서 이미지 정보 삭제
	                recipeService.deleteRecipeImage(recipe_no,fileName);

	                // (2) BaseController의 deleteFileToPath() 메서드를 호출하여 서버에서 삭제
	                String filePath = RECIPE_IMAGE_PATH + File.separator + recipe_no;  // 실제 파일 저장 경로
	                deleteFileToPath(fileName, filePath);
	            }
	        }

	        // 🔹 4. 새로운 이미지 업로드 처리
	        List<MultipartFile> files = request.getFiles("fileName");
	        if (files != null && !files.isEmpty()) {
	            String uploadDirPath = RECIPE_IMAGE_PATH + File.separator + recipe_no;
	            File uploadDir = new File(uploadDirPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }
	            
	            for (MultipartFile file : files) {
	                if (!file.isEmpty()) {
	                    String originalFilename = file.getOriginalFilename();
	                    
	                    uploadToPath(request, uploadDirPath);
	                    // 파일명 중복 방지를 위해 UUID 적용
	                    String newFileName = originalFilename;
	                    File destination = new File(uploadDir, newFileName);
	                    
	                    // (1) 파일 저장
	                    file.transferTo(destination);
	                    
	                    // (2) DB에 이미지 정보 저장
	                    ImageFileVO imageVO = new ImageFileVO();
	                    imageVO.setRecipe_no(recipe_no);
	                    imageVO.setFileName(newFileName);
	                    Map imageMap = new HashMap();
	                    imageMap.put("recipe_no", recipe_no);
	                    imageMap.put("fileName", newFileName);
	                   recipeService.addRecipeImage(imageMap);
	                }
	            }
	        }
	        
	        message = "<script>alert('레시피가 성공적으로 수정되었습니다.'); " +
	                  "location.href='" + request.getContextPath() + "/recipe/viewRecipe.do?recipe_no=" + recipeVO.getRecipe_no() + "';</script>";
	        return new ResponseEntity<>(message, headers, HttpStatus.OK);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        message = "<script>alert('레시피 수정 중 오류가 발생했습니다: " + e.getMessage() + "'); history.go(-1);</script>";
	        return new ResponseEntity<>(message, headers, HttpStatus.BAD_REQUEST);
	    }
	}



	
	
	
	@Override
	@RequestMapping(value = "/deleteRecipe.do", method = RequestMethod.GET)
	public ResponseEntity deleteRecipe(
	        @RequestParam("recipe_no") int recipe_no, 
	        HttpServletRequest req, 
	        HttpServletResponse res) throws Exception {

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/html; charset=UTF-8");

	    try {
	    	
	    	
	    	
	        HttpSession session = req.getSession();
	        MemberVO loggedInUser = (MemberVO) session.getAttribute("member");
	        String userRole = loggedInUser.getMem_grade();
	        
	        // 🔹 권한 체크: 작성자 또는 관리자만 삭제 가능
	        if (!loggedInUser.equals(recipeVO.getMem_id()) && !"admin".equals(userRole)) {
	            String message = "<script>alert('권한이 없습니다.'); history.go(-1);</script>";
	            return new ResponseEntity<>(message, headers, HttpStatus.FORBIDDEN);
	        }
	    	
	    	
	    	
	        // 이미지 경로를 컨트롤러에서 설정 후 서비스로 전달
	        String recipeImagePath = RECIPE_IMAGE_PATH + File.separator +  recipe_no;

	        // 서비스 계층에서 트랜잭션으로 삭제 처리
	        recipeService.deleteRecipe(recipe_no, recipeImagePath);

	        String message = "<script>";
	        message += "alert('레시피와 관련된 모든 데이터가 삭제되었습니다.');";
	        message += "location.href='" + req.getContextPath() + "/recipe/recipeLists.do';";
	        message += "</script>";

	        return new ResponseEntity<>(message, headers, HttpStatus.OK);

	    } catch (Exception e) {
	        e.printStackTrace();

	        String errorMessage = "<script>";
	        errorMessage += "alert('삭제 중 오류가 발생했습니다.');";
	        errorMessage += "location.href='" + req.getContextPath() + "/recipe/viewRecipe.do?recipe_no=" + recipe_no + "';";
	        errorMessage += "</script>";

	        return new ResponseEntity<>(errorMessage, headers, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	/*
	
	--------------------------구분선-------------------------------
	
	
	*/
	/*
							댓글
	*/
	
	// 댓글 추가 (AJAX 요청 처리)
	@RequestMapping(value = "/addComment.do", method = RequestMethod.POST)
	public void addComment(HttpServletRequest request, HttpServletResponse response) {
	    try {
	        request.setCharacterEncoding("UTF-8");
	        response.setContentType("application/json; charset=UTF-8");

	        int recipe_no = Integer.parseInt(request.getParameter("recipe_no"));
	        String mem_id = request.getParameter("mem_id");
	        String comment_content = request.getParameter("comment_content");

	        CommentVO comment = new CommentVO();
	        comment.setRecipe_no(recipe_no);
	        comment.setMem_id(mem_id);
	        comment.setComment_content(comment_content);

	        boolean success = recipeService.addComment(comment);
	        PrintWriter out = response.getWriter();
	        JSONObject jsonResponse = new JSONObject();

	        if (success) {
	            CommentVO newComment = recipeService.getLatestComment(recipe_no);
	            
	            if (newComment == null) {  // ✅ 최신 댓글이 NULL일 경우 빈 객체 생성
	                newComment = new CommentVO();
	                newComment.setComment_no(0);
	                newComment.setRecipe_no(recipe_no);
	                newComment.setMem_id(mem_id);
	                newComment.setComment_content(comment_content);
	            }

	            jsonResponse.put("success", true);
	            jsonResponse.put("comment_no", newComment.getComment_no());
	            jsonResponse.put("recipe_no", newComment.getRecipe_no());
	            jsonResponse.put("mem_id", newComment.getMem_id());
	            jsonResponse.put("comment_content", newComment.getComment_content());
	            jsonResponse.put("comment_writedate", newComment.getComment_writedate().toString());
	        } else {
	            jsonResponse.put("success", false);
	        }

	        out.print(jsonResponse.toString()); 
	        out.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	@Override
	@RequestMapping(value="/addReplyComment.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity addReplyComment(HttpServletRequest req) throws Exception {
	    Map<String, Object> response = new HashMap<>();

	    // ✅ 로그인 여부 확인
	    String mem_id = (String) req.getSession().getAttribute("mem_id");
	    if (mem_id == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
	    }

	    // ✅ 요청 파라미터 수동으로 받기
	    int parentCommentNo = Integer.parseInt(req.getParameter("parent_comment_no"));
	    int recipeNo = Integer.parseInt(req.getParameter("recipe_no"));
	    String commentContent = req.getParameter("comment_content");

	    // ✅ VO 객체 생성 후 데이터 설정
	    CommentVO commentVO = new CommentVO();
	    commentVO.setParent_comment_no(parentCommentNo);
	    commentVO.setRecipe_no(recipeNo);
	    commentVO.setMem_id(mem_id);
	    commentVO.setComment_content(commentContent);

	    // ✅ 서비스 호출하여 DB 저장
	    boolean isSuccess = recipeService.addReplyComment(commentVO);

	    if (isSuccess) {
	        response.put("success", true);
	        response.put("comment", commentVO);
	        return ResponseEntity.ok(response);
	    } else {
	        response.put("success", false);
	        response.put("message", "답글 작성에 실패했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}

	
	

	@RequestMapping(value = "/getComments.do", method = RequestMethod.GET)
	public void getComments(HttpServletRequest request, HttpServletResponse response) {
	    try {
	        int recipe_no = Integer.parseInt(request.getParameter("recipe_no"));
	        List<CommentVO> commentList = recipeService.getCommentsByRecipe(recipe_no);

	        JSONArray commentsArray = new JSONArray();
	        for (CommentVO comment : commentList) {
	            JSONObject commentJson = new JSONObject();
	            commentJson.put("comment_no", comment.getComment_no());
	            commentJson.put("recipe_no", comment.getRecipe_no());
	            commentJson.put("mem_id", comment.getMem_id());
	            commentJson.put("comment_content", comment.getComment_content());
	            commentJson.put("comment_writedate", comment.getComment_writedate().toString());
	            commentsArray.put(commentJson);
	        }

	        JSONObject jsonResponse = new JSONObject();
	        jsonResponse.put("comments", commentsArray);
	        
	        response.setContentType("application/json; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.print(jsonResponse.toString()); // 변경된 부분
	        out.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	@ResponseBody
	@Override
	@RequestMapping(value = "/sortComments.do", method = RequestMethod.GET)
	public Map<String, Object> sortComments(
	        @RequestParam("recipe_no") int recipe_no,
	        @RequestParam("orderBy") String orderBy,
	        @RequestParam(value = "section", required = false, defaultValue = "1") int section,
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {

	    Map<String, Object> result = new HashMap<>();
	    try {
	        // ✅ 한 페이지당 댓글 개수
	        int commentsPerPage = 10;
	        
	        // ✅ 현재 섹션의 시작 페이지 계산
	        int startPage = ((section - 1) * 10) + 1;

	        // ✅ 요청된 페이지가 현재 섹션의 시작 페이지보다 작은 경우, 섹션을 조정
	        if (pageNum < startPage) {
	            pageNum = startPage;
	        }

	        // ✅ MyBatis에 전달할 파라미터 맵 생성
	        Map<String, Object> pagingMap = new HashMap<>();
	        pagingMap.put("recipe_no", recipe_no);
	        pagingMap.put("orderBy", orderBy);
	        pagingMap.put("section", section);
	        pagingMap.put("pageNum", pageNum);

	        // ✅ Service를 통해 정렬된 댓글 목록 및 총 개수 가져오기
	        Map<String, Object> sortedCommentsMap = recipeService.getSortedComments(pagingMap);

	        result.put("success", true);
	        result.put("commentsList", sortedCommentsMap.get("commentsList"));
	        result.put("totalComments", sortedCommentsMap.get("totalComments"));
	        result.put("currentPage", pageNum);
	        result.put("currentSection", section);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	    }
	    return result;
	}

	@Override
	@ResponseBody
	 @RequestMapping(value = "/updateComment.do", method = RequestMethod.POST)
	    public Map<String, Object> updateComment(@RequestParam("comment_no") int commentNo, 
	                                             @RequestParam("action") String action, 
	                                             HttpSession session,
	                                             HttpServletRequest req,
	                                             HttpServletResponse res) throws Exception {
	        Map<String, Object> result = new HashMap<>();

	        String memId = (String) session.getAttribute("mem_id"); // 로그인 사용자 확인

	        // ✅ 서버에서 쿠키 확인 (vote_commentNo 쿠키가 존재하면 중복 추천 방지)
	        Cookie[] cookies = req.getCookies();
	        if (cookies != null) {
	            for (Cookie cookie : cookies) {
	                if (cookie.getName().equals("vote_" + commentNo)) {
	                    result.put("success", false);
	                    result.put("message", "이미 " + (cookie.getValue().equals("like") ? "추천" : "비추천") + "하셨습니다.");
	                    return result;
	                }
	            }
	        }

	        try {
	            CommentVO updatedComment = recipeService.updateComment(commentNo, action);

	            // ✅ 추천/비추천한 경우 서버에서 쿠키 설정 (1일 유지)
	            Cookie voteCookie = new Cookie("vote_" + commentNo, action);
	            voteCookie.setMaxAge(24 * 60 * 60); // 1일 (초 단위)
	            voteCookie.setPath("/"); // 모든 페이지에서 쿠키 접근 가능
	            res.addCookie(voteCookie);

	            result.put("success", true);
	            result.put("likeCount", updatedComment.getComment_like());
	            result.put("dislikeCount", updatedComment.getComment_dislike());
	            result.put("ratio", updatedComment.getRatio());
	        } catch (Exception e) {
	            result.put("success", false);
	            result.put("message", "처리 중 오류가 발생했습니다.");
	        }

	        return result;
	    }

	@Override
	@ResponseBody
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public Map<String, Object> deleteComment(@RequestParam("comment_no") int comment_no) throws Exception{
	    Map<String, Object> result = new HashMap<>();
	    try {
	        boolean success = recipeService.markCommentAsDeleted(comment_no);
	        result.put("success", success);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	    }
	    return result;
	}

	@Override
	@ResponseBody
	@RequestMapping(value="/modComment.do", method = RequestMethod.POST)
	public Map modComment(@RequestParam("comment_no") int commentNo, 
			@RequestParam("comment_content") String comment_content, 
			HttpServletRequest req,
			HttpServletResponse res) throws DataAccessException{
		 Map result = new HashMap<>();
		
		 System.out.println("받아온 commentNo : " + commentNo);
		 System.out.println("받아온 comment_content : " + comment_content);
		
		 try {
		       CommentVO commentVO =  recipeService.modComment(commentNo, comment_content);
		        // 예시: 성공 시 응답 데이터
		        result.put("success", true);
		        result.put("comment_no", commentNo);
		        result.put("comment_content", comment_content); // 수정된 댓글 내용 반환
		    } catch (Exception e) {
		        result.put("success", false);
		        result.put("message", "댓글 수정 중 오류가 발생했습니다.");
		    }
		    
		    return result;
	}






	
}
