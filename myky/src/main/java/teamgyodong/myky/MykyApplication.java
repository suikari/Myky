package teamgyodong.myky;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class MykyApplication extends SpringBootServletInitializer {

    // 추가 코드
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(MykyApplication.class);
    }
	
	public static void main(String[] args) {
		SpringApplication.run(MykyApplication.class, args);
	}

}
