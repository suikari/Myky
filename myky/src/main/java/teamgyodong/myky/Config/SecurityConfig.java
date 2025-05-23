package teamgyodong.myky.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


// 구글 로그인용 //
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.Customizer;
//구글 로그인용 //



@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();  // 비밀번호 해싱 기능만 사용
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll() // 모든 요청 허용 (로그인 필요 없음)
            )
            .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화 (필요 시 설정 가능)
            .formLogin(form -> form.disable()) // 기본 로그인 페이지 비활성화
            .httpBasic(basic -> basic.disable()) // HTTP Basic 인증 비활성화
		    .headers(headers -> headers.cacheControl(cache -> cache.disable())) // 캐싱 비활성화
		    .oauth2Login(Customizer.withDefaults()); // ✅ OAuth2 로그인 추가
        return http.build();
    }

//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//            .authorizeHttpRequests(auth -> auth
//                .requestMatchers("/", "/googleLogin").permitAll() // 메인 페이지 & 구글 로그인 허용
//                .anyRequest().authenticated() // 그 외 요청은 인증 필요
//            )
//            .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화
//            .formLogin(form -> form.disable()) // 기본 로그인 페이지 비활성화
//            .httpBasic(basic -> basic.disable()) // HTTP Basic 인증 비활성화
//            .headers(headers -> headers.cacheControl(cache -> cache.disable())) // 캐싱 비활성화
//            .oauth2Login(Customizer.withDefaults()); // ✅ OAuth2 로그인 추가
//
//        return http.build();
//    }
    
    
    

}