package teamgyodong.myky.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;


import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;


import ch.qos.logback.core.model.Model;
import lombok.RequiredArgsConstructor;
import teamgyodong.myky.common.dao.GeminiService;


@Controller
public class CommonController {


	@RequestMapping("chat.do") 
    public String blist(Model model) throws Exception{  

        return "common/chat";
    }

	@Controller
	public class ChatController {

	    @MessageMapping("/sendMessage") // 클라이언트에서 "/app/sendMessage"로 요청 시 실행
	    @SendTo("/topic/public") // 메시지를 "/topic/public"을 구독하는 모든 사용자에게 전송
	    public String sendMessage(String message) {
	        System.out.println("Received message: " + message); // 로그 확인
	        return message;
	    }
	}
	


	@RequestMapping("gemini/chat.do") 
    public String gemini(Model model) throws Exception{

        return "common/chatbot";
    }

	
	@RestController
	@RequiredArgsConstructor
	@RequestMapping("/gemini")
	public class GeminiController {
	    private final GeminiService geminiService;

	    @GetMapping("/chat.dox")
	    public ResponseEntity<?> gemini(@RequestParam String input) {
	        try {
	            return ResponseEntity.ok().body(geminiService.getContents(input));
	        } catch (HttpClientErrorException e) {
	            return ResponseEntity.badRequest().body(e.getMessage());
	        }
	    }
	}
}
