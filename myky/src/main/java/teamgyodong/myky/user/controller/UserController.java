package teamgyodong.myky.user.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.user.dao.UserService;




@Controller
public class UserController {
	
	@Autowired
	UserService userService;


	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
//	private GoogleAuthExample googleAuthExample;

	
	//Kakao
	@Value("${client_id}")
	private String client_id;

    @Value("${redirect_uri}")
    private String redirect_uri;
    

	// ✅ JavaMailSender 추가
    @Autowired
    private JavaMailSender mailSender;

    
    
	
    //유저 로그인 주소
    @RequestMapping("/user/login.do") 
    public String login(Model model) throws Exception{
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
        model.addAttribute("location", location);

        return "user/login"; 
    }
	
	//유저 로그인 작동
	@RequestMapping(value = "/user/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userLogin(map); //memberLogin은 재사용은 안할꺼임
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
    
    //유저 로그인 주소
    @RequestMapping("/naverCallback.do") 
    public String naverCallback(Model model) throws Exception{
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
        model.addAttribute("location", location);

        return "user/naver/naverCallback"; 
    }
    
	// 카카오 로그인 작동
	@RequestMapping(value = "user/kakao.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwd(Model model, @RequestParam HashMap<String, Object> map , HttpSession session) throws Exception {
			
		    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	        String tokenUrl = "https://kauth.kakao.com/oauth/token";

	        RestTemplate restTemplate = new RestTemplate();
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	        params.add("grant_type", "authorization_code");
	        params.add("client_id", client_id);
	        params.add("redirect_uri", redirect_uri);
	        params.add("code", (String) map.get("code"));

	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
	        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, request, Map.class);

	        Map<String, Object> responseBody = response.getBody();
	        
	        resultMap = (HashMap<String, Object>) getUserInfo((String) responseBody.get("access_token"));
	        //return (String) responseBody.get("access_token");
	        
	        System.out.print((String) responseBody.get("access_token"));
	        
	        return new Gson().toJson(resultMap);
	}

