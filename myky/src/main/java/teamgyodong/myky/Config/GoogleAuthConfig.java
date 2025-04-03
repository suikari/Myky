package teamgyodong.myky.Config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class GoogleAuthConfig {

    @Value("${google.client.id}")
    private String clientId;

    @Value("${google.client.secret}")
    private String clientSecret;

    @Value("${google.auth.uri}")
    private String authUri;

    @Value("${google.token.uri}")
    private String tokenUri;

    @Value("${google.auth.provider.cert.url}")
    private String authProviderCertUrl;

    public String getClientId() { return clientId; }
    public String getClientSecret() { return clientSecret; }
    public String getAuthUri() { return authUri; }
    public String getTokenUri() { return tokenUri; }
    public String getAuthProviderCertUrl() { return authProviderCertUrl; }

    // 📌 JSON을 바로 생성해서 반환하는 메서드
    public Map<String, Object> getGoogleAuthJson() {
        Map<String, Object> jsonMap = new HashMap<>();
        Map<String, Object> webMap = new HashMap<>();

        webMap.put("client_id", clientId);
        webMap.put("client_secret", clientSecret);
        webMap.put("auth_uri", authUri);
        webMap.put("token_uri", tokenUri);
        webMap.put("auth_provider_x509_cert_url", authProviderCertUrl);

        jsonMap.put("web", webMap);

        return jsonMap;
    }
}
