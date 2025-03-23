package teamgyodong.myky.user.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.user.mapper.UserMapper;
import teamgyodong.myky.user.model.User;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;
	
	@Autowired // 세션용(중요! 유저 로그인 관련!)
	HttpSession session;
	
	@Autowired // 비빌번호 암호화 // 사용 예정
	PasswordEncoder passwordEncoder;

	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.getUser(map); // 단일객체로 받음
		
//		boolean loginFlg = false; // 해쉬화된 비밀번호 실행// if에서 국한되지 않게 loginFlg를 밖으로 뺴서 선언하자
		if(user != null) {
//			// 해쉬화된 비밀번호를 실행
//			loginFlg = passwordEncoder.matches((String)map.get("pwd"), user.getPassword());
//		}		
//		if(loginFlg) { 해시용
			System.out.println("성공");
			session.setAttribute("sessionId", user.getUserId()); //member 클래스에서 get으로 꺼내기
			session.setAttribute("sessionName", user.getUserName());
			session.setAttribute("sessionRole", user.getRole());

			session.setMaxInactiveInterval(60*60); // 60 * 60초 세션시간 정하기
			
			//session.invalidate(); //모든 세션 정보 삭제
			//session.removeAttribute("sessionId"); //1개씩 삭제할 떄
			
			
			resultMap.put("user", user);
			resultMap.put("result", "success");
		}else {
			System.out.println("실패");
			resultMap.put("result", "fail");
		}
		return resultMap;
	
	
	}
}