	private Map<String, Object> getUserInfo(String accessToken) {
	    String userInfoUrl = "https://kapi.kakao.com/v2/user/me";

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setBearerAuth(accessToken);
	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    ResponseEntity<String> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, String.class);

	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        return objectMapper.readValue(response.getBody(), Map.class);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null; // 예외 발생 시 null 반환
	    }
	}
	
	//아이디 찾기 주소
	@RequestMapping("/user/findid.do") //브라우저 웹주소
    public String add(HttpServletRequest request, Model model) throws Exception{
		request.setAttribute("test", "test");
        return "user/id-find"; // member 폴더로 묶임
        }
	
	
	//비밀번호 찾기 주소
    @RequestMapping("/user/resetpwd.do") 
    public String searchPwd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map);
		request.setAttribute("map", map);
        return "user/pwd-reset"; 
    }
    
    // 비밀번호 찾기 아이디 유효성
	@RequestMapping(value = "/user/searchId.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String search(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.searchId(map); //userLogin은 재사용은 안할꺼임
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
    
    
    
    // 비밀번호 찾기 기능
	@RequestMapping(value = "/user/searchPwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.newPwd(map); //userLogin은 재사용은 안할꺼임
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
	
    //유저 회원가입 전 동의서 주소
	@RequestMapping("/user/consent.do") //브라우저 웹주소
	    public String consent(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
			request.setAttribute("map", map);

        return "user/user-consent"; // member 폴더로 묶임
        }
	
    //유저 회원가입 주소
	@RequestMapping("/user/join.do") //브라우저 웹주소
    public String add(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map); // Y,N가 담겨있다
		request.setAttribute("map", map);
        return "user/user-join"; // member 폴더로 묶임
        }
	
	//유저 회원가입
	@RequestMapping(value = "/user/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String join(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.joinUser(map);
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
	
	//아이디 중복체크
	@RequestMapping(value = "/user/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.searchId(map); // 이름 바꾼이유 아이디 조회는 여러곳에서 활용가능
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
	
	//닉네임 중복체크
	@RequestMapping(value = "/user/nickCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkNick(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.searchNick(map); // 이름 바꾼이유 아이디 조회는 여러곳에서 활용가능
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
	
	// 주소찾기
	@RequestMapping("/addr.do") //브라우저 웹주소
    public String addr(Model model) throws Exception{

        return "user/jusoPopup"; // member 폴더로 묶임
        }
	
	//마이 페이지 주소
	@RequestMapping("/user/mypage.do") //브라우저 웹주소
    public String myPage(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "user/user-mypage"; // member 폴더로 묶임
        }
	

	
	//유저 상세 정보
	@RequestMapping("/user/info.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "user/user-info"; //
    }
	
	//유저 상세 정보 출력
	@RequestMapping(value = "/user/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.getview(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 상세 정보 수정
	@RequestMapping(value = "/user/update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String edit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.editInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// controller
		@RequestMapping("/user/fileUpload.dox")
		public String fileUpload(@RequestParam("file1") MultipartFile multi, @RequestParam("userId") String userId,HttpServletRequest request,HttpServletResponse response, Model model)
		{
			String url = null;
			String path="c:\\img\\userProfile";
			try {

				//String uploadpath = request.getServletContext().getRealPath(path);
				String uploadpath = path;
				String originFilename = multi.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
				long size = multi.getSize();
				String saveFileName = Common.genSaveFileName(extName);
				
				System.out.println("uploadpath : " + uploadpath);
				System.out.println("originFilename : " + originFilename);
				System.out.println("extensionName : " + extName);
				System.out.println("size : " + size);
				System.out.println("saveFileName : " + saveFileName);
				String path2 = System.getProperty("user.dir"); // 유저 최상단 주소!
				System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
				if(!multi.isEmpty())
				{
					File file = new File(path2 + "\\src\\main\\webapp\\img\\userProFile\\", saveFileName); // 사진 저장할 장소
					multi.transferTo(file); 
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("path", "../../img/userProfile/" + saveFileName); //db에 경로 장소
					map.put("userId", userId);
					// insert 쿼리 실행
				    userService.insertImage(map);
				    
					
					model.addAttribute("filename", multi.getOriginalFilename());
					model.addAttribute("uploadPath", file.getAbsolutePath());
					
					return "redirect:/user/info.do";
					// redirect: 스프링 용어
				}
			}catch(Exception e) {
				System.out.println(e);
			}
			return "redirect:main.do";
		}
	

	//유저 탈퇴 주소
	@RequestMapping("/user/withdraw.do") 
    public String withdraw(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "user/user-withdraw"; //
    }
	
	//유저 탈퇴 비밀번호 확인
	@RequestMapping(value = "/user/IdPwdCheak.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idPwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.authIdPwd(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 탈퇴
	@RequestMapping(value = "/user/withdraw.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String withdraw(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userWithdraw(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 댓글 검색
	@RequestMapping(value = "/user/comment.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String comment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userComment(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 후원내역 출력
	@RequestMapping(value = "/user/donaInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String donation(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userDonation(map);
		return new Gson().toJson(resultMap);
	}
	
	//수의사 정보출력(타부서 요청)
	@RequestMapping(value = "/user/vetInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.vetInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// 유저 포인트 정보 출력
	@RequestMapping(value = "/user/point.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String point(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.getPoint(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 쿠폰내역 출력
	@RequestMapping(value = "/user/coupon.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String coupon(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userCoupon(map);
		return new Gson().toJson(resultMap);
	}
	
	//유저 주문 내역 출력
	@RequestMapping(value = "/user/orderList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.UserOrderList(map);
		return new Gson().toJson(resultMap);
	}
	
	
	



    // ✅ 이메일 인증 코드 전송
    @PostMapping("/email/send-auth-code")
    @ResponseBody
    public Map<String, Object> sendAuthCode(@RequestBody Map<String, String> request, HttpSession session) {
        String email = request.get("email");
        Map<String, Object> response = new HashMap<>();

        if (email == null || email.isEmpty()) {
            response.put("success", false);
            response.put("message", "이메일을 입력하세요.");
            return response;
        }

        String authCode = String.format("%06d", new Random().nextInt(1000000));
        session.setAttribute("emailAuthCode", authCode);
        session.setMaxInactiveInterval(5 * 60); // 5분 유지

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("쇼핑몰 회원가입 이메일 인증 코드");
            message.setText("인증 코드: " + authCode + "\n5분 안에 입력해 주세요.");
            mailSender.send(message);

            response.put("success", true);
            response.put("message", "인증번호가 발송되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "이메일 발송 실패: " + e.getMessage());
        }

        return response;
    }

    // ✅ 인증 코드 확인
    @PostMapping("/email/verify-auth-code")
    @ResponseBody
    public Map<String, Object> verifyAuthCode(@RequestBody Map<String, String> request, HttpSession session) {
        String inputCode = request.get("code");
        String sessionCode = (String) session.getAttribute("emailAuthCode");

        Map<String, Object> response = new HashMap<>();

        if (sessionCode == null) {
            response.put("success2", false);
            response.put("message", "인증 코드가 만료되었거나 요청되지 않았습니다.");
        } else if (sessionCode.equals(inputCode)) {
            response.put("success", true);
            response.put("message", "이메일 인증 완료!");
            session.removeAttribute("emailAuthCode");
        } else {
            response.put("success", false);
            response.put("message", "인증번호가 일치하지 않습니다.");
        }

        return response;
    }
    
    
    
    
    
    // 이메일 인증 샘플 페이지
    @RequestMapping("/emailSample.do")
    public String sample(Model model) throws Exception {
        return "user/emailSample";
    }
    
	
    //이메일 테스트용
    @PostMapping("/email/test.dox")
    @ResponseBody
    public String testEmail() {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo("glodstone1@gmail.com");  // 테스트할 이메일
            message.setSubject("야야야야야야야");
            message.setText("이메일 전송이 정상적으로 작동합니다!");
            mailSender.send(message);
            return "이메일 전송 성공!";
        } catch (Exception e) {
            return "이메일 전송 실패: " + e.getMessage();
        }
    }
	
    
    
    
    
    
    //구글 로그인
    @RequestMapping("/googleLogin")
    public String googleLogin() {
    	
        return "redirect:/oauth2/authorization/google"; // 구글 로그인 페이지로 리디렉트
    }
    
    //구글 로그아웃
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        request.logout(); // Spring Security에서 사용자 로그아웃
        return "redirect:/localhost:8081/user/login.do"; // 홈이나 원하는 경로로 리디렉션
    }
    
    
    
    
//    @RequestMapping("/user/google-user.dox")
//    public String user(@AuthenticationPrincipal OAuth2User principal) {
//    	request.setAttribute("info", principal.getAttributes());
//        return "test"; // 로그인한 사용자 정보 반환
//    }
    

	@RequestMapping(value = "/user/google-user.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String googleUserInfo(Model model, @RequestParam HashMap<String, Object> map, @AuthenticationPrincipal OAuth2User principal) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		if(principal==null) {
			return new Gson().toJson("구글 세션 정보 없음");

		}
		resultMap.put("info", principal.getAttributes());
		return new Gson().toJson(resultMap);
	}
	
	
	//구글 이메일 내용 출력
	@RequestMapping(value = "/user/socialEmail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String socialEmail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.getEmail(map);
		return new Gson().toJson(resultMap);
	}
	
	//이메일 중복체크
	@RequestMapping(value = "/user/emailCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emailCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.searchEmail(map);
		return new Gson().toJson(resultMap);
	}
	
	//멤버쉽 가입 여부 정보 출력
	@RequestMapping(value = "/user/memberShip.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.searchMemberShip(map);
		return new Gson().toJson(resultMap);
	}
    
}
