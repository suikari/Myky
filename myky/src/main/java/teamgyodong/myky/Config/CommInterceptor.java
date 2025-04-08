package teamgyodong.myky.Config;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Main.dao.MainService;

public class CommInterceptor implements HandlerInterceptor {

    private final MainService mainService;

    public CommInterceptor(MainService mainService) {
        this.mainService = mainService;
    }
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 요청 처리 전에 실행할 로직
    	

    	
        return true;  // true를 리턴하면 요청이 계속 진행됨
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 요청 처리 후, 응답 전에 실행할 로직
    	//System.out.println("test23");
    	
    	
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    	//System.out.println("test34");
    	// 응답 후 실행할 로직

    	HttpSession session = request.getSession();
    	
    	//request.getSession().removeAttribute("firstVisit");

    	if (session.getAttribute("firstVisit") == null) {
            session.setAttribute("firstVisit", true);

            // 접속 정보 수집
    		
            HashMap<String, Object> resultMap = new HashMap<String, Object>();
    		HashMap<String, Object> visitData = new HashMap<String, Object>();

    		String userAgent = request.getHeader("User-Agent");
    		
            String ipAddress = Common.getClientIp(request); //request.getRemoteAddr();
            
            String Browser =  Common.getBrowserName(userAgent);
            String WindowsVersion =  Common.getWindowsVersion(userAgent);
            
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
    	
    }
}


