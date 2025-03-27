package teamgyodong.myky.partner.model;

import lombok.Data;

@Data
public class partnerdetail {

	//동물병원
	private String SI;
	private String GU;
	private String DONG;
	private String hosName;
	private String hosAddress;
	private int hospitalNo;
	private String phone;
	private String NX;
	private String NY;

	
	//제휴사
	private int partnerId;
	private String name;
	private String phoneNumber;
	private String address;
	private String WEBSITEURL;
	private String reservationUrl;
	private String openingHours;
	private String LUNCHBREAK;
	private String regularHoliday;
	private String PARTNERDETAILID;
	
	//즐겨찾기
	private int favoriteId;
	private String userId;

	
}
