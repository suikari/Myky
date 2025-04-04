package teamgyodong.myky.manager.model;

import java.util.List;

import lombok.Data;

@Data
public class order {
    private String orderId;
    private String totalPrice;
    private String orderStatus;
    private String orderedAt;
    private String userId;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddr;
    private String paymentMethod;
    private String refundStatus;
    private String deliveryMessage;
    private String updatedAt;
    private String refundRequestDate;
    
    
    // ✅ 추가
    private List<orderdetail> orderdetail;

    // Getter/Setter 포함
    public List<orderdetail> getOrderdetail() {
        return orderdetail;
    }

    public void setOrderdetail(List<orderdetail> detail) {
        this.orderdetail = detail;
    }
    
	
}
