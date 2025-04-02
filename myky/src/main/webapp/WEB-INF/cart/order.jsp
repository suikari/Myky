<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        .discountTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            background-color: #fff;
            overflow: hidden;
        }

        .discountTable th,
        .discountTable td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .discountTable th {
            background-color: #f8f8f8;
            font-weight: bold;
            color: #333;
        }

        .discountTable td {
            color: #555;
        }

        .discountTable tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .discountTable input[type="text"] {
            width: 120px;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            margin-right: 5px;
        }

        .discountTable button {
            padding: 6px 10px;
            border: none;
            background-color: #FF8C42;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
            margin-left: 10px;
        }

        .discountTable button:hover {
            background-color: #e07b3e;
        }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />



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
                <tr v-for="(item, index) in selectCartItems" :key="item.productId">
                    <td v-if="item.filepath != null"><img :src="item.filepath" width="50"></td>
                    <td v-else><img src="/img/product/product update.png" width="50"></td>
                    <td>{{ item.productName }}</td>
                    <td v-if="isMembership">
                        <div><del>{{ item.price }} 원</del></div>
                        <div><strong>{{ getDiscountPrice(item) }} 원</strong></div>
                    </td>
                    <td v-else>{{ item.price }} 원</td>
                    <td>{{ item.quantity }}</td>
                    <td v-if="isMembership">{{ (getDiscountPrice(item) * item.quantity) }} 원</td>
                    <td v-else>{{ (item.price * item.quantity) }} 원</td>
                </tr>
            </tbody>
        </table>
        <table class="discountTable">
            <tr v-if="totalPrice < 30000">
                <th>결제 금액 (배송비 포함)</th>
                <td>{{ formattedTotalShippingPrice }} 원</td>
            </tr>
            <tr v-else>
                <th>결제 금액</th>
                <td>{{ formattedTotalPrice }} 원</td>
            </tr>
            <tr>
                <th>보유 포인트</th>
                <td>{{ formattedUserPoints }} 원</td>
            </tr>
            <tr>
                <th>사용할 포인트</th>
                <td>
                    <input type="text" ref="usedPoint" v-model="usedPoint" @input="validatePoints" placeholder="사용할 적립금 입력">
                    <button @click="useAllPoints">전체 사용</button>
                    <button @click="applyPoints">적용</button>
                </td>
            </tr>
            <tr>
                <th>할인 금액</th>
                <td>- {{ formattedDiscountAmount }} 원</td>
            </tr>
            <tr>
                <th>결제 후 적립되는 포인트</th>
                <td>{{ formattedRewardPoints }}</td>
            </tr>
        </table>

        <div>
            <h2>총 결제 금액 : {{ formattedFinalPrice }} 원</h2>
        </div>

        <div class="delivery-section">
            <h3>배송 정보</h3>
            <div>
                <label>
                    <input type="radio" name="deliveryType" value="default" v-model="deliveryType"
                        @change="setDefaultAddress">
                    기본 배송지 ({{ userInfo.address }})
                </label>
                <label>
                    <input type="radio" name="deliveryType" value="new" v-model="deliveryType"
                        @change="setDefaultAddress">
                    새로운 배송지 입력
                </label>
            </div>

            <div>
                <label>수령인: <input type="text" ref="receiverInput" class="inputField" v-model="orderInfo.receiver"
                        required></label><br>
                <label>우편번호:
                    <input type="text" ref="zipcodeInput" class="inputField short" v-model="orderInfo.zipcode"
                        placeholder="우편번호" readonly>
                    <button type="button" @click="searchAddress">우편번호 검색</button>
                </label><br>

                <label>기본 주소:
                    <input type="text" class="inputField" v-model="orderInfo.baseAddress" placeholder="기본 주소"
                        readonly>
                </label><br>

                <label>상세 주소:
                    <input type="text" ref="detailAddress" class="inputField" v-model="orderInfo.detailAddress"
                        placeholder="상세 주소 입력">
                </label><br>

                <label>휴대폰 번호:
                    <select v-model="orderInfo.phonePrefix" @change="focusPhoneMiddle" class="inputField short"
                        required>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select> -
                    <input type="text" ref="phoneMiddleInput" class="inputField short"
                        v-model="orderInfo.phoneMiddle" maxlength="4" placeholder="1234" @input="checkPhoneMiddle"
                        required> -
                    <input type="text" class="inputField short" v-model="orderInfo.phoneSuffix" maxlength="4"
                        placeholder="5678" ref="phoneSuffixInput" required>
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
            <input v-if="orderInfo.deliveryMessage === '직접 입력'" type="text" class="inputField"
                v-model="orderInfo.customMessage" placeholder="배송 요청사항 입력">

            <button class="payBtn" @click="submitOrderCheck">결제하기</button>
            <button class="payBtn" @click="test">주문완료페이지테스트</button>
        </div>
    </div>

        <jsp:include page="/WEB-INF/common/footer.jsp"/>

        <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</body>

