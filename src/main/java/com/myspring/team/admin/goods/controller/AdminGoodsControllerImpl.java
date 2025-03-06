package com.myspring.team.admin.goods.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.admin.goods.service.AdminGoodsService;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;
import com.myspring.team.member.vo.MemberVO;
import com.myspring.team.common.FileUploadUtil;

@Controller("adminGoodsController")
@RequestMapping(value="/admin/goods")
public class AdminGoodsControllerImpl extends FileUploadUtil implements AdminGoodsController{
	  private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo"; // 파일 저장 경로

	    @Autowired
	    private AdminGoodsService adminGoodsService;

	    // 상품 등록 화면
	    @RequestMapping(value = "/addNewGoodsForm.do", method = {RequestMethod.GET, RequestMethod.POST})
	    public ModelAndView addNewGoodsForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        String viewName = (String) request.getAttribute("viewName");
	        return new ModelAndView(viewName);
	    }

	    // 상품과 이미지 등록 처리
	    @Override
	    @RequestMapping(value="/addNewGoods.do", method={RequestMethod.POST})
	    public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
	        multipartRequest.setCharacterEncoding("utf-8");
	        response.setContentType("text/html; charset=UTF-8");
	        String imageFileName = null;

	        Map newGoodsMap = new HashMap();
	        Enumeration enu = multipartRequest.getParameterNames();
	        while (enu.hasMoreElements()) {
	            String name = (String) enu.nextElement();
	            String value = multipartRequest.getParameter(name);
	            System.out.println("----------");
	            System.out.println(name);
	            System.out.println(value);
	            System.out.println("----------");
	            newGoodsMap.put(name, value);
	        }

	        HttpSession session = multipartRequest.getSession();
	        MemberVO memberVO = (MemberVO) session.getAttribute("member");

	        // 세션에서 memberInfo가 없으면 처리
	        if (memberVO == null) {
	            String message = "<script>";
	            message += " alert('로그인 세션이 만료되었습니다. 로그인 후 다시 시도해주세요.');";
	            message += " location.href='" + multipartRequest.getContextPath() + "/member/loginForm.do';";
	            message += "</script>";
	            return new ResponseEntity(message, HttpStatus.OK);
	        }

	        // 세션에서 가져온 memberVO를 사용
	        String sel_id = memberVO.getMem_id();

	        List<ImageFileVO> imageFileList = upload(multipartRequest);
	        if (imageFileList != null && imageFileList.size() != 0) {
	            newGoodsMap.put("imageFileList", imageFileList);
	        }

	        String message = null;
	        ResponseEntity resEntity = null;
	        HttpHeaders responseHeaders = new HttpHeaders();
	        responseHeaders.add("Content-Type", "text/html; charset=utf-8");

	        try {
	            int goods_id = adminGoodsService.addNewGoods(newGoodsMap);
	            if (imageFileList != null && imageFileList.size() != 0) {
	                for (ImageFileVO imageFileVO : imageFileList) {
	                    imageFileName = imageFileVO.getFileName();
	                    File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + imageFileName);
	                    File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
	                    FileUtils.moveFileToDirectory(srcFile, destDir, true);
	                }
	            }
	            message = "<script>";
	            message += " alert('제품 등록이 완료되었습니다');";
	            message += " location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
	            message += "</script>";
	        } catch (Exception e) {
	            if (imageFileList != null && imageFileList.size() != 0) {
	                for (ImageFileVO imageFileVO : imageFileList) {
	                    imageFileName = imageFileVO.getFileName();
	                    File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + imageFileName);
	                    srcFile.delete();
	                }
	            }

	            message = "<script>";
	            message += " alert('제품 등록에 성공하였습니다');";
	            message += " location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
	            message += "</script>";
	            e.printStackTrace();
	        }

	        resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
	        return resEntity;
	    }
	    
	    
	    @Override
		@RequestMapping(value="/addNewGoodsImage.do" ,method={RequestMethod.POST})
		public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
				throws Exception {
			System.out.println("addNewGoodsImage");
			System.out.println("addNewGoodsImage 호출됨"); // 이 로그가 출력되는지 확인

			multipartRequest.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			String imageFileName=null;
			
			Map goodsMap = new HashMap();
			Enumeration enu=multipartRequest.getParameterNames();
			while(enu.hasMoreElements()){
				String name=(String)enu.nextElement();
				String value=multipartRequest.getParameter(name);
				goodsMap.put(name,value);
			}
			
			HttpSession session = multipartRequest.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("member");
			
			
			List<ImageFileVO> imageFileList=null;
			int goods_id=0;
			try {
				imageFileList =upload(multipartRequest);
				if(imageFileList!= null && imageFileList.size()!=0) {
					for(ImageFileVO imageFileVO : imageFileList) {
						goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
						imageFileVO.setGoods_id(goods_id);
						
					}
					
				    adminGoodsService.addNewGoodsImage(imageFileList);
					for(ImageFileVO  imageFileVO:imageFileList) {
						imageFileName = imageFileVO.getFileName();
						File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
						File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
						FileUtils.moveFileToDirectory(srcFile, destDir,true);
					}
				}
			}catch(Exception e) {
				if(imageFileList!=null && imageFileList.size()!=0) {
					for(ImageFileVO  imageFileVO:imageFileList) {
						imageFileName = imageFileVO.getFileName();
						File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
						srcFile.delete();
					}
				}
				e.printStackTrace();
			}
		}
	    @RequestMapping("/modgoodsList*.do")
	    public ModelAndView getGoodsListByStatus(
	            @RequestParam(value = "goods_status", defaultValue = "Y") String goods_status, 
	            @RequestParam(value = "section", defaultValue = "1") int section,  // int로 변경
	            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,  // int로 변경
	            @RequestParam(value = "goods_category") String goods_category,  
	            HttpServletRequest request) throws Exception {

	        // 페이징을 위한 Map 설정
	        Map<String, Object> condMap = new HashMap<>();
	        condMap.put("goods_status", goods_status);
	        condMap.put("section", section);  // section은 이제 int로 처리
	        condMap.put("pageNum", pageNum);  // pageNum도 int로 처리
	        condMap.put("goods_category", goods_category);  // goods_category 추가

	        // 기존 메서드 호출 (페이징된 데이터 가져오기)
	        List<GoodsVO> goodsList = adminGoodsService.getGoodsListByStatus(condMap);

	        ModelAndView mav = new ModelAndView();
	        mav.addObject("goodsList", goodsList);  // 모델에 상품 목록 추가

	        // 요청을 기반으로 뷰 이름을 설정
	        String viewName = getViewName(request);
	        mav.setViewName(viewName);  // 동적으로 결정된 뷰 이름 설정

	        // 페이징 관련 파라미터 추가
	        mav.addObject("goods_status", goods_status);
	        mav.addObject("section", section);  // section도 int로 추가
	        mav.addObject("pageNum", pageNum);  // pageNum도 int로 추가
	        mav.addObject("goods_category", goods_category);  // goods_category 추가
	     
	        return mav;  // 페이지 이동 처리
	    }
	    @RequestMapping("/modGoodsForm.do")
	    public ModelAndView getmodgoodsForm(@RequestParam("goods_id") int goodsId, HttpServletRequest request) throws Exception {
	        // GoodsService에서 상품 상세 정보와 이미지를 구분하여 가져옴
	        GoodsVO goodsDetail = adminGoodsService.getmodgoodsForm(goodsId);

	        // 상품 정보를 제대로 가져왔는지 확인
	        if (goodsDetail == null) {
	            // 상품을 찾을 수 없으면 오류 처리
	            System.out.println("상품 상세 정보를 찾을 수 없습니다.");
	            ModelAndView mav = new ModelAndView("error"); // 오류 페이지로 리턴
	            return mav;
	        }

	        // 상품 가격이 0이면 디버깅용 메시지 출력
	        if (goodsDetail.getGoods_price() == 0) {
	            System.out.println("상품 가격이 0원으로 나왔습니다. 상품 정보: " + goodsDetail);
	        }

	        // ModelAndView 객체 생성
	        ModelAndView mav = new ModelAndView();

	        // goodsDetail 객체를 모델에 추가
	        mav.addObject("goodsDetail", goodsDetail);

	        // JSP 페이지로 포워딩
	        String viewName = getViewName(request);
	        mav.setViewName(viewName);  // "goodsDetail.jsp" 페이지로 이동

	        // 상품 이름 및 가격 출력 (디버깅용)
	        System.out.println("컨트롤러 상품 이름: " + goodsDetail.getGoods_name());
	        System.out.println("컨트롤러 상품 가격: " + goodsDetail.getGoods_price());
	 

	        // ModelAndView 반환
	        return mav;
	    }
	    
	    
	    @RequestMapping(value = "/updateGoods.do", method = RequestMethod.POST)
	    public ModelAndView updateGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
	        multipartRequest.setCharacterEncoding("utf-8");
	        response.setContentType("text/html; charset=UTF-8");

	        // 상품 정보 및 이미지 파일 추출
	        Map<String, Object> updatedGoodsMap = getGoodsMapFromRequest(multipartRequest);
	        String goodsId = updatedGoodsMap.get("goods_id").toString(); // 상품 ID를 추출
	        List<ImageFileVO> imageFileList = getImageFileList(multipartRequest, goodsId); // imageFileList에 goods_id를 전달

	        String message = null;
	        ModelAndView mav = new ModelAndView();
	        HttpHeaders responseHeaders = new HttpHeaders();
	        responseHeaders.add("Content-Type", "text/html; charset=utf-8");

	        try {
	            // 1. 상품 정보 업데이트
	            adminGoodsService.updateGoods(updatedGoodsMap);

	            // 2. 기존 이미지 삭제 (goods_id를 int로 전달)
	            adminGoodsService.deleteGoodsImage(Integer.parseInt(goodsId));

	            // 3. 이미지 파일 등록
	            if (imageFileList != null && imageFileList.size() > 0) {
	                adminGoodsService.addNewGoodsImage(imageFileList); // 이미지 등록
	                for (ImageFileVO imageFileVO : imageFileList) {
	                    String imageFileName = imageFileVO.getFileName();  // ImageFileVO에서 파일 이름 추출
	                    File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + imageFileName); // 원본 파일
	                    File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + goodsId); // 목적지 폴더

	                    // 목적지 폴더가 존재하지 않으면 생성
	                    if (!destDir.exists()) {
	                        destDir.mkdirs();
	                    }

	                    // 만약 원본 파일이 디렉토리라면 예외 처리
	                    if (srcFile.isDirectory()) {
	                        throw new IOException("Source path is a directory, expected a file.");
	                    }

	                    File destFile = new File(destDir, imageFileName); // 목적지 파일

	                    // 만약 목적지 파일이 이미 존재하면 덮어쓰기 전에 삭제
	                    if (destFile.exists()) {
	                        FileUtils.forceDelete(destFile);  // 기존 파일 삭제
	                    }

	                    // 파일을 새로운 폴더로 이동
	                    FileUtils.moveFileToDirectory(srcFile, destDir, true);
	                }
	            }

	            // 한글 URL 인코딩 적용
	            String goodsCategory = "원두";  // 한글 문자열
	            String encodedCategory = URLEncoder.encode(goodsCategory, "UTF-8");  // 인코딩

	            String redirectUrl = "/admin/goods/modgoodsListBean.do?goods_category=" + encodedCategory;
	            mav.setViewName("redirect:" + redirectUrl);  // 리다이렉트 경로 설정

	            return mav;  // 리다이렉트 진행

	        } catch (Exception e) {
	            message = "<script>";
	            message += " alert('상품 정보 업데이트에 실패하였습니다');";
	            message += " location.href='" + multipartRequest.getContextPath() + "/admin/goods/updateGoodsForm.do';";
	            message += "</script>";

	            mav.addObject("message", message);
	            mav.setViewName("common/error");  // 실패 메시지 뷰
	            e.printStackTrace();
	        }

	        return mav;
	    }


	    @RequestMapping("/NmodgoodsList.do")
	    public ModelAndView getGoodsListByStatusN(
	            @RequestParam(value = "goods_status", defaultValue = "N") String goods_status, 
	            @RequestParam(value = "section", defaultValue = "1") int section,  // int로 변경
	            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,  // int로 변경
	            @RequestParam(value = "goods_category") String goods_category,  
	            HttpServletRequest request) throws Exception {

	        // 페이징을 위한 Map 설정
	        Map<String, Object> condMap = new HashMap<>();
	        condMap.put("goods_status", goods_status);
	        condMap.put("section", section);  // section은 이제 int로 처리
	        condMap.put("pageNum", pageNum);  // pageNum도 int로 처리
	        condMap.put("goods_category", goods_category);  // goods_category 추가

	        // 기존 메서드 호출 (페이징된 데이터 가져오기)
	        List<GoodsVO> goodsList = adminGoodsService.getGoodsListByStatus(condMap);

	        ModelAndView mav = new ModelAndView();
	        mav.addObject("goodsList", goodsList);  // 모델에 상품 목록 추가

	        // 요청을 기반으로 뷰 이름을 설정
	        String viewName = getViewName(request);
	        mav.setViewName(viewName);  // 동적으로 결정된 뷰 이름 설정

	        // 페이징 관련 파라미터 추가
	        mav.addObject("goods_status", goods_status);
	        mav.addObject("section", section);  // section도 int로 추가
	        mav.addObject("pageNum", pageNum);  // pageNum도 int로 추가
	        mav.addObject("goods_category", goods_category);  // goods_category 추가
	     
	        return mav;  // 페이지 이동 처리
	    }
	    
	    

	    // 상품 삭제
	    @RequestMapping(value = "/deleteGoods.do", method = RequestMethod.GET)
	    public ResponseEntity deleteGoods(HttpServletRequest request, @RequestParam("goods_id") String goodsId) {
	        Map<String, Object> deletedGoodsMap = new HashMap<>();
	        deletedGoodsMap.put("goods_id", goodsId);

	        String message = null;
	        ResponseEntity resEntity = null;
	        HttpHeaders responseHeaders = new HttpHeaders();
	        responseHeaders.add("Content-Type", "text/html; charset=utf-8");

	        try {
	            // 상품과 관련된 이미지 파일을 DB에서 삭제
	            adminGoodsService.deleteGoods(deletedGoodsMap);

	            message = "<script>";
	            message += " alert('상품 정보가 삭제되었습니다');";
	            message += " location.href='" + request.getContextPath() + "/admin/goods/modgoodsListBean.do?goods_category=원두';";
	            message += "</script>";

	        } catch (Exception e) {
	            message = "<script>";
	            message += " alert('상품 정보 삭제에 실패하였습니다');";
	            message += " location.href='" + request.getContextPath() + "/admin/goods/deleteGoodsForm.do';";
	            message += "</script>";
	            e.printStackTrace();
	        }

	        resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
	        return resEntity;
	    }
	    
	    // 상품 검색 메서드 추가
	    @RequestMapping("/modsearchGoods.do")
	    public ModelAndView searchGoods(@RequestParam("searchQuery") String searchQuery, HttpServletRequest request) throws Exception {
	        // GoodsService에서 상품 검색 결과를 가져옴
	        List<GoodsVO> goodsList = adminGoodsService.searchGoodsByQuery(searchQuery);

	        ModelAndView mav = new ModelAndView();
	        mav.addObject("goodsList", goodsList);  // 검색된 상품 목록을 모델에 추가

	        // 검색어도 모델에 추가
	        mav.addObject("searchQuery", searchQuery);

	        // 뷰 이름 설정 (동적으로 결정된 뷰 이름)
	        String viewName = getViewName(request);
	        mav.setViewName(viewName);

	        return mav;
	    }
	    
	    // 파라미터에서 상품 정보 Map으로 추출
	    private Map<String, Object> getGoodsMapFromRequest(MultipartHttpServletRequest multipartRequest) {
	        Map<String, Object> goodsMap = new HashMap<>();
	        Enumeration<String> enu = multipartRequest.getParameterNames();
	        while (enu.hasMoreElements()) {
	            String name = enu.nextElement();
	            String value = multipartRequest.getParameter(name);
	            goodsMap.put(name, value);
	        }
	        return goodsMap;
	    }

	 // 이미지 파일 리스트 추출
	    private List<ImageFileVO> getImageFileList(MultipartHttpServletRequest multipartRequest, String goodsId) throws Exception {
	        List<ImageFileVO> fileList = new ArrayList<>();
	        Iterator<String> fileNames = multipartRequest.getFileNames();

	        while (fileNames.hasNext()) {
	            ImageFileVO imageFileVO = new ImageFileVO();
	            String fileName = fileNames.next();
	            imageFileVO.setFileType(fileName);
	            MultipartFile mFile = multipartRequest.getFile(fileName);
	            String originalFileName = mFile.getOriginalFilename();

	            imageFileVO.setFileName(originalFileName);
	            imageFileVO.setGoods_id(Integer.parseInt(goodsId)); // goods_id 설정
	            // 디버깅: imageFileVO 리스트 출력
	            System.out.println("fileName: " + imageFileVO.getFileName());
	            System.out.println("goodsId: " + imageFileVO.getGoods_id());
	            fileList.add(imageFileVO);

	            // 파일 저장
	            File file = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + originalFileName);
	            if (mFile.getSize() != 0) {
	                if (!file.exists()) {
	                    if (file.getParentFile().mkdirs()) {
	                        file.createNewFile();
	                    }
	                }
	                mFile.transferTo(new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + originalFileName));
	            }
	        }
	        return fileList;
	    }

	    // 상품 상태를 'Y'로 업데이트하는 매핑
	    @RequestMapping("/modGoodsN.do")
	    public String updateGoodsStatusToY(@RequestParam("goods_id") int goods_id) {
	        adminGoodsService.updateGoodsStatusToY(goods_id);  // Service 호출
	        return "redirect:/admin/goods/NmodgoodsList.do?goods_category=%EC%9B%90%EB%91%90";  // 상태 업데이트 후 목록 페이지로 리다이렉트
	    }
	    
		private String getViewName(HttpServletRequest request) throws Exception {
		    String contextPath = request.getContextPath();
		    String uri = request.getRequestURI();

		    if (uri.startsWith(contextPath)) {
		        uri = uri.substring(contextPath.length());
		    }
		    int end = uri.indexOf(".");
		    if (end != -1) {
		        uri = uri.substring(0, end);
		    }
		    
		    return uri;
		}

	}