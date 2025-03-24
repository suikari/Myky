package teamgyodong.myky.user.controller;

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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	
    @RequestMapping("/user/resetPwd.do") 
    public String searchPwd(Model model) throws Exception{
		
        return "user/pwd-reset"; 
    }
    
	@RequestMapping(value = "/user/searchPwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.newPwd(map); //userLogin은 재사용은 안할꺼임
		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
	}
	
    //유저 회원가입 주소
	@RequestMapping("/user/join.do") //브라우저 웹주소
    public String add(Model model) throws Exception{

        return "user/user-join"; // member 폴더로 묶임
        }
	
	//아이디 중복체크
//	@RequestMapping(value = "/user/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		resultMap = userService.searchId(map); // 이름 바꾼이유 아이디 조회는 여러곳에서 활용가능
//		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
//	}
	
	//유저 회원가입
//	@RequestMapping(value = "/user/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		resultMap = userService.memberAdd(map);
//		return new Gson().toJson(resultMap); // json 형태로 바꿔서 리턴해주는 함수
//	}
	
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
	


}
