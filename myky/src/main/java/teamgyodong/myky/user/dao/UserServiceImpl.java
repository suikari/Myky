package teamgyodong.myky.user.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.board.model.comment;
import teamgyodong.myky.cart.mapper.CartMapper;
import teamgyodong.myky.cart.model.cart;
import teamgyodong.myky.donation.model.donation;
import teamgyodong.myky.manager.model.Vet;
import teamgyodong.myky.membership.model.Membership;
import teamgyodong.myky.pay.mapper.PayMapper;
import teamgyodong.myky.user.mapper.UserMapper;
import teamgyodong.myky.user.model.User;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;
	
	@Autowired
	PayMapper payMapper;
	
	
	@Autowired // 세션용(중요! 유저 로그인 관련!)
	HttpSession session;
	
	@Autowired // 비빌번호 암호화 // 사용 예정
	PasswordEncoder passwordEncoder;

	@Transactional //쿼리문 2개 실행하기
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.getUser(map); // 단일객체로 받음
		
	    if (user != null && "Y".equals(user.getDeleteYn())) {
	        System.out.println("실패");
	        resultMap.put("reason", "삭제된 아이디 접속 시도");
	        resultMap.put("result", "suspended");
	        return resultMap;
	    }

		boolean loginFlg = false; // 해쉬화된 비밀번호 실행// if에서 국한되지 않게 loginFlg를 밖으로 뺴서 선언하자
		
		
		if(user != null) {
//			// 해쉬화된 비밀번호를 실행
			loginFlg = passwordEncoder.matches((String)map.get("pwd"), user.getPassword());
		}		
		if(loginFlg) { //해시용
			System.out.println("성공");
			session.setAttribute("sessionId", user.getUserId()); //member 클래스에서 get으로 꺼내기
			session.setAttribute("sessionName", user.getUserName());
			session.setAttribute("sessionRole", user.getRole());

			session.setMaxInactiveInterval(60*60); // 60 * 60초 세션시간 정하기
			
			//session.invalidate(); //모든 세션 정보 삭제
			//session.removeAttribute("sessionId"); //1개씩 삭제할 떄
			
            // 5. 로그인 시간 업데이트 (트랜잭션 내 실행)
            userMapper.updateLastLogin(user.getUserId());
			
			resultMap.put("user", user);
			resultMap.put("result", "success");
		}else {
			System.out.println("실패");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	
	public HashMap<String, Object> newPwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String hashPwd = passwordEncoder.encode((String)map.get("pwd")); // 비밀번호를 넣기전에 암호화 하기
		map.put("pwd", hashPwd);
		int num =userMapper.updatePwd(map); // 중복체크용 재활용
		if(num > 0) {
			resultMap.put("result", "success");
		}else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> searchId(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectUser(map);
		
		int count = user!= null ? 1 : 0;
		resultMap.put("count", count); // 결과 값
		resultMap.put("user", user);
		return resultMap;
	}
	
	
	public HashMap<String, Object> getview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectUser(map);
		resultMap.put("user", user);
		return resultMap;
	}
	
	public HashMap<String, Object> searchNick(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectNick(map);
		
		int count = user!= null ? 1 : 0;
		resultMap.put("count", count); // 결과 값

		return resultMap;
	}

	public HashMap<String, Object> joinUser(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
		String hashPwd = passwordEncoder.encode((String)map.get("pwd")); // 비밀번호를 넣기전에 암호화 하기
		map.put("pwd", hashPwd);
		payMapper.insertPoint(map);
		int num = userMapper.insertUser(map); //int형으로 받아내기
		resultMap.put("result", "success");
		// if num > 0 데이터 삽입 잘 된거
		// 아니면 뭔가 문제 있는거 확인이 가능
		return resultMap;
	}
	
	public HashMap<String, Object> editInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userMapper.updateInfo(map);
		System.out.println("key ==>" + map.get("userId")); //
		session.setAttribute("sessionName", map.get("userName")); // 이름 바꿀시 세션이름을 새로 바꿔줘야 한다
		resultMap.put("userId", map.get("userId")); // 
		resultMap.put("result","success");
		
		return resultMap;
	}
	

		public HashMap<String, Object> authIdPwd(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			User user = userMapper.getUser(map); // 단일객체로 받음
			
			boolean loginFlg = false; // 해쉬화된 비밀번호 실행// if에서 국한되지 않게 loginFlg를 밖으로 뺴서 선언하자
			if(user != null) {
//				// 해쉬화된 비밀번호를 실행
				loginFlg = passwordEncoder.matches((String)map.get("pwd"), user.getPassword());
			}		
			if(loginFlg) { //해시용
				System.out.println("성공");			
				resultMap.put("result", "success");
			}else {
				System.out.println("실패");
				resultMap.put("result", "fail");
			}
			return resultMap;
		}
		
		public HashMap<String, Object> userWithdraw(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int count = userMapper.updateWithdraw(map);
			if(count>0) {
				session.invalidate(); //모든 세션 정보 삭제
			}
			resultMap.put("count", count);
			return resultMap;
		}
		
		public void insertImage(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			userMapper.insertProfileImg(map);
		}
		
		public HashMap<String, Object> userComment(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List<comment> comment = userMapper.selectComm(map);
			int count2 = userMapper.selectCommentCnt(map);
			resultMap.put("comment", comment);
			resultMap.put("count2", count2);
			resultMap.put("result", "success"); // 결과 값

			return resultMap;
		}
		
		public HashMap<String, Object> userDonation(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List<donation> donation = userMapper.selectDonaInfo(map);
			donation sum = userMapper.sumDona(map);
			int donaCount = userMapper.selectDonaCnt(map);
			
			resultMap.put("donaCount", donaCount);
			resultMap.put("sum", sum);
			resultMap.put("donation", donation);
			resultMap.put("result", "success"); // 결과 값

			return resultMap;
		}
		
		public HashMap<String, Object> userCoupon(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List<User> coupon = userMapper.selectCoupon(map);
			int count = userMapper.selectCouponCnt(map);
			resultMap.put("count", count);
			resultMap.put("coupon", coupon);
			resultMap.put("result", "success"); // 결과 값

			return resultMap;
		}
		
		
		
		
		public HashMap<String, Object> vetInfo(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			Vet vet = userMapper.selectVet(map);
			User user = userMapper.selectUser(map);
			
			resultMap.put("vet", vet);
			resultMap.put("user", user);
			return resultMap;
		}
		
		public HashMap<String, Object> getPoint(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List<User> point = userMapper.selectPoint(map);
			int pointCount = userMapper.selectPointCnt(map);
			
			resultMap.put("pointCount", pointCount);
			resultMap.put("point", point);
			return resultMap;
		}
		
		@Override
		public HashMap<String, Object> UserOrderList(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			try {
				List<cart> orderList = userMapper.selectUserOrderList(map);
				List <User>orderCount = userMapper.selectOrderCnt(map);
				int orderAllCount=userMapper.selectOrderAllCnt(map);
				

				resultMap.put("orderAllCount", orderAllCount);
				resultMap.put("orderList", orderList);
				resultMap.put("orderCount", orderCount);
				resultMap.put("result", "success");
			}catch(Exception e) {
				System.out.println(e.getMessage());
				resultMap.put("result", "fail");			
			}
			return resultMap;
		}
		
		public HashMap<String, Object> getEmail(HashMap<String, Object> map) {
		    HashMap<String, Object> resultMap = new HashMap<>();

		    String sessionId = (String) session.getAttribute("sessionId");
		    System.out.println("ttee = " + sessionId); 

		    if (sessionId != null && !sessionId.equals("")) {
		        resultMap.put("result", "fail1");
		        return resultMap;
		    }

		    // 이메일로 유저 검색
		    User user = userMapper.selectEmail(map); // map 안에 "email"이 들어있어야 함
		    int count = user != null ? 1 : 0;

		    if (count == 1) {
		        // 로그인 성공 처리
		        session.setAttribute("sessionId", user.getUserId());
		        session.setAttribute("sessionName", user.getUserName());
		        session.setAttribute("sessionRole", user.getRole());
		        session.setMaxInactiveInterval(60 * 60); // 1시간 유지

		        // 마지막 로그인 시간 갱신
		        userMapper.updateLastLogin(user.getUserId());

		        resultMap.put("user", user);
		    }

		    resultMap.put("count", count); 
		    resultMap.put("result", "success"); // 회원 여부에 상관 없이 success 리턴하고 count로 판단
		    return resultMap;
		}
		
		
		public HashMap<String, Object> searchEmail(HashMap<String, Object> map) {
		    HashMap<String, Object> resultMap = new HashMap<>();
		    // 이메일로 유저 검색
		    User user = userMapper.selectEmail(map); // map 안에 "email"이 들어있어야 함
		    int count = user != null ? 1 : 0;
		    if (count == 0) {
			    resultMap.put("count", count); 
			    resultMap.put("result", "success");
		    }else {
			    resultMap.put("result", "fail"); // 회원 여부에 상관 없이 success 리턴하고 count로 판단	
		    	
		    }
		    return resultMap;
		}
		
		
		public HashMap<String, Object> searchMemberShip(HashMap<String, Object> map) {
			HashMap<String, Object> resultMap = new HashMap<>();
		    List<Membership> ship = userMapper.selectMembershipId(map); // map 안에 "email"이 들어있어야 함
		    int count = ship != null ? 1 : 0;
		    if (count != 0) {
			    resultMap.put("count", count); 
			    resultMap.put("ship", ship); 
			    resultMap.put("result", "success");
		    }else {
			    resultMap.put("result", "fail"); // 회원 여부에 상관 없이 success 리턴하고 count로 판단	
		    	
		    }
		    return resultMap;
		}
		
	
}
