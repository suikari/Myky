package teamgyodong.myky.Main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Main.dao.MainService;
import teamgyodong.myky.donation.dao.DonationService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;


@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    
	@RequestMapping("main.do") 
    public String main(HttpServletRequest request, HttpSession session, Model model)throws Exception{

		

		 // 세션을 통해 첫 방문 여부 확인
        if (session.getAttribute("firstVisit") == null) {
            session.setAttribute("firstVisit", true);

            // 접속 정보 수집
    		
            HashMap<String, Object> resultMap = new HashMap<String, Object>();
    		HashMap<String, Object> visitData = new HashMap<String, Object>();

            String ipAddress = getClientIp(request); //request.getRemoteAddr();
            String userAgent = request.getHeader("User-Agent");
            String referer = request.getHeader("Referer");  // 사용자가 온 도메인
            
            if (referer == null) {
                referer = "";  // 빈 문자열로 처리
            }
            
            System.out.println(ipAddress +";"+ userAgent +";"+ referer);

    		//#{ipAddress}, #{userAgent}, #{referer}, #{accessTime}
            visitData.put("ipAddress", ipAddress);
            visitData.put("userAgent", userAgent);
            visitData.put("referer", referer);
            visitData.put("accessTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))); // accessTime 직접 생성하여 추가
            
            
            System.out.println(visitData);

    		resultMap = mainService.InsertVisitLog(visitData);
    		
            System.out.println(resultMap);


        } else {

        }

        
        return "index";
    }
	
	
	
	
	
	// 클라이언트의 실제 IP를 가져오는 메서드
    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");

        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr(); // 최종 IP 가져오기
        }

        // 여러 개의 IP가 있을 경우 첫 번째 IP 사용
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }

        return ip;
    }
}