</html>
<script>

    const userCode = "imp40283074";

    document.addEventListener("DOMContentLoaded", function () {

        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    userInfo: {},
                    selectCartItems: [],
                    deliveryType: "default",
                    orderInfo: {
                        receiver: "",
                        zipcode: "",
                        baseAddress: "",
                        detailAddress: "",
                        phonePrefix: "010",
                        phoneMiddle: "",
                        phoneSuffix: "",
                        phone: "",
                        deliveryMessage: "",
                        customMessage: "",
                    },
                    orderData: {},
                    orderDetailData: {},
                    userPoint: 0,
                    usedPoint: 0,
                    discountAmount: 0,
                    cartId: "",
                    paid_amount:0,
                    isMembership:false,
                    shippingFee:2000,
                    shippingFreeMinimum:30000
                };
            },
            computed: {
                totalPrice() {
                    return this.selectCartItems.reduce((sum, item) => sum + this.getTotalPrice(item), 0);
                },
                totalShippingPrice() {
                    return this.selectCartItems.reduce((sum, item) => sum + this.getTotalPrice(item), 0) + parseInt(this.shippingFee);
                },
                finalPrice() {
                    let finalPrice = 0;
                    if (this.totalPrice < this.shippingFreeMinimum) {
                        finalPrice = this.totalShippingPrice;
                        this.paid_amount = this.totalShippingPrice;
                    } else {
                        finalPrice = this.totalPrice;
                        this.paid_amount = this.totalPrice;
                    }
                    return finalPrice - this.discountAmount;
                },
                formattedTotalPrice() {
                    return this.totalPrice.toLocaleString();
                },
                formattedUserPoints() {
                    return this.userPoint.toLocaleString();
                },
                formattedDiscountAmount() {
                    return this.discountAmount.toLocaleString();
                },
                formattedTotalShippingPrice() {
                    return this.totalShippingPrice.toLocaleString();
                },
                formattedFinalPrice() {
                    return this.finalPrice.toLocaleString();
                },
                rewardPoint(){
                    return +Math.floor(this.totalPrice * 0.05);
                },
                formattedRewardPoints() {
                    return this.rewardPoint.toLocaleString();
                },
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
                            self.loadSelectCart();
                            self.setDefaultAddress();
                            self.fnGetPoint();
                            self.fnGetMembership();
                        }
                    });
                },
                loadSelectCart() {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/cart/checkList.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("cartList >>> ", data.checkList);
                            self.selectCartItems = data.checkList;
                            self.cartId = data.checkList[0].cartId;
                            console.log("cartId >>> ",self.cartId);
                            self.shippingFee = self.selectCartItems[0].shippingFee;
                            self.shippingFreeMinimum = self.selectCartItems[0].shippingFreeMinimum;
                        }
                    });
                },
                fnGetPoint: function () {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/point/current.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            self.userPoint = parseInt(data.point.currentPoint);
                            console.log("보유포인트 >>> ",data.result);
                        }
                    });
                },
                fnGetMembership: function () {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/membership/active.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("멤버십 활성 여부 >>> ",data.result);
                            if(data.result === "success"){
                                self.isMembership = true;

                            }
                        }
                    });
                },
                fnRewardPoint:function(){
                    let self = this;
                    console.log("적립할 포인트 >>> ",self.rewardPoint);

                    var nparmap = {
                        usedPoint: self.rewardPoint,
                        remarks: "결제 적립 포인트",
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/point/used.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("포인트 적립 내역 저장 >>> ", data.result);

                        }
                    });
                },
                getDiscountPrice(item) {
                    if (!item.discount || item.discount === 0) return item.price;
                    return Math.floor(item.price * (1 - item.discount / 100));
                },
                getTotalPrice(item) {
                    return item.quantity * (this.isMembership ? this.getDiscountPrice(item) : item.price);
                },
                applyPoints() {
                    let self = this;
                    let usedPoints = parseInt(self.usedPoint) || 0;
                    let userPoints = parseInt(self.userPoint) || 0;
                    let finalPrice = 0;
                    if (parseInt(self.totalPrice) < 30000) {
                        finalPrice = parseInt(self.totalShippingPrice) || 0;
                    } else {
                        finalPrice = parseInt(self.totalPrice) || 0;
                    }
                    
                    if (usedPoints > finalPrice) {
                        alert("총 결제 금액보다 많은 포인트를 사용할 수 없습니다.");
                        self.usedPoint = finalPrice;
                    } else if (usedPoints > userPoints) {
                        alert("보유한 포인트보다 많은 포인트를 사용할 수 없습니다.");
                        self.usedPoint = userPoints;
                    } else {
                        self.usedPoint = usedPoints;
                    }
                    self.discountAmount = self.usedPoint;
                    self.$nextTick(() => {
                        self.$refs.usedPoint.focus();
                    });
                    return;
                },
                useAllPoints() {
                    this.usedPoint = Math.min(this.userPoint, this.finalPrice);
                    this.discountAmount = this.usedPoint;
                },
                validatePoints() {
                    this.usedPoint = parseInt(this.usedPoint) || 0;
                },
                setDefaultAddress() {
                    let self = this;
                    if (self.deliveryType === "default") {
                        self.orderInfo.receiver = self.userInfo.userName;
                        self.orderInfo.phone = self.userInfo.phoneNumber;
                        if (self.userInfo.address) {
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
                    if (self.deliveryType === "new") {
                        self.orderInfo.phonePrefix = "010";
                        self.orderInfo.phoneMiddle = "";
                        self.orderInfo.phoneSuffix = "";
                    }
                },
                searchAddress() {
                    let self = this;

                    new daum.Postcode({
                        oncomplete: function (data) {
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
                submitOrderCheck() {
                    let self = this;

                    if (!self.orderInfo.receiver) {
                        alert("수령인 성함을 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.receiverInput.focus();
                        });
                        return;
                    }
                    if (!self.orderInfo.baseAddress) {
                        alert("배송받을 주소를 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.zipcodeInput.focus();
                        });
                        return;
                    }
                    if (!self.orderInfo.phoneMiddle || !self.orderInfo.phoneSuffix) {
                        alert("휴대폰 번호를 정확히 입력해주세요.");
                        self.$nextTick(() => {
                            self.$refs.phoneMiddleInput.focus();
                        });
                        return;
                    }
                    
                    self.submitPointCheck();
                },
                submitPointCheck(){
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/point/current.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            if(self.userPoint != data.point.currentPoint){
                                alert("보유 포인트에 변동이 있습니다. 확인 후 결제해주세요.");
                                self.fnGetPoint();
                                self.$nextTick(() => {
                                    self.$refs.usedPoint.focus();
                                });
                                return;
                            } else {
                                self.submitOrder();
                            }
                        }
                    });
                },
                submitOrder:function(){
                    let self = this;

                    self.orderInfo.phone = (self.deliveryType === "new") ? self.orderInfo.phonePrefix + self.orderInfo.phoneMiddle + self.orderInfo.phoneSuffix : "";
                    let address = self.orderInfo.baseAddress + "," + self.orderInfo.detailAddress + "," + self.orderInfo.zipcode;
                    let finalAddress = self.deliveryType === "default" ? self.userInfo.address : address;
                    let finalMessage = self.orderInfo.deliveryMessage === "직접 입력" ? self.orderInfo.customMessage : self.orderInfo.deliveryMessage;
    
                    console.log(self.finalPrice);

                    if (self.finalPrice === 0) {
                        // 포인트 결제
                        let merchantUid = "free_order_" + new Date().getTime();
                        
                        let paymentData = {
                            merchant_uid: merchantUid,
                            name: "상품 구매 포인트 결제",
                            paid_amount: self.paid_amount,
                            pay_method: "point_only",
                            status: "paid",
                            card_quota: null
                        };
                        self.fnPaymentHistory(paymentData, self.paid_amount, finalAddress, finalMessage);
                        self.fnRemoveCart();
                        self.fnUsePoint();
                    } else {
                        // 일반 결제
                        self.fnPayment(self.finalPrice, finalAddress, finalMessage);
                    }
                },
                fnPayment: function (finalPrice, finalAddress, finalMessage) {
                    var self = this;

                    if (typeof IMP === 'undefined') {
                        console.error('IMP is not initialized');
                        return;
                    }

                    finalPrice = 100;

                    IMP.request_pay({
                        channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                        pg: "html5_inicis",
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: "상품 구매 결제",
                        amount: finalPrice,
                        buyer_tel: self.userInfo.phoneNumber,
                    }, function (rsp) {
                        if (rsp.success) {
                            console.log("결제 정보 >>> ", rsp);
                            self.fnPaymentHistory(rsp, self.paid_amount, finalAddress, finalMessage);
                            self.fnRemoveCart();
                            self.fnUsePoint();
                        } else {
                            alert("결제에 실패했습니다.");
                            console.log("결제 정보 >>> ", rsp.error_msg);

                        }
                    });
                },
                fnPaymentHistory: function (rsp, finaPrice, finalAddress, finalMessage) {
                    let self = this;

                    let paymentMethod = "";
                    if (rsp.pay_method === "card" && self.usedPoint == 0) {
                        paymentMethod = rsp.pay_method + "-" + rsp.card_name;
                    } else if (rsp.pay_method === "card" && self.usedPoint > 0) {
                        paymentMethod = rsp.pay_method + "-" + rsp.card_name + " + point";
                    } else {
                        paymentMethod = rsp.pay_method;
                    }

                    console.log("paymentMethod >>> ", paymentMethod);

                    var nparmap = {
                        paymentCode: rsp.merchant_uid,
                        description: rsp.name,
                        amount: self.paid_amount,
                        paymentMethod: paymentMethod,
                        installment: rsp.card_quota,
                        subscriptionPeriod: null,
                        paymentStatus: rsp.status,
                        isCanceled: "N",
                        cancelDate: null,
                        donationId: null,
                        userId: self.userInfo.userId,
                        usedPoint: self.usedPoint
                    };
                    $.ajax({
                        url: "/payment.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("결제 정보 저장 여부 >>> ", data);
                            self.fnOrderHistory(finaPrice, paymentMethod, finalAddress, finalMessage, data.orderId);

                        }
                    });
                },
                fnOrderHistory: function (finaPrice, paymentMethod, finalAddress, finalMessage, orderId) {
                    let self = this;
                    let payList = self.selectCartItems.map(item => ({
                        orderId: orderId,
                        productId: item.productId,
                        quantity: item.quantity,
                        price: self.getTotalPrice(item)
                    }))

                    self.orderData = {
                        orderId: orderId,
                        totalPrice: finaPrice,
                        userId: self.userInfo.userId,
                        receiverName: self.orderInfo.receiver || self.userInfo.userName,
                        receiverPhone: self.orderInfo.phone || self.userInfo.phoneNumber,
                        receiverAddr: finalAddress,
                        paymentMethod: paymentMethod,
                        deliveryMessage: finalMessage,
                        option: "order",
                        orderDetails: JSON.stringify(payList)
                    };

                    console.log("주문 데이터 >>>", self.orderData);

                    var nparmap = self.orderData;
                    $.ajax({
                        url: "/cart/order.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("주문 정보 저장 여부 >>> ", data.result);
                            if (data.result === "success") {
                                console.log("주문 상세 정보도 저장 완료");
                                alert("주문이 완료되었습니다.");
                                self.fnRewardPoint();
                                pageChange("/order/orderComplete.do",{userId:self.userInfo.userId,orderId:self.orderData.orderId});
                            }
                        }
                    });
                },
                fnRemoveCart: function () {
                    let self = this;
                    var nparmap = {
                        cartId: self.cartId
                    };
                    $.ajax({
                        url: "/cart/removeCart.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            if (data.result === "success") {
                                console.log("결제 후 장바구니 비우기 >>> ", data.result);
                            }
                        }
                    });
                },
                fnUsePoint: function () {
                    let self = this;
                    let usedPoint = -Math.abs(parseInt(self.usedPoint));

                    console.log("사용 포인트 >> ", usedPoint);

                    var nparmap = {
                        usedPoint: usedPoint,
                        remarks: "상품 구매 시 포인트 사용",
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/point/used.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("포인트 사용 내역 저장 >>> ", data.result);

                        }
                    });
                },
                test:function(){
                    pageChange("/order/orderComplete.do",{userId:"as879",orderId:100});
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