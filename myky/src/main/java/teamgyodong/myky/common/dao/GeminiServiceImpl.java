package teamgyodong.myky.common.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import lombok.RequiredArgsConstructor;
import teamgyodong.myky.common.model.ChatRequest;
import teamgyodong.myky.common.model.ChatResponse;

@Service
@RequiredArgsConstructor
public class GeminiServiceImpl implements GeminiService {


    @Qualifier("geminiRestTemplate")
    @Autowired
    private RestTemplate restTemplate;

    @Value("${GEMINI_URL}")
    private String apiUrl;

    @Value("${GEMINI_KEY}")
    private String geminiApiKey;
    
	@Override
	public String getContents(String prompt) {

        // Gemini에 요청 전송
        String requestUrl = apiUrl + "?key=" + geminiApiKey;

        ChatRequest request = new ChatRequest(prompt);
        ChatResponse response = restTemplate.postForObject(requestUrl, request, ChatResponse.class);

        String message = response.getCandidates().get(0).getContent().getParts().get(0).getText().toString();

        return message;
	}

}
