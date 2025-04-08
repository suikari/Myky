package teamgyodong.myky.Config;

import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.http.HttpServletRequest;

public class Common {

	// 현재 시간을 기준으로 파일 이름 생성
	static public String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}

	
	// 클라이언트의 실제 IP를 가져오는 메서드
	static public String getClientIp(HttpServletRequest request) {
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
    
	static public String getBrowserName(String userAgent) {
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

    static public String extractBrowserVersion(String userAgent, String browserIdentifier) {
        Pattern pattern = Pattern.compile(browserIdentifier + "([\\d\\.]+)");
        Matcher matcher = pattern.matcher(userAgent);
        if (matcher.find()) {
            return browserIdentifier + matcher.group(1);
        }
        return "Unknown Version";
    }
    
    static public String getWindowsVersion(String userAgent) {
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

    static public String mapWindowsVersion(String ntVersion) {
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
