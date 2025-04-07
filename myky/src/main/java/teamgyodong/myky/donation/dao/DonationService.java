package teamgyodong.myky.donation.dao;

import java.util.HashMap;

public interface DonationService {

	HashMap<String, Object> getCenterList(HashMap<String, Object> map);

	HashMap<String, Object> getCenterInfo(HashMap<String, Object> map);

	HashMap<String, Object> addDonate(HashMap<String, Object> map);

	HashMap<String, Object> getDonationInfo(HashMap<String, Object> map);

	HashMap<String, Object> getUserDonationInfo(HashMap<String, Object> map);

}
