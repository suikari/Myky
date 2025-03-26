<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 주문하기</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

    <style>
        .ordercontainer {
            max-width: 900px;
            margin: auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        .ordercontainer h2, 
        .ordercontainer h3 {
            text-align: center;
            margin-bottom: 15px;
        }

        .orderTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .orderTable th, 
        .orderTable td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .orderTable th {
            background: #f5f5f5;
            font-weight: bold;
        }

        .inputField {
            width: 80%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .inputField.short {
            width: 10%;
            display: inline-block;
        }

        .delivery-section {
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            background: #fafafa;
        }

        .delivery-section label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .delivery-section select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: white;
            cursor: pointer;
        }

        .payBtn {
            width: 100%;
            padding: 12px;
            background: #FF8C42;
            color: white;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .payBtn:hover {
            background: #e07b3e;
        }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="ordercontainer">
        <h2>주문하기</h2>

        <h3>주문 상품</h3>
        <table class="orderTable">
            <thead>
                <tr>
                    <th>상품 이미지</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>총 금액</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(item, index) in cartItems" :key="item.productId">
                    <td v-if="item.filepath != null"><img :src="item.filepath" width="50"></td>
                    <td v-else><img src="/img/product/product update.png" width="50"></td>
                    <td>{{ item.productName }}</td>
                    <td>{{ item.price }} 원</td>
                    <td>{{ item.quantity }}</td>
                    <td>{{ (item.price * item.quantity) }} 원</td>
                </tr>
            </tbody>
        </table>

        <div v-if="totalPrice < 30000">
            <h3>
                <span>배송비 : 2,000 원 </span><span> + 상품 금액 : {{ totalPrice }} 원</span>
            </h3>
            <h2>총 결제 금액 : {{ totalShippingPrice }} 원</h2>
        </div>
        <div v-else>
            <h3>
                <span>총 결제 금액 : {{ totalPrice }} 원</span>
            </h3>
        </div>

        <div class="delivery-section">
            <h3>배송 정보</h3>
            <div>
                <label>
                    <input type="radio" name="deliveryType" value="default" v-model="deliveryType" @change="setDefaultAddress">
                    기본 배송지  ({{ userInfo.address }})
                </label>
                <label>
                    <input type="radio" name="deliveryType" value="new" v-model="deliveryType" @change="setDefaultAddress">
                    새로운 배송지 입력
                </label>
            </div>
            
            <div>
                <label>수령인: <input type="text" ref="receiverInput" class="inputField" v-model="orderInfo.receiver" required></label><br>
                <label>우편번호:
                    <input type="text" ref="zipcodeInput" class="inputField short" v-model="orderInfo.zipcode" placeholder="우편번호" readonly>
                    <button type="button" @click="searchAddress">우편번호 검색</button>
                </label><br>
            
                <label>기본 주소: 
                    <input type="text" class="inputField" v-model="orderInfo.baseAddress" placeholder="기본 주소" readonly>
                </label><br>
            
                <label>상세 주소: 
                    <input type="text" ref="detailAddress" class="inputField" v-model="orderInfo.detailAddress" placeholder="상세 주소 입력">
                </label><br>

                <label>휴대폰 번호:
                    <select v-model="orderInfo.phonePrefix" @change="focusPhoneMiddle" class="inputField short" required>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select> -
                    <input type="text" ref="phoneMiddleInput" class="inputField short" v-model="orderInfo.phoneMiddle" maxlength="4" placeholder="1234" @input="checkPhoneMiddle" required> -
                    <input type="text" class="inputField short" v-model="orderInfo.phoneSuffix" maxlength="4" placeholder="5678" ref="phoneSuffixInput" required>
                </label><br>
            </div>

        <h3>배송 요청 사항</h3>
        <select v-model="orderInfo.deliveryMessage">
            <option value="">배송 메시지를 선택해주세요</option>
            <option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
            <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
            <option value="배송 전 연락 부탁드립니다">배송 전 연락 부탁드립니다</option>
            <option value="직접 입력">직접 입력</option>
        </select>
        <input v-if="orderInfo.deliveryMessage === '직접 입력'" type="text" class="inputField" v-model="orderInfo.customMessage" placeholder="배송 요청사항 입력">

        <button class="payBtn" @click="submitOrder">결제하기</button>
    </div>


	<!-- <jsp:include page="/WEB-INF/common/footer.jsp"/> -->

    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</body>
</html>
<script>
    
    const userCode = "imp40283074";

    document.addEventListener("DOMContentLoaded", function () {

        if (typeof IMP !== 'undefined') {
	        IMP.init(userCode);
	    } else {
	        console.error('IMP is not loaded properly');
	    }
        
        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    userInfo: {},
                    cartItems: [],
                    deliveryType: "default",
                    orderInfo: {
                        receiver: "",
                        zipcode: "",
                        baseAddress: "",
                        detailAddress: "",
                        phonePrefix:"010",
                        phoneMiddle:"",
                        phoneSuffix:"",
                        phone: "",
                        deliveryMessage: "",
                        customMessage: "",
                    },
                    orderData: {},
                    orderDetailData:{}
                };
            },
            computed: {
                totalPrice() {
                    return this.cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
                },
                totalShippingPrice() {
                    return (this.cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0))+2000;
                }
            },
            methods: {
                fnUserInfo() {
                    let self = this;
                    let params = { userId: self.sessionId };
                    $.ajax({
                        url: "/user/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            self.userInfo = data.user;
                            self.loadCart();
                            self.setDefaultAddress();

                        }
                    });
                },
                loadCart() {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/cart/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            self.cartItems = data.list;
                        }
                    });
                },
                setDefaultAddress() {
                    let self = this;
                    if (self.deliveryType === "default") {
                        self.orderInfo.receiver = self.userInfo.userName;
                        self.orderInfo.phone = self.userInfo.phoneNumber;
                        if(self.userInfo.address){
                            let parsedAddress = self.parseAddress(self.userInfo.address);
                            if (parsedAddress) {
                                self.orderInfo.zipcode = parsedAddress.zipcode;
                                self.orderInfo.baseAddress = parsedAddress.baseAddress;
                                self.orderInfo.detailAddress = parsedAddress.detailAddress;
                            }
                        }
                    } else {
                        self.orderInfo.receiver = "";
                        self.orderInfo.phone = "";
                        self.orderInfo.zipcode = "";
                        self.orderInfo.baseAddress = "";
                        self.orderInfo.detailAddress = "";
                        self.$nextTick(() => {
                            self.$refs.receiverInput.focus();
                        });
                    }
                    self.splitPhoneNumber();
                },
                parseAddress(fullAddress) {
                    let self = this;
                    let zipcodePattern = /\d{5,6}/;
                    let zipcodeMatch = fullAddress.match(zipcodePattern);

                    if (zipcodeMatch) {
                        self.orderInfo.zipcode = zipcodeMatch[0];
                        fullAddress = fullAddress.replace(zipcodeMatch[0], "").trim();
                    } else {
                        self.orderInfo.zipcode = "";
                    }

                    let addressParts = fullAddress.split(",");
                    self.orderInfo.baseAddress = addressParts[0].trim();
                    self.orderInfo.detailAddress = addressParts.slice(1).join(",").trim();
                },
                splitPhoneNumber() {
                    let self = this;
                    if (self.deliveryType === "default") {
                        let phone = self.userInfo.phoneNumber.replace(/-/g, "");
                        if (phone.length === 11) {
                            self.orderInfo.phonePrefix = phone.slice(0, 3);
                            self.orderInfo.phoneMiddle = phone.slice(3, 7);
                            self.orderInfo.phoneSuffix = phone.slice(7, 11);
                        } else if (phone.length === 10) {
                            self.orderInfo.phonePrefix = phone.slice(0, 3);
                            self.orderInfo.phoneMiddle = phone.slice(3, 6);
                            self.orderInfo.phoneSuffix = phone.slice(6, 10);
                        }
                    } 
                    if(self.deliveryType === "new") {
                        self.orderInfo.phonePrefix = "010";
                        self.orderInfo.phoneMiddle = "";
                        self.orderInfo.phoneSuffix = "";
                    }
                },
                searchAddress() {
                    let self = this;
                    
                    new daum.Postcode({
                        oncomplete: function(data) {
                            self.orderInfo.zipcode = data.zonecode;
                            self.orderInfo.baseAddress = data.address;
                            self.orderInfo.detailAddress = "";
                            self.$nextTick(() => {
                                self.$refs.detailAddress.focus();
                            });
                        }
                    }).open();
                },
                focusPhoneMiddle() {
                    this.$nextTick(() => {
                        this.$refs.phoneMiddleInput.focus();
                    });
                },
                checkPhoneMiddle() {
                    if (this.orderInfo.phoneMiddle.length === 4) {
                        this.$nextTick(() => {
                            this.$refs.phoneSuffixInput.focus();
                        });
                    }
                },
                submitOrder() {
                    let self = this;

                    self.orderInfo.phone = (self.deliveryType === "new") ? self.orderInfo.phonePrefix+self.orderInfo.phoneMiddle+self.orderInfo.phoneSuffix : "";

                    if(!self.orderInfo.receiver){
                        alert("수령인 성함을 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.receiverInput.focus();
                        });
                        return;
                    }
                    if(!self.orderInfo.baseAddress){
                        alert("배송받을 주소를 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.zipcodeInput.focus();
                        });
                        return;
                    }
                    if(!self.orderInfo.phoneMiddle || !self.orderInfo.phoneSuffix){
                        alert("휴대폰 번호를 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.phoneMiddleInput.focus();
                        });
                        return;
                    }
                    let address = self.orderInfo.baseAddress+","+self.orderInfo.detailAddress+","+self.orderInfo.zipcode;
                    let finalAddress = self.deliveryType === "default" ? self.userInfo.address : address;
                    let finalMessage = self.orderInfo.deliveryMessage === "직접 입력" ? self.orderInfo.customMessage : self.orderInfo.deliveryMessage;
                    

                    // let totalPrice = (self.totalPrice < 30000) ? self.totalShippingPrice : self.totalPrice;
                    let totalPrice = self.totalPrice;
                    
                    console.log("총 결제 금액 >>> ",self.orderData.totalPrice);
                    
                    console.log("orders+orderDetail >>>", self.orderData,self.orderDetailData);

                    self.fnPayment(totalPrice);
                },
                fnPayment:function(totalPrice){
	                var self = this;
	
	                if (typeof IMP === 'undefined') {
	                    console.error('IMP is not initialized');
	                    return;
	                }
	
	                IMP.request_pay({
	                    channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
	                    pg: "html5_inicis",
	                    pay_method: "card",
	                    merchant_uid: "merchant_" + new Date().getTime(),
	                    name: "장바구니 상품 결제",
	                    amount: totalPrice,
	                    buyer_tel: self.userInfo.phoneNumber,
	                }, function (rsp) {
	                    if (rsp.success) {
	                        console.log("결제 정보 >>> ",rsp);
                            self.fnPaymentHistory(rsp, totalPrice);
	                    } else {
	                        alert("결제에 실패했습니다.");
	                        console.log("결제 정보 >>> ",rsp.error_msg);
	                    }
	                });
	            },
	            fnPaymentHistory:function(rsp,totalPrice){
	                let self = this;
	                
	                let paymentMethod = "";
	                if(rsp.pay_method == "card"){
	                    paymentMethod = rsp.pay_method,"-",rsp.card_name,rsp.card_number;
	                } else {
	                    paymentMethod = rsp.pay_method;
	                }
	                
	                console.log("paymentMethod >>> ",paymentMethod);
	
	                var nparmap = {
	                    paymentCode: rsp.merchant_uid,
	                    description: rsp.name,
	                    amount: rsp.paid_amount,
	                    paymentMethod: paymentMethod,
	                    installment: rsp.card_quota,
	                    subscriptionPeriod: null,
	                    paymentStatus: rsp.status,
	                    isCanceled: "N",
                    	cancelDate: null,
	                    productId: null,
	                    donationId: null,
	                    userId: self.userInfo.userId
	                };
		            $.ajax({
		                url: "/payment.dox",
		                dataType: "json",
		                type: "POST",
		                data: nparmap,
		                success: function (data) {
	                    	console.log("결제 정보 저장 여부 >>> ",data.result);
                            self.fnOrderHistory(totalPrice,rsp.pay_method);

	                	}
	            	});
            	},
                fnOrderHistory:function(totalPrice, paymentMethod){
                    let self = this;

                    self.orderData = {
                        totalPrice: totalPrice,
                        userId: self.userInfo.userId,
                        receiverName: self.orderInfo.receiver || self.userInfo.userName,
                        receiverPhone: self.orderInfo.phone || self.userInfo.phoneNumber,
                        receiverAddr: finalAddress,
                        paymentMethod:paymentMethod,
                        deliveryMessage: finalMessage,
                        option:"order"
                    };
                    
                    console.log("orders에 저장할 데이터 >>>", self.orderData);

                    var nparmap = self.orderData;
		            $.ajax({
		                url: "/cart/order.dox",
		                dataType: "json",
		                type: "POST",
		                data: nparmap,
		                success: function (data) {
	                    	console.log("주문 정보 저장 여부 >>> ",data.result);
                            self.fnOrderDetailHistory(data.orderId);

	                	}
	            	});
                },
                fnOrderDetailHistory:function(orderId){
                    let self = this;

                    self.orderDetailData = {
                        option: "orderDetail",
                        orderId:orderId,
                        orderDetails: self.cartItems.map(item => ({
                            productId: item.productId,
                            quantity: item.quantity,
                            price: item.quantity * item.price
                        }))
                    };

                    console.log("orderDetail에 저장할 데이터 >>> ",self.orderDetailData);

                    var nparmap = self.orderDetailData;
		            $.ajax({
		                url: "/cart/order.dox",
		                dataType: "json",
		                type: "POST",
		                data: nparmap,
		                success: function (data) {
	                    	console.log("주문 상세 정보 저장 여부 >>> ",data.result);

	                	}
	            	});
                }
            },
            mounted() {
                let self = this;
                self.fnUserInfo();

                if (typeof IMP !== 'undefined') {
                    IMP.init(userCode); 
                    console.log('IMP initialized');
                } else {
                    console.error('IMP is not loaded properly');
                }
            }
        });

        app.mount("#app");
    });
</script>