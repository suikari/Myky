package teamgyodong.myky.user.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

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
	
	//Kakao
	@Value("${client_id}")
	private String client_id;

    @Value("${redirect_uri}")
    private String redirect_uri;
	
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
    public String add(Model model) throws Exception{

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
    public String consent(Model model) throws Exception{

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

}
