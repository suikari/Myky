//package teamgyodong.myky.Config;
//
//
//import com.google.api.client.auth.oauth2.Credential;
//import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
//import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
//import com.google.api.client.json.JsonFactory;
//import com.google.api.client.json.jackson2.JacksonFactory;
//import com.google.api.services.gmail.Gmail;
//import com.google.api.services.gmail.model.Message;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import jakarta.mail.*;
//import jakarta.mail.internet.InternetAddress;
//import jakarta.mail.internet.MimeMessage;
//import java.io.ByteArrayOutputStream;
//import java.nio.charset.StandardCharsets;
//import java.util.Base64;
//import java.util.Map;
//
//@Component  // 📌 스프링 빈으로 등록
//public class GoogleAuthExample {
//
//    private static final String APPLICATION_NAME = "MyKyApp";  // 프로젝트명
//    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
//
//    private final GoogleAuthConfig googleAuthConfig;
//
//    @Autowired
//    public GoogleAuthExample(GoogleAuthConfig googleAuthConfig) {
//        this.googleAuthConfig = googleAuthConfig;
//    }
//
//    /**
//     * 📌 기존 JSON 데이터 출력 기능 (유지)
//     */
//    public void useGoogleAuthJson() {
//        Map<String, Object> googleAuthJson = googleAuthConfig.getGoogleAuthJson();
//        System.out.println("📌 Google OAuth JSON 데이터:");
//        System.out.println(googleAuthJson);
//    }
//
//    /**
//     * 📌 Gmail API를 이용한 이메일 발송 기능 추가
//     */
//    public boolean sendEmail(String recipientEmail, String authCode) {
//        try {
//            // 이메일 본문 작성
//            String subject = "이메일 인증 코드";
//            String bodyText = "인증 코드: " + authCode;
//
//            // Gmail API 클라이언트 생성
//            Gmail service = getGmailService();
//
//            // 이메일 메시지 생성
//            MimeMessage email = createEmail(recipientEmail, "me", subject, bodyText);
//            Message message = createMessageWithEmail(email);
//
//            // 이메일 전송
//            service.users().messages().send("me", message).execute();
//            return true;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    /**
//     * 📌 Gmail API 서비스 객체 생성
//     */
//    private Gmail getGmailService() throws Exception {
//        Credential credential = authorize();
//        return new Gmail.Builder(GoogleNetHttpTransport.newTrustedTransport(), JSON_FACTORY, credential)
//                .setApplicationName(APPLICATION_NAME)
//                .build();
//    }
//
//    /**
//     * 📌 OAuth 2.0 인증
//     */
//    private Credential authorize() throws Exception {
//        Map<String, Object> googleAuthJson = googleAuthConfig.getGoogleAuthJson();
//        return new GoogleCredential.Builder()
//                .setTransport(GoogleNetHttpTransport.newTrustedTransport())
//                .setJsonFactory(JSON_FACTORY)
//                .setClientSecrets(
//                        new com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets()
//                )
//                .build();
//    }
//
//    /**
//     * 📌 이메일 메시지 생성 (MIME 형식)
//     */
//    private MimeMessage createEmail(String to, String from, String subject, String bodyText) throws MessagingException {
//        Session session = Session.getDefaultInstance(System.getProperties(), null);
//        MimeMessage email = new MimeMessage(session);
//        email.setFrom(new InternetAddress(from));
//        email.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//        email.setSubject(subject);
//        email.setText(bodyText, StandardCharsets.UTF_8.name());
//        return email;
//    }
//
//    /**
//     * 📌 이메일 메시지를 Gmail API가 사용할 수 있는 형식으로 변환
//     */
//    private Message createMessageWithEmail(MimeMessage email) throws Exception {
//        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
//        email.writeTo(buffer);
//        String encodedEmail = Base64.getUrlEncoder().encodeToString(buffer.toByteArray());
//        Message message = new Message();
//        message.setRaw(encodedEmail);
//        return message;
//    }
//}