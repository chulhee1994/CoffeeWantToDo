package com.myspring.team.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myspring.team.address.service.AddressService;
import com.myspring.team.address.vo.AddressVO;
import com.myspring.team.member.service.EmailService;
import com.myspring.team.member.service.MemberService;
import com.myspring.team.member.vo.MemberVO;
import com.mysql.jdbc.StringUtils;

@Controller("memberController")
public class MemberControllerImpl implements MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberControllerImpl.class);
	
    @Autowired
    private EmailService emailService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Autowired
	private AddressService addressService;
	
	//에러 테스트용
	
	@RequestMapping(value = "/member/test.do", method = RequestMethod.GET)
	public String divide() throws Exception {
        int result = 10 / 0; // 이 부분에서 ArithmeticException이 발생합니다.
        return "결과: " + result;
    }

	//로그인 폼
		@RequestMapping(value = {"/member/loginForm.do", "/member/memberForm.do"}, method = RequestMethod.GET)
		public ModelAndView form (HttpServletRequest request, HttpServletResponse response) throws Exception {
			String viewName = getViewName(request);
			ModelAndView mav = new ModelAndView();
			mav.setViewName(viewName);
			return mav;
		}


	
	@Override
	@RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberVO member, RedirectAttributes rAttr, 
	                            HttpServletRequest request, HttpServletResponse response) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    memberVO = memberService.login(member);
	    
	    if(memberVO != null) {
	        // 회원탈퇴 여부 확인
	        if ("Y".equals(memberVO.getMem_del_yn())) {
	            // 회원 탈퇴 처리된 경우
	            rAttr.addAttribute("result", "RemoveID");
	            System.out.println("#회원탈퇴 처리된 아이디 login()");
	            mav.setViewName("redirect:/member/loginForm.do");
	        } else {
	            // 로그인 성공
	            HttpSession session = request.getSession();
	            System.out.println("#로그인 성공 login()");

	            session.setAttribute("mem_id", member.getMem_id());
	            session.setAttribute("member", memberVO);
	            session.setAttribute("isLogOn", true);
	    		String mem_id = member.getMem_id(); // member 객체에서 mem_id 가져오기
	    	    List<AddressVO> addressList = addressService.getAddressByMemberId(mem_id);
	    	    session.setAttribute("addressList", addressList);	    	    
	    	    
	            if ("admin".equals(memberVO.getMem_grade())) {
                    // 포워드로 변경하여 서버에서 바로 JSP를 처리하도록 함
                    mav.setViewName("redirect:/admin/admingoodsList.do");  // adminmain.do로 포워드
                    return mav;  // 즉시 리턴하여 아래 코드 실행을 방지
                }
                
                if ("seller".equals(memberVO.getMem_grade())) {  
                    session.getAttribute("mem_id");
                    // 포워드로 변경하여 서버에서 바로 JSP를 처리하도록 함
                    mav.setViewName("redirect:/seller/sellergoodsList.do");  // sellermain.do로 포워드
                    return mav;  // 즉시 리턴하여 아래 코드 실행을 방지
                }
	            
	            String action = (String) session.getAttribute("action");
	            System.out.println("memberVO: " + memberVO);  // null이 아닌지 확인

	            session.removeAttribute("action");
	            
	            if (action != null) {
	                mav.setViewName("forward : " + action);
	            } else {
	                mav.setViewName("redirect:/main.do");	            
	            }
	        }
	    } else {
	        // 로그인 실패
	        rAttr.addAttribute("result", "loginFailed");
	        System.out.println("#로그인 실패 login()");
	        mav.setViewName("redirect:/member/loginForm.do");
	    }
	    return mav;
	}

	
	// 로그아웃
	@Override
	@RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("isLogOn");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main.do");
		return mav;
	}
	
	
	//카카오톡 사용자 회원가입 폼
	@RequestMapping(value = "/member/kakaoForm.do", method = RequestMethod.GET)
	public ModelAndView kakaoform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
	    return mav;
	}
	
	//카카오톡 사용자 회원가입 메소드
		@Override
		@RequestMapping(value="/member/addKakao.do" ,method = RequestMethod.POST)
		public ResponseEntity addKakao(@ModelAttribute("memberVO") MemberVO memberVO,
				                HttpServletRequest request, HttpServletResponse response) throws Exception {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("utf-8");
			String message = null;
			ResponseEntity resEntity = null;
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=UTF-8");
			try {			    
			    memberService.addKakao(memberVO);
			    message  = "<script>";
			    message +=" alert('추가정보를 입력받았습니다.');";
			    message += " location.href='"+request.getContextPath()+"/';";
			    message += " </script>";			  
			}catch(Exception e) {
				message  = "<script>";
			    message +=" alert('추가정보를 입력받는데 실패하였습니다.');";
			    message += " location.href='"+request.getContextPath()+"/member/kakaoForm.do';";
			    message += " </script>";
				e.printStackTrace();
			}
			resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
			return resEntity;
		}
	
	
	
	
	//일반 사용자 회원 가입
	@Override
	@RequestMapping(value="member/addCommon.do" ,method = RequestMethod.POST)
	public ResponseEntity addCommon(@ModelAttribute("memberVO") MemberVO memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			//테스트 코드
			System.out.println("-----------------------------------------");
			System.out.println(">>> mem_id: " + memberVO.getMem_id());  // mem_id 값 출력
			System.out.println("mem_pwd: " + memberVO.getMem_pwd());
			System.out.println("mem_name: " + memberVO.getMem_name());
			System.out.println("mem_gender : " + memberVO.getMem_gender());
			System.out.println("mem_tel : " + memberVO.getMem_tel1() + memberVO.getMem_tel2() + memberVO.getMem_tel3());
			System.out.println("mem_telsts: " +memberVO.getMem_telsts_yn());
			System.out.println("mem_email: " + memberVO.getMem_email1() + "@" + memberVO.getMem_email2());
			System.out.println("mem_emailsts: " + memberVO.getMem_emailsts_yn());
			System.out.println("mem_address : " + memberVO.getMem_zipcode() + memberVO.getMem_add1() + memberVO.getMem_add2() + memberVO.getMem_add3());
		    System.out.println("mem_grade : " + memberVO.getMem_grade());
		    System.out.println("-----------------------------------------");
			//
		    
		    memberService.addCommon(memberVO);
		    message  = "<script>";
		    message += " location.href='"+request.getContextPath()+"/';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('회원등록에 실패하였습니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
		// 판매자 회원 가입
		@Override
		@RequestMapping(value="member/addSeller.do" ,method = RequestMethod.POST)
		public ResponseEntity addSeller(@ModelAttribute("memberVO") MemberVO memberVO,
				                HttpServletRequest request, HttpServletResponse response) throws Exception {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("utf-8");
			String message = null;
			ResponseEntity resEntity = null;
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=utf-8");
			try {
				//테스트 코드
				System.out.println("-----------------------------------------");
				System.out.println(">>> mem_id: " + memberVO.getMem_id());  // mem_id 값 출력
				System.out.println("mem_pwd: " + memberVO.getMem_pwd());
				System.out.println("mem_name: " + memberVO.getMem_name());
				System.out.println("mem_gender : " + memberVO.getMem_gender());
				System.out.println("mem_tel : " + memberVO.getMem_tel1() + memberVO.getMem_tel2() + memberVO.getMem_tel3());
				System.out.println("mem_telsts: " +memberVO.getMem_telsts_yn());
				System.out.println("mem_email: " + memberVO.getMem_email1() + "@" + memberVO.getMem_email2());
				System.out.println("mem_emailsts: " + memberVO.getMem_emailsts_yn());
				System.out.println("mem_address : " + memberVO.getMem_zipcode() + memberVO.getMem_add1() + memberVO.getMem_add2() + memberVO.getMem_add3());
			    System.out.println("mem_grade : " + memberVO.getMem_grade());
			    System.out.println("-----------------------------------------");
			    //
			    
			    memberService.addSeller(memberVO);
			    message  = "<script>";
			    message +=" alert('판매자 등록에 성공하였습니다.');";
			    message += " location.href='"+request.getContextPath()+"/';"; //성공시 로그인페이지 날리기
			    message += " </script>";
			    
			}catch(Exception e) {
				message  = "<script>";
			    message +=" alert('판매자 등록에 실패하였습니다.');";
			    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';"; //실패시 다시 회원가입 페이지 날리기
			    message += " </script>";
				e.printStackTrace();
			}
			resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
			return resEntity;
		}
		
	// 아이디 중복 검사
	@Override
	@RequestMapping(value="/member/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("mem_id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String mem_id = request.getParameter("mem_id");
		String result = memberService.overlapped(mem_id);
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	//회원 정보 수정 폼
	@RequestMapping(value = "/member/modMemberForm.do", method = RequestMethod.GET)
	public ModelAndView modform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
	    return mav;
	}
	
	//회원 주소 정보 수정 폼
	@RequestMapping(value = "/member/modMemberAdd.do", method = RequestMethod.GET)
	public ModelAndView modDefaultAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
	    return mav;
	}
	
	//회원 주소 정보 수정 메소드
		@Override
		@RequestMapping(value = "/member/modDefaultAddress.do", method = RequestMethod.POST)
		public ModelAndView modDefaultAddress(@ModelAttribute("member") MemberVO member,
		                                HttpServletRequest request, HttpServletResponse response) throws Exception {
			HttpSession session = request.getSession();	
			MemberVO sessionMember = (MemberVO) session.getAttribute("member");
		    session.setAttribute("mem_id", member.getMem_id());
		    sessionMember.setMem_zipcode(member.getMem_zipcode());
		    sessionMember.setMem_add1(member.getMem_add1());
		    sessionMember.setMem_add2(member.getMem_add2());
		    sessionMember.setMem_add3(member.getMem_add3());
		    int result = memberService.modDefaultAddress(member);
		    // 테스트용
		    if (result > 0) {
		        System.out.println("회원 기본주소 수정 성공");
		    } else {
		        System.out.println("회원 기본주소 수정 실패");
		    }
		    session.setAttribute("member", sessionMember);
		    ModelAndView mav = new ModelAndView("redirect:/mypage/myPageUsers.do");	 
		    return mav;
		}
	
	//회원 정보 수정 메소드
	@Override
	@RequestMapping(value = "/member/modMembers.do", method = RequestMethod.POST)
	public ModelAndView modMembers(@ModelAttribute("member") MemberVO member,
	                                HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();	
		MemberVO sessionMember = (MemberVO) session.getAttribute("member");
		sessionMember.setMem_id(member.getMem_id());
		sessionMember.setMem_pwd(member.getMem_pwd());
		sessionMember.setMem_name(member.getMem_name());
		sessionMember.setMem_tel1(member.getMem_tel1());
		sessionMember.setMem_tel2(member.getMem_tel2());
		sessionMember.setMem_tel3(member.getMem_tel3());
		sessionMember.setMem_email1(member.getMem_email1());
		sessionMember.setMem_email2(member.getMem_email2());
		sessionMember.setMem_zipcode(member.getMem_zipcode());
	    sessionMember.setMem_add1(member.getMem_add1());
	    sessionMember.setMem_add2(member.getMem_add2());
	    sessionMember.setMem_add3(member.getMem_add3());
	    int result = memberService.modMembers(member);
	    session.setAttribute("member", sessionMember);
	    if (result > 0) {
	        System.out.println("회원 정보 수정 성공");
	    } else {
	        System.out.println("회원 정보 수정 실패");
	    }
	    ModelAndView mav = new ModelAndView("redirect:/mypage/myPageUsers.do");
	    return mav;
	}
	
	//개인정보 동의내역 수정 폼
	@RequestMapping(value = "/member/modInfoForm.do", method = RequestMethod.GET)
	public ModelAndView modInfoform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
	    return mav;
	}
	
	
	@Override
	@RequestMapping(value = "/member/modInfo.do", method = RequestMethod.POST)
	public ModelAndView modInfo(@ModelAttribute("member") MemberVO member, 
	                             HttpServletRequest request, HttpServletResponse response) throws Exception {

	    // 세션에서 기존 member 객체를 가져옴
	    HttpSession session = request.getSession();
	    MemberVO sessionMember = (MemberVO) session.getAttribute("member");
	    session.setAttribute("mem_id", member.getMem_id());

	    // 세션에서 가져온 객체의 기존 값들을 업데이트된 값으로 덮어씀
	    sessionMember.setMem_telsts_yn(member.getMem_telsts_yn());
	    sessionMember.setMem_emailsts_yn(member.getMem_emailsts_yn());

	    // 개인정보 동의 내역 수정 메소드 호출
	    int result = memberService.modPersonalInfo(sessionMember);   

	    if (result > 0) {
	        System.out.println("개인정보 동의내역 수정 성공");
	    } else {
	        System.out.println("개인정보 동의내역 수정 실패");
	    }

	    // 수정된 sessionMember 객체를 세션에 다시 저장
	    session.setAttribute("member", sessionMember);

	    // 페이지 리다이렉트
	    ModelAndView mav = new ModelAndView("redirect:/mypage/myPageUsers.do");
	    return mav;
	}





	//회원 탈퇴 메소드
	@Override
	@RequestMapping(value="/member/removeMember.do", method = RequestMethod.POST)
	public ModelAndView removeMember(@ModelAttribute("member") MemberVO member,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
	    HttpSession session = request.getSession();
	    MemberVO sessionMember = (MemberVO) session.getAttribute("member");
	    session.setAttribute("mem_id", member.getMem_id());
	    int result = memberService.removeMember(member); 
	      
	    if (result > 0) {
	        System.out.println("회원 탈퇴 성공");
	    } else {
	        System.out.println("회원 탈퇴 실패");
	    }
	    session.setAttribute("isLogOn", false);
		session.removeAttribute("member");
		
	    ModelAndView mav = new ModelAndView("redirect:/");
	    return mav;
	}
	

	
	
	//Form 으로 끝나는 모든 jsp호출
	@RequestMapping(value = "/member/*Form.do", method = RequestMethod.GET)
	private ModelAndView form(@RequestParam(value= "result", required = false) String result,
							  @RequestParam(value= "action", required = false) String action,	
								HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	
	//메인
	@RequestMapping(value = { "/", "/main.do"}, method = RequestMethod.GET)
	private ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("viewName", "main");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
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
	
	// 카카오 로그인 처리
    @RequestMapping(value = "/member/kakaoLogin.do")
    @ResponseBody
    public String kakaoLoginPro(HttpSession session,
                                @RequestParam("kakao_kakaoId") String kakao_kakaoId, 
                                @RequestParam("kakao_email") String kakao_email, 
                                @RequestParam("kakao_name") String kakao_name) throws Exception {

        System.out.println("kakaoLogin");

        MemberVO memberVO = new MemberVO();
        memberVO.setLoginType("kakao");
        memberVO.setMem_id(kakao_email); // 카카오 이메일로 회원 조회
        MemberVO selectMember = memberService.selectLoginInfo(memberVO);

        System.out.println(kakao_email);

        if (selectMember != null) { // 카카오 로그인 성공
            session.setAttribute("mem_id", selectMember.getMem_id());
            session.setAttribute("member", selectMember);
            session.setAttribute("isLogOn", true);
            return "success";
        } else { // 카카오 로그인 실패
            return "fail";
        }
    }

    // 아이디 찾기 처리
    @RequestMapping(value = "/member/findId.do")
    public ModelAndView findId(
             @RequestParam(value= "mem_name",defaultValue = "") String mem_name
            ,@RequestParam(value= "mem_email1",defaultValue = "") String mem_email1
            ,@RequestParam(value= "mem_email2",defaultValue = "") String mem_email2
            ,HttpServletRequest request
            ,HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);
        String isResult = "N";
        String resultMassage = "";
        
        if(!StringUtils.isNullOrEmpty(mem_name) && !StringUtils.isNullOrEmpty(mem_email1) && !StringUtils.isNullOrEmpty(mem_email2)) {
            isResult = "Y";
            MemberVO param = new MemberVO();
            param.setMem_name(mem_name);
            param.setMem_email1(mem_email1);
            param.setMem_email2(mem_email2);
            MemberVO selectMember = memberService.selectMember(param); // 아이디 찾기 서비스 호출
            
            if(selectMember != null) {
                resultMassage = "입력하신 메일로 아이디가 발송되었습니다.";
                
                // DB에서 찾은 아이디
                String userId = selectMember.getMem_id(); 
                // 사용자 이메일 (수신자 이메일)
                String userEmail = mem_email1 + "@" + mem_email2;

                // 이메일 발송
                try {
                    emailService.sendIdEmail(userEmail, mem_name, userId);  // 이메일 발송
                } catch (Exception e) {
                    resultMassage = "아이디 발송에 실패했습니다. 다시 시도해 주세요.";
                    mav.addObject("isFind", "N");
                    e.printStackTrace();
                }
                
                mav.addObject("isFind", "Y");
                
            } else {
                resultMassage = "입력된 아이디 또는 이메일로 등록된 정보가 없습니다.";
                mav.addObject("isFind", "N");
            }
        }
        mav.addObject("isResult", isResult);
        mav.addObject("resultMassage", resultMassage);
        return mav;
    }
    
    
 // 비밀번호 찾기 처리
    @Override
    @RequestMapping(value = "/member/findPwd.do")
    public ModelAndView findPwd(
             @RequestParam(value= "mem_id",defaultValue = "") String mem_id
            ,@RequestParam(value= "mem_pwd",defaultValue = "") String mem_pwd
            ,HttpServletRequest request
            ,HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);
        String isResult = "N";
        String resultMassage = "";
        
        if(!StringUtils.isNullOrEmpty(mem_id) && !StringUtils.isNullOrEmpty(mem_pwd)) {
            isResult = "Y";
            
            MemberVO param = new MemberVO();
            param.setMem_id(mem_id);
            MemberVO selectMember = memberService.selectMember(param);  // 아이디로 회원 정보 조회
            
            if(selectMember != null) {
                param.setMem_pwd(mem_pwd);
                memberService.updateMemPwd(param); // 비밀번호 수정
                resultMassage = "비밀번호가 변경되었습니다.";
                mav.addObject("isFind", "Y");
            } else {
                resultMassage = "입력된 아이디로 등록된 정보가 없습니다.";
                mav.addObject("isFind", "N");
            }
        }
        mav.addObject("isResult", isResult);
        mav.addObject("resultMassage", resultMassage);
        return mav;
    }

 // 비밀번호 변경 인증번호 발송
    @Override
    @RequestMapping(value = "/member/sendMemPwdCa.do", method = RequestMethod.POST)
    @ResponseBody
    public String sendMemPwdCa(@ModelAttribute MemberVO memberVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        System.out.println("kakaoLogin");

        MemberVO selectMember = memberService.selectMember(memberVO);  // 아이디로 회원 정보 조회

        resultMap.put("selectMember", selectMember);
        String resultCode = "500";
        String sendCode = memberVO.getSendCode(); // 인증 코드
        if(selectMember != null) {
            System.out.println("인증번호 : " + sendCode);
            
            try {
                String userEmail = selectMember.getMem_email1() + "@" + selectMember.getMem_email2(); // 이메일 조합
                emailService.sendAuthEmail(userEmail, sendCode);  // 인증 코드 이메일 발송
                resultCode = "200";  // 성공
                resultMap.put("sendCode", sendCode);  // 클라이언트에 보낼 인증 코드
            } catch (Exception e) {
                resultCode = "500";  // 이메일 발송 실패
                e.printStackTrace();
            }
        } else {
            resultCode = "400"; // 등록된 정보 없음
        }
        resultMap.put("sendCode", sendCode);
        return resultCode;
    }
  //이용약관
  	@RequestMapping(value = "/member/agreeForm.do", method = RequestMethod.GET)
  	public ModelAndView AgreeForm (HttpServletRequest request, HttpServletResponse response) throws Exception {
  		String viewName = getViewName(request);
  		ModelAndView mav = new ModelAndView();
  		mav.setViewName(viewName);
  		return mav;
  	}
  	
  	//이용약관 메소드
  	@Override
  	@RequestMapping(value = "/member/agree.do", method = RequestMethod.POST)
  	public ModelAndView agree(HttpServletRequest request, HttpServletResponse response) throws Exception {
  	    ModelAndView mav = new ModelAndView();
  	   	mav.setViewName("redirect:/member/memberForm.do");
  	    return mav;
  	}

    @Override
    @RequestMapping(value = "/member/emailVerification.do", method = RequestMethod.POST)
    public @ResponseBody String emailVerification(@RequestParam("email") String email,  // Single email address field
                                                    @RequestParam("sendCode") String sendCode,
                                                    HttpSession session) throws Exception {
        
        String resultCode = "500";
        Map<String, String> resultMap = new HashMap<>();
        
        // 이메일 주소가 비어있는지 확인
        if (email == null) {
            resultMap.put("status", "error");
            resultMap.put("message", "이메일을 입력하세요.");
            return resultCode;
        }
        
        
        
        try {
            System.out.println("인증번호 : " + sendCode);
            // 이메일로 인증번호 발송
            emailService.sendAuthEmail2(email, sendCode);  // 인증 코드 이메일 발송
            resultCode = "200";  // 성공
            resultMap.put("status", "success");
            resultMap.put("message", "인증번호가 발송되었습니다.");
            resultMap.put("sendCode", sendCode);  // 클라이언트에 보낼 인증 코드
        } catch (Exception e) {
            resultCode = "500";  // 이메일 발송 실패
            resultMap.put("status", "error");
            resultMap.put("message", "이메일 발송에 실패하였습니다.");
            e.printStackTrace();
        }
        resultMap.put("sendCode", sendCode);
        return resultCode;
        
    }
	}
