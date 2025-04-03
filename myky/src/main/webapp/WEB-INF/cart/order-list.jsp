<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 주문/배송조회</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
	
    <style>
    .order-body {font-family: 'Arial', sans-serif;background-color: #f4f7fc;}
    .order-container {max-width: 1280px;margin: 0 auto;padding: 20px;}
    .order-container h2 {text-align: center; margin: 50px;}
    .order-history {background: #ffffff;padding: 30px;border-radius: 10px;box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);}
    .order-history__filter {display: flex;align-items: center;gap: 15px;margin-bottom: 20px;flex-wrap: wrap;}
    .order-history__button {background: #ffaf7d;color: white;border: none;padding: 10px 20px;border-radius: 5px;cursor: pointer;transition: background 0.3s, transform 0.2s;font-size: 14px;}
    .order-history__button:hover {background: #f1a373;transform: scale(1.05);}
    .order-history__button:active {transform: scale(1);}
    .order-history__input, .order-history__select {padding: 8px 12px;border: 1px solid #ccc;border-radius: 5px;font-size: 14px;transition: border-color 0.3s;}
    .order-history__input:focus, .order-history__select:focus {border-color: #FF8C42;outline: none;}
    .order-history__table {width: 100%;border-collapse: collapse;margin-top: 20px;background-color: #ffffff;border-radius: 8px;overflow: hidden;}
    .order-history__table th, .order-history__table td {border: 1px solid #ddd;padding: 12px;text-align: center;}
    .order-history__table th {background-color: #ffaf7d;color: white;font-weight: bold;}
    .order-history__table td {background-color: #f9f9f9;}
    .order-history__table tr:hover {background-color: #f1f1f1;}
    .order-history__details-button {background-color: #ffbc93;color: white;border: none;padding: 8px 16px;border-radius: 5px;cursor: pointer;transition: background 0.3s;font-size: 14px;}
    .order-history__details-button:hover {background-color: #f1a373;}
    .order-history__details {background-color: #f1f1f1;padding: 20px;border-radius: 8px;margin-top: 10px;text-align: left;font-size: 14px;}
    .order-history__details hr {margin: 15px 0;}
    .order-history__details-table {width: 100%;border-collapse: collapse;margin-top: 10px;}
    .order-history__details-table th, .order-history__details-table td {border: 1px solid #ddd;padding: 8px 12px;text-align: left;}
    .order-history__details-table th {background-color: #fff0e4;font-weight: normal;color: #333;}
    .order-history__details-table td {background-color: #fff;}
    .order-date {font-size: 18px;font-weight: bold;background: #e9ecef;padding: 10px;margin-top: 20px;border-radius: 8px;color: #333;display: inline-block;}
    .order-id {font-weight: bold;font-size: 16px;margin-top: 10px;}
    .order-edit-form {background-color: #fff;padding: 20px;border: 1px solid #ddd;border-radius: 5px;box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);}
    .order-input {width: 100%;padding: 8px;margin: 5px 0;border: 1px solid #ccc;border-radius: 4px;font-size: 14px;}
    .order-input.short {width: 80px;text-align: center;}
    .order-button {background-color: #ffaf7d;color: white;padding: 8px 12px;border: none;border-radius: 4px;cursor: pointer;font-size: 14px; margin: 5px 20px 5px 0;}
    .order-button:hover {background-color: #f1a373;}
    .add-to-cart-button {background-color: white;color: black;border: 1px solid #ccc;padding: 5px 10px;border-radius: 5px;cursor: pointer;transition: all 0.3s ease;}
    .add-to-cart-button:hover {background-color: #f5f5f5;}
    .added-to-cart {background-color: #ffaf7d !important;color: white !important;border: 1px solid #ccc !important;}
    .cart-message {position: fixed;top: 50%;left: 50%;transform: translateX(-50%);background-color: rgba(255, 194, 154, 0.9);color: white;padding: 10px 20px;border-radius: 5px;font-size: 14px;transition: opacity 0.5s ease-in-out;opacity: 1;}
    .cart-message.fade-out {opacity: 0;}
    @keyframes fadeOut {0% { opacity: 1; }100% { opacity: 0; }}
    .exchange-return-popup-overlay {position: fixed;top: 0;left: 0;width: 100%;height: 100%;background: rgba(0, 0, 0, 0.5);display: flex;justify-content: center;align-items: center;z-index: 1000;}
    .exchange-return-popup-container {background: #fff;padding: 20px;border-radius: 8px;width: 500px;box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);text-align: center;}
    .exchange-return-popup-container h3 {margin-top: 30px;}
    .exchange-return-radio {display: inline-block;margin: 10px;font-size: 16px;}
    .exchange-return-checkbox {display: flex;align-items: center;margin: 0;}
    .exchange-return-box {padding: 5px;margin: 5px 40px;}
    .exchange-return-select {width: 400px;padding: 8px;margin-top: 5px;border: 1px solid #ccc;border-radius: 5px;}
    .exchange-return-textarea {width: 400px;height: 80px;padding: 8px;border: 1px solid #ccc;border-radius: 5px;resize: none;margin-top: 5px;}
    .exchange-return-notice {width: 450px;background: #f8f8f8;padding: 10px;margin: 15px auto;border-left: 4px solid #ff6600;font-size: 14px; text-align: left;}
    .exchange-return-agreement {display: flex;align-items: center;justify-content: center;margin: 10px 0;}
    .exchange-return-submit {background: #007aff;color: white;border: none;padding: 10px;width: 100%;border-radius: 5px;cursor: pointer;margin-top: 10px;}
    .exchange-return-submit:disabled {background: #ccc;cursor: not-allowed;}
    .exchange-return-close {background: #ddd;color: black;border: none;padding: 10px;width: 100%;border-radius: 5px;cursor: pointer;margin-top: 5px;}
    .disabled-item {color: gray;text-decoration: line-through;cursor: not-allowed;}
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="order-body">
        <div class="order-container">
            <h2>주문/배송조회</h2>
            <div class="order-history">
                <!-- 주문 조회 필터 -->
                <div class="order-history__filter">
                    <button @click="setDateRange(1)" class="order-history__button">최근 1개월</button>
                    <button @click="setDateRange(3)" class="order-history__button">최근 3개월</button>
                    <button @click="setDateRange(6)" class="order-history__button">최근 6개월</button>
                    <input type="date" v-model="startDate" class="order-history__input">
                    <span>~</span>
                    <input type="date" v-model="endDate" class="order-history__input">
                    <button @click="fnOrderList" class="order-history__button">조회</button>
                    <select v-model="orderStatus" @change="fnOrderList" class="order-history__select">
                        <option value="all">전체</option>
                        <option value="paid">주문접수</option>
                        <option value="shipped">배송중</option>
                        <option value="delivered">배송완료</option>
                    </select>
                </div>
                
                <!-- 주문 내역 테이블 -->
                <div v-for="(ordersByOrderId, date) in groupedOrders" :key="date">
                    <div class="order-date">{{ date }}</div>
                    <div v-for="(orders, orderId) in ordersByOrderId" :key="orderId">
                        <div class="order-id">주문번호: {{ orderId }}</div>
                        <table class="order-history__table">
                            <thead>
                                <tr>
                                    <th>수령인</th>
                                    <th>상품</th>
                                    <th>금액</th>
                                    <th>상태</th>
                                    <th>상세보기</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>{{ orders[0].receiverName }}</td>
                                    <td>
                                        {{ orders[0].productName }} 
                                        <span v-if="orders.length > 1"> 외 {{ orders.length - 1 }}개</span>
                                    </td>
                                    <td>{{ formatPrice(Number(orders[0].totalPrice)) }} 원</td>
                                    <td v-if="orders[0].orderStatus == 'paid'">주문접수</td>
                                    <td v-else-if="orders[0].orderStatus == 'cancel'">주문취소</td>
                                    <td v-else-if="orders[0].orderStatus == 'shipped'">배송중</td>
                                    <td v-else-if="orders[0].orderStatus == 'delivered'">배송완료</td>
                                    <td>
                                        <button class="order-history__details-button" @click="toggleDetails(orderId)">
                                            {{ ordersByDate[date][orderId][0].showDetails ? '숨기기' : '배송정보' }}
                                        </button>
                                    </td>
                                </tr>
                                <tr v-if="ordersByDate[date][orderId][0].showDetails">
                                    <td colspan="5">
                                        <div class="order-history__details">
                                            <div v-if="!isEditing">
                                                <p><strong>수령인:</strong> {{ orders[0].receiverName }}</p>
                                                <p><strong>연락처:</strong> {{ formatPhoneNumber(orders[0].receiverPhone) }}</p>
                                                <p><strong>배송지:</strong> {{ orders[0].receiverAddr }}</p>
                                                <p><strong>배송메시지:</strong> {{ orders[0].deliveryMessage || '없음' }}</p>
                                                <hr>
                                            </div>
                                            <div v-else class="order-edit-form">
                                                <label>수령인: 
                                                  <input type="text" class="order-input" v-model="orderInfo.receiver" required>
                                                </label><br>
                                          
                                                <label>우편번호:
                                                  <input type="text" class="order-input short" v-model="orderInfo.zipcode"
                                                    placeholder="우편번호" readonly>
                                                  <button type="button" @click="searchAddress">우편번호 검색</button>
                                                </label><br>
                                          
                                                <label>기본 주소:
                                                  <input type="text" class="order-input" v-model="orderInfo.baseAddress" placeholder="기본 주소" readonly>
                                                </label><br>
                                          
                                                <label>상세 주소:
                                                  <input type="text" class="order-input" v-model="orderInfo.detailAddress"
                                                    placeholder="상세 주소 입력">
                                                </label><br>
                                          
                                                <label>휴대폰 번호:
                                                  <select v-model="orderInfo.phonePrefix" class="order-input short" required>
                                                    <option value="010">010</option>
                                                    <option value="011">011</option>
                                                    <option value="016">016</option>
                                                    <option value="017">017</option>
                                                    <option value="018">018</option>
                                                    <option value="019">019</option>
                                                  </select> - 
                                                  <input type="text" class="order-input short"
                                                    v-model="orderInfo.phoneMiddle" maxlength="4" placeholder="1234" required> - 
                                                  <input type="text" class="order-input short" v-model="orderInfo.phoneSuffix" maxlength="4"
                                                    placeholder="5678" required>
                                                </label><br>
                                          
                                                <h3>배송 요청 사항</h3>
                                                <input type="text" class="order-input" v-model="orderInfo.customMessage" placeholder="배송 요청사항 입력">
                                                <div>
                                                    <button @click="saveChanges(orderId)" class="order-button">저장</button>
                                                    <button @click="cancelEdit" class="order-button">취소</button>
                                                </div>
                                            </div>

                                            <table class="order-history__details-table">
                                                <thead>
                                                    <tr>
                                                        <th>상품명</th>
                                                        <th>상태</th>
                                                        <th>수량</th>
                                                        <th>가격</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="product in orders" :key="product.orderId">
                                                        <td>{{ product.productName }}</td>
                                                        <td v-if="product.refundStatus != null && product.refundStatus == 'exchange'">교환접수</td>
                                                        <td v-else-if="product.refundStatus != null && product.refundStatus == 'return'">반품접수</td>
                                                        <td v-else-if="product.refundStatus == null && product.orderStatus == 'paid'">주문접수</td>
                                                        <td v-else-if="product.refundStatus == null && product.orderStatus == 'cancel'">주문취소</td>
                                                        <td v-else-if="product.refundStatus == null && product.orderStatus == 'shipped'">배송중</td>
                                                        <td v-else-if="product.refundStatus == null && product.orderStatus == 'delivered'">배송완료</td>
                                                        <td>{{ product.quantity }}</td>
                                                        <td>{{ formatPrice(Number(product.price)) }} 원</td>
                                                        <td>
                                                            <button @click="fnAddCart(product)" :class="['add-to-cart-button', {'added-to-cart': isAddedToCart(product.productId)}]"><span class="material-symbols-outlined">add_shopping_cart</span></button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div v-if="cartMessage" class="cart-message">{{ cartMessage }}</div>
                                            <div v-if="orders[0].orderStatus == 'paid'">
                                                <button @click="cancelOrder(orderId)" class="order-button">주문취소</button>
                                                <button @click="toggleEditMode(orders[0])" class="order-button">배송정보수정</button>
                                            </div>
                                            <div v-else-if="orders[0].orderStatus == 'delivered'">
                                                <button  @click="openReturnPopup(orders)" class="order-button">교환/반품신청</button>
                                            </div>
                                            <div>
                                                <p>※해당 주문건이 [주문접수] 상태일 때만 주문취소, 배송정보수정이 가능합니다.</p>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- 교환/반품 접수 팝업 -->
        <div class="exchange-return-popup-overlay" v-if="isPopupVisible">
            <div class="exchange-return-popup-container">
                <h2>교환/반품 신청</h2>
                
                <label class="exchange-return-radio">
                    <input type="radio" v-model="requestType" value="true"> 교환
                </label>
                <label class="exchange-return-radio">
                    <input type="radio" v-model="requestType" value="false"> 반품
                </label>

                <h3>주문 상품 선택</h3>
                <div v-for="item in selectedOrder" :key="item.productId" class="exchange-return-box">
                    <label :class="{'disabled-item': item.refundStatus != null}">
                        <input type="checkbox" v-model="selectedItems" :value="item.productId" :disabled="item.refundStatus != null"> {{ item.productName }}
                    </label>
                </div>

                <h3>{{ requestType === 'true' ? '교환 사유' : '반품 사유' }}</h3>
                <select v-model="reason" class="exchange-return-select">
                    <option value="">사유를 선택해주세요</option>
                    <option value="상품 불량">상품 불량</option>
                    <option value="오배송">오배송</option>
                    <option value="단순 변심">단순 변심</option>
                </select>
                
                <h3>상세 사유</h3>
                <textarea v-model="detailedReason" placeholder="상세 사유를 입력하세요" class="exchange-return-textarea"></textarea>

                <div class="exchange-return-notice">
                    <p>※ 교환/반품 시 배송비가 부과될 수 있습니다.</p>
                    <p>※ 신청 접수 후 고객님께서 보내주신 상품은 검수과정(주말 제외, 최대 5일)을 거쳐 결제 취소 요청이 진행됩니다.</p> 
                    <p>※ 상품의 상태 및 요청 내용에 따라 교환/반품이 불가능할 수 있습니다.</p>
                </div>

                <label class="exchange-return-agreement">
                    <input type="checkbox" v-model="isAgreed" @click="toggleAgreement"> 위 내용을 확인하였으며, 교환/반품 요청에 동의합니다.
                </label>

                <button @click="submitRequest" :disabled="!isAgreed" class="exchange-return-submit">접수하기</button>
                <button @click="closePopup" class="exchange-return-close">닫기</button>
            </div>
        </div>


    </div>
    <!-- app 종료 -->


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    document.addEventListener("DOMContentLoaded", function () {
        const app = Vue.createApp({
            data() {
                return {
                    sessionId:"${sessionId}",
                    userInfo:{},
                    orderId:"${map.orderId}",
                    orderList: [],
                    startDate: "",
                    endDate: "",
                    orderStatus: "all",
                    ordersByDate:{},
                    addedToCart:[],
                    cartMessage: "",
                    isFading: false,
                    timeoutMap: {},
                    messageTimeout: null,
                    editOrderInfoFlg : false,
                    isEditing: false,
                    orderInfo: {
                        receiver: "", 
                        zipcode: "", 
                        baseAddress: "", 
                        detailAddress: "", 
                        phonePrefix: "010", 
                        phoneMiddle: "", 
                        phoneSuffix: "", 
                        customMessage: ""
                    },
                    isPopupVisible: false,
                    selectedOrder: null,
                    isExchange: true, // true: 교환, false: 반품
                    selectedItems: [],
                    reason: "",
                    detailedReason:"",
                    isAgreed: false,
                    requestType:"exchange",
                };
            },
            computed: {
                groupedOrders() {
                    const groupedByDate = this.orderList
                        .map(order => {
                            let orderDate = new Date(order.orderedAt).toLocaleDateString('ko-KR', { 
                                year: 'numeric', 
                                month: '2-digit', 
                                day: '2-digit' 
                            }).replace(/\. /g, '-').replace('.', '');
                            // console.log("주문 날짜 변환: ",order.orderedAt, "→", orderDate);

                            return { ...order, formattedDate: orderDate };
                        })
                        .filter(order => {
                            // console.log("필터링: ",order.formattedDate, ">=", this.startDate, "&&", order.formattedDate, "<=", this.endDate);
                            return order.formattedDate >= this.startDate && order.formattedDate <= this.endDate;
                        })
                        .reduce((groups, order) => {
                            if (!groups[order.formattedDate]) {
                                groups[order.formattedDate] = {};
                            }
                            if (!groups[order.formattedDate][order.orderId]) {
                                groups[order.formattedDate][order.orderId] = [];
                            }
                            groups[order.formattedDate][order.orderId].push(order);
                            return groups;
                        }, {});

                        console.log("📌 날짜 및 주문번호별로 그룹화된 데이터:",groupedByDate);
                    return groupedByDate;
                },
            },
            watch: {
                groupedOrders: {
                    handler(newVal) {
                        this.ordersByDate = newVal ? JSON.parse(JSON.stringify(newVal)) : {};  // data 속성으로 반영
                    },
                    deep: true,
                    immediate: true
                }
            },
            methods: {
                setDateRange(period) {
                    let today = new Date();
                    let startDate = new Date();
                    
                    startDate.setMonth(today.getMonth() - period);

                    this.startDate = this.formatDate(startDate);
                    this.endDate = this.formatDate(today);

                    console.log(this.startDate,this.endDate);

                    this.fnOrderList();
                },
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
                            self.setDateRange(1);
                        }
                    });
                },
                fnOrderList:function(orderId){
                    let self = this;
                    let params = {
                        userId: self.userInfo.userId, 
                        startDate : self.startDate,
                        endDate : self.endDate,
                        orderStatus : self.orderStatus
                    };
                    $.ajax({
                        url: "/order/AllList.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("주문 상세 목록 >>> ",data.orderList);
                            self.orderList = data.orderList.map(order => ({
                                ...order,
                                showDetails: false
                            }));
                        }
                    });
                },
                toggleEditMode(order) {
                    console.log("배송정보수정 정보>>> ",order);
                    const fullAddress = order.receiverAddr; 
                    console.log("배송지 정보>>> ",order.receiverAddr);

                    const addressParts = fullAddress.split(", ");
                    const zipcode = addressParts.pop().trim();
                    const remainingAddress = addressParts.join(", ").trim(); 
                    const lastCommaIndex = remainingAddress.indexOf(", ");
                    let baseAddress = remainingAddress;
                    let detailAddress = "";

                    if (lastCommaIndex !== -1) {
                        baseAddress = remainingAddress.substring(0, lastCommaIndex).trim();
                        detailAddress = remainingAddress.substring(lastCommaIndex + 2).trim();
                    }

                    this.orderInfo.receiver = order.receiverName;
                    this.orderInfo.zipcode = zipcode;
                    this.orderInfo.baseAddress = baseAddress;
                    this.orderInfo.detailAddress = detailAddress;

                    function formatPhoneNumber(phoneNumber) {
                        if (!phoneNumber || phoneNumber.length < 10) return ["010", "", ""];

                        const prefix = phoneNumber.substring(0, 3);
                        let middle = "";
                        let suffix = "";

                        if (phoneNumber.length === 11) {
                            middle = phoneNumber.substring(3, 7);
                            suffix = phoneNumber.substring(7);
                        } else if (phoneNumber.length === 10) {
                            middle = phoneNumber.substring(3, 6);
                            suffix = phoneNumber.substring(6);
                        }

                        return [prefix, middle, suffix];
                    }

                    const [phonePrefix, phoneMiddle, phoneSuffix] = formatPhoneNumber(order.receiverPhone);
                    
                    this.orderInfo.phonePrefix = phonePrefix;
                    this.orderInfo.phoneMiddle = phoneMiddle;
                    this.orderInfo.phoneSuffix = phoneSuffix;

                    this.orderInfo.customMessage = order.deliveryMessage;
                    this.isEditing = true;
                },
                searchAddress() {
                    let self = this;

                    new daum.Postcode({
                        oncomplete: function (data) {
                            self.orderInfo.zipcode = data.zonecode;
                            self.orderInfo.baseAddress = data.address;
                            self.orderInfo.detailAddress = "";
                        }
                    }).open();
                },
                saveChanges(orderId) {
                    let self = this;

                    if (!self.orderInfo.receiver) {
                        alert("수령인 성함을 정확히 입력해주세요.");
                        return;
                    }
                    if (!self.orderInfo.baseAddress || !self.orderInfo.zipcode) {
                        alert("배송받을 주소를 정확히 입력해주세요.");
                        return;
                    }
                    if (!self.orderInfo.phoneMiddle || !self.orderInfo.phoneSuffix) {
                        alert("휴대폰 번호를 정확히 입력해주세요.");
                        return;
                    }

                    let receiverPhone = self.orderInfo.phonePrefix + self.orderInfo.phoneMiddle + self.orderInfo.phoneSuffix;
                    console.log(receiverPhone);
                    let receiverAddr = self.orderInfo.baseAddress + ", " + self.orderInfo.detailAddress + ", " + self.orderInfo.zipcode;
                    console.log(receiverAddr);
                    
                    let params = {
                        userId: self.userInfo.userId, 
                        orderId : orderId,
                        receiverName : self.orderInfo.receiver,
                        receiverPhone : receiverPhone,
                        receiverAddr : receiverAddr,
                        deliveryMessage: self.orderInfo.customMessage
                    };
                    $.ajax({
                        url: "/order/editInfo.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            console.log(data);
                            alert("주문/배송 정보가 수정되었습니다.");
                            self.isEditing = false;
                            self.fnOrderList(orderId);
                        }
                    });

                },
                cancelEdit() {
                    this.isEditing = false;
                },
                formatPhoneNumber(phoneNumber) {
                    if (!phoneNumber || phoneNumber.length < 10) return phoneNumber;

                    const prefix = phoneNumber.substring(0, 3);
                    let middle = "";
                    let suffix = "";

                    if (phoneNumber.length === 11) {
                        middle = phoneNumber.substring(3, 7);
                        suffix = phoneNumber.substring(7);
                    } else if (phoneNumber.length === 10) {
                        middle = phoneNumber.substring(3, 6);
                        suffix = phoneNumber.substring(6);
                    } else {
                        return phoneNumber;
                    }

                    return prefix + "-" + middle + "-" + suffix;
                },
                formatPrice(value) {
                    if (isNaN(value) || value === null) return "0";
                    return value.toLocaleString("ko-KR");
                },
                formatDate(date) {
                    let year = date.getFullYear();
                    let month = ('0' + (date.getMonth() + 1)).slice(-2);
                    let day = ('0' + date.getDate()).slice(-2);
                    return year + "-" + month + "-" + day;
                },
                cancelOrder(orderId) {
                    let self = this;
                    console.log("취소할 주문 번호 >>> ",orderId);
                    if(confirm("정말 해당 주문을 취소하시겠습니까?")){
                        let params = {
                            userId: self.userInfo.userId, 
                            orderId : orderId,
                            orderStatus : "cancel"
                        };
                        $.ajax({
                            url: "/order/status.dox",
                            type: "POST",
                            data: params,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                alert("주문이 취소되었습니다.");
                                self.fnOrderList();
                            }
                        });
                    }
                },
                toggleDetails(orderIdToToggle) {
                    for (let date in this.ordersByDate) {
                        for (let orderId in this.ordersByDate[date]) {
                            this.ordersByDate[date][orderId].forEach(order => {
                                // 각 주문에 대해서만 showDetails를 토글
                                if (order.orderId === orderIdToToggle) {
                                    order.showDetails = !order.showDetails;
                                    this.isEditing = false;
                                    console.log("주문번호: ",orderIdToToggle,"의 showDetails: ",order.showDetails);
                                } else {
                                    this.isEditing = false;
                                    order.showDetails = false;  // 다른 주문의 showDetails는 false로 설정
                                }
                            });
                        }
                    }
                    console.log(this.ordersByDate);
                },
                fnAddCart:function(product){
                    let self = this;
                    console.log("장바구니에 담을 상품 정보 >>> ",product);
                    let params = {
                        sessionId:self.sessionId,
                        userId: self.userInfo.userId, 
                        productId : product.productId,
                        quantity : 1,
                        option: "",
                        checkYn : "N"
                    };
                    $.ajax({
                        url: "/cart/addProduct.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            console.log(data);
                            if (!self.addedToCart.includes(product.productId)) {
                                self.addedToCart.push(product.productId);
                            }

                            if (self.messageTimeout) {
                                clearTimeout(self.messageTimeout);
                            }

                            self.isFading = false;
                            self.cartMessage = product.productName+" 상품이 장바구니에 추가되었습니다!";
                            
                            self.messageTimeout = setTimeout(() => {
                                self.cartMessage = "";
                                setTimeout(() => {
                                    self.cartMessage = "";
                                    self.isFading = false;
                                }, 500);
                            }, 2000);

                            if (self.timeoutMap[product.productId]) {
                                clearTimeout(self.timeoutMap[product.productId]);
                            }

                            self.timeoutMap[product.productId] = setTimeout(() => {
                                self.addedToCart = self.addedToCart.filter(id => id !== product.productId);
                            }, 2000);
                        }
                    });
                },
                isAddedToCart(productId) {
                    return this.addedToCart.includes(productId);
                },
                openReturnPopup(order) {
                    console.log("주문 정보 >>> ",order);
                    this.selectedOrder = order;
                    this.isPopupVisible = true;
                },
                closePopup() {
                    this.isPopupVisible = false;
                },
                toggleAgreement() {
                    this.isAgreed = !this.isAgreed;
                },
                submitRequest() {
                    if (this.selectedItems.length === 0) {
                        alert("상품을 선택해주세요.");
                        return;
                    }
                    if (!this.reason) {
                        alert("교환/반품 사유를 선택해주세요.");
                        return;
                    }
                    if (!this.detailedReason) {
                        alert("상세 사유를 작성해주세요.");
                        return;
                    }
                    
                    let productIds = Object.values(this.selectedItems).map(productId => productId);

                    console.log(JSON.stringify(productIds));

                    console.log("교환/반품 신청 데이터:", {
                        orderId : this.selectedOrder[0].orderId,
                        product : JSON.stringify(productIds),
                        reason: this.reason,
                        reasonDetail: this.detailedReason,
                        refundStatus : this.isExchange ? "exchange" : "return",
                    });

                    let params = {
                        orderId : this.selectedOrder[0].orderId,
                        product : JSON.stringify(productIds),
                        reason: this.reason,
                        reasonDetail: this.detailedReason,
                        refundStatus : this.isExchange ? "exchange" : "return"
                    };
                    $.ajax({
                        url: "/order/refund.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            console.log("교환/반품 접수 상태 >>> ",data);
                            if(data.result == "success"){
                                alert("교환/반품 신청이 접수되었습니다.");
                                this.isPopupVisible = false;
                            }
                        }
                    });

                }
            },
            mounted() {
                this.fnUserInfo();
                
            }
        });

        app.mount("#app");
    });
</script>