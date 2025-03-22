package teamgyodong.myky.user.model;

import java.util.List;

import lombok.Data;

@Data
public class User {
	private String userId;
	private String userName;
	private String address;
	private String password;
	private String nickName;
	private String email;
	private String profileImage;
	private String phoneNumber;
	private String birthDate;
	private String role;

}
