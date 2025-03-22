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
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    
	@RequestMapping("main.do") 
    public String main(HttpServletRequest request, HttpSession session, Model model)throws Exception{

		
		//session.removeAttribute("firstVisit");
		
		 // 세션을 통해 첫 방문 여부 확인
        if (session.getAttribute("firstVisit") == null) {
            session.setAttribute("firstVisit", true);

            // 접속 정보 수집
    		
            HashMap<String, Object> resultMap = new HashMap<String, Object>();
    		HashMap<String, Object> visitData = new HashMap<String, Object>();

    		String userAgent = request.getHeader("User-Agent");
    		
            String ipAddress = getClientIp(request); //request.getRemoteAddr();
            
            String Browser =  getBrowserName(userAgent);
            String WindowsVersion =  getWindowsVersion(userAgent);
            
            String referer = request.getHeader("Referer");  // 사용자가 온 도메인
            
            if (referer == null) {
                referer = "";  // 빈 문자열로 처리
            }
            
            System.out.println(ipAddress +";"+ userAgent +";"+ referer);

    		//#{ipAddress}, #{userAgent}, #{referer}, #{accessTime}
            visitData.put("ipAddress", ipAddress);
            visitData.put("userAgentBrowser", Browser);
            visitData.put("userAgentWindows", WindowsVersion);
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
    
    public static String getBrowserName(String userAgent) {
        if (userAgent == null) {
            return "Unknown Browser";
        }

        // Edge 브라우저 식별
        if (userAgent.contains("Edg/")) {
            return extractBrowserVersion(userAgent, "Edg/") + " (Edge)";
        }

        // Chrome 브라우저 (단, Edge가 포함되지 않은 경우)
        if (userAgent.contains("Chrome/") && !userAgent.contains("Edg/")) {
            return extractBrowserVersion(userAgent, "Chrome/") + " (Chrome)";
        }

        // Firefox 브라우저
        if (userAgent.contains("Firefox/")) {
            return extractBrowserVersion(userAgent, "Firefox/") + " (Firefox)";
        }

        // Safari 브라우저 (단, Chrome이 포함되지 않은 경우)
        if (userAgent.contains("Safari/") && !userAgent.contains("Chrome/")) {
            return extractBrowserVersion(userAgent, "Version/") + " (Safari)";
        }

        return "Unknown Browser";
    }

    private static String extractBrowserVersion(String userAgent, String browserIdentifier) {
        Pattern pattern = Pattern.compile(browserIdentifier + "([\\d\\.]+)");
        Matcher matcher = pattern.matcher(userAgent);
        if (matcher.find()) {
            return browserIdentifier + matcher.group(1);
        }
        return "Unknown Version";
    }
    
    public static String getWindowsVersion(String userAgent) {
        if (userAgent == null || !userAgent.contains("Windows NT")) {
            return "Unknown Windows Version";
        }

        // Windows NT 버전 추출 (예: Windows NT 10.0)
        Pattern pattern = Pattern.compile("Windows NT ([\\d\\.]+)");
        Matcher matcher = pattern.matcher(userAgent);
        if (matcher.find()) {
            String ntVersion = matcher.group(1);
            return mapWindowsVersion(ntVersion);
        }

        return "Unknown Windows Version";
    }

    private static String mapWindowsVersion(String ntVersion) {
        switch (ntVersion) {
            case "10.0": return "Windows 10 / 11";
            case "6.3": return "Windows 8.1";
            case "6.2": return "Windows 8";
            case "6.1": return "Windows 7";
            case "6.0": return "Windows Vista";
            case "5.1": return "Windows XP";
            case "5.0": return "Windows 2000";
            default: return "Unknown Windows Version (" + ntVersion + ")";
        }
    }
    
}
