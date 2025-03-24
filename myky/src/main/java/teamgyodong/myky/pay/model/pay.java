package teamgyodong.myky.pay.model;

import lombok.Data;

@Data
public class pay {
	private String paymentId;
	private String paymentCode;
	private String description;
	private String amount;
	private String paymentMethod;
	private String installment;
	private String subscriptionPeriod;
	private String paymentDate;
	private String paymentStatus;
	private String isCanceled;
	private String cancelDate;
	private String productId;
	private String donationId;
	private String userId;
}
