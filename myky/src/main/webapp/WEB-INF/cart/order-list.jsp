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
    <link rel="stylesheet" type="text/css" href="/css/cart/cart.css" />
    
    <style>
    
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
                    <select v-model="selectedStatus" @change="fnOrderList" class="order-history__select">
                        <option value="all">전체</option>
                        <option value="paid">주문접수</option>
                        <option value="shipped">배송중</option>
                        <option value="delivered">배송완료</option>
                        <option value="exchange_return">교환/반품</option>
                        <option value="canceled">주문취소</option>
                    </select>
                </div>
                
                <!-- 주문 내역 테이블 -->
                <div v-if="isEmptyOrderList" class="empty-order" v-cloak>
                    <p class="empty-order__text">주문하신 내역이 없습니다.</p>
                    <a href="/product/list.do" class="empty-order__link">상품 둘러보기</a>
                </div>
                <div v-for="(ordersByOrderId, date) in groupedOrders" :key="date">
                    <div class="order-date">{{ date }}</div>
                    <div v-for="(orders, orderId) in ordersByOrderId" :key="orderId" :id="'order-' + orderId">
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
                                    <td>{{ determineShippingStatus(orders) }}</td>
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
                                                <p><strong>수령인 : </strong> {{ orders[0].receiverName }}</p>
                                                <p><strong>연락처 : </strong> {{ formatPhoneNumber(orders[0].receiverPhone) }}</p>
                                                <p><strong>배송지 : </strong> {{ orders[0].receiverAddr }}</p>
                                                <p><strong>배송메시지 : </strong> {{ orders[0].deliveryMessage || '없음' }}</p>
                                                <hr>
                                            </div>
                                            <div v-else class="order-edit-form">
                                                <label> 수령인 :　
                                                  <input type="text" class="order-input short" v-model="orderInfo.receiver" required>
                                                </label><br>
                                          
                                                <label>우편번호 : 
                                                  <input type="text" class="order-input short form-margin" v-model="orderInfo.zipcode"
                                                    placeholder="우편번호" readonly> 
                                                  <button type="button" @click="searchAddress" class="order-button">우편번호 검색</button>
                                                </label><br>
                                          
                                                <label>기본 주소 : 
                                                  <input type="text" class="order-input" v-model="orderInfo.baseAddress" placeholder="기본 주소" readonly>
                                                </label><br>
                                          
                                                <label>상세 주소 : 
                                                  <input type="text" class="order-input" v-model="orderInfo.detailAddress"
                                                    placeholder="상세 주소 입력">
                                                </label><br>
                                          
                                                <label>휴대폰 번호 : 
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
                                                        <td v-if="product.refundStatus != 'none' && product.refundStatus == 'exchange'">교환접수</td>
                                                        <td v-else-if="product.refundStatus != 'none' && product.refundStatus == 'exchanged'">교환완료</td>
                                                        <td v-else-if="product.refundStatus != 'none' && product.refundStatus == 'return'">반품접수</td>
                                                        <td v-else-if="product.refundStatus != 'none' && product.refundStatus == 'returned'">반품완료</td>
                                                        <td v-else-if="product.refundStatus != 'none' && product.refundStatus == 'shipped'">배송중</td>
                                                        <td v-else-if="product.refundStatus != 'none' && product.refundStatus == 'delivered'">배송완료</td>
                                                        <td v-else-if="product.refundStatus == 'none' && product.orderStatus == 'paid'">주문접수</td>
                                                        <td v-else-if="product.refundStatus == 'none' && product.orderStatus == 'cancel'">주문취소</td>
                                                        <td v-else-if="product.refundStatus == 'none' && product.orderStatus == 'canceled'">환불완료</td>
                                                        <td>{{ product.quantity }}</td>
                                                        <td>{{ formatPrice(Number(product.price)) }} 원</td>
                                                        <td>
                                                            <button @click="fnAddCart(product)" :class="['add-to-cart-button', {'added-to-cart': isAddedToCart(product.productId)}]"><span class="material-symbols-outlined">add_shopping_cart</span></button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div v-if="cartMessage" class="cart-message">{{ cartMessage }}</div>
                                            <span v-if="determineShippingStatus(orders) == '주문접수'">
                                                <button @click="cancelOrder(orders,orderId)" class="order-button">주문취소</button>
                                                <button @click="toggleEditMode(orders)" class="order-button">배송정보수정</button>
                                            </span>
                                            <span v-if="hasDeliveredProduct(orders)">
                                                <button @click="openReturnPopup(orders)" class="order-button">교환/반품신청</button>
                                            </span>
                                            <div>
                                                <p>※해당 주문건이 [주문접수] 상태일 때만 주문취소, 배송정보수정이 가능합니다.</p>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <hr class="order-history__hr">
                </div>
            </div>
        </div>
        <!-- 교환/반품 접수 팝업 -->
        <div class="exchange-return-popup-overlay" v-if="isPopupVisible" v-cloak>
            <div class="exchange-return-popup-container">
                <h2>교환/반품 신청</h2>
                
                <div class="exchange-return-popup-scroll-area">
                    <label class="exchange-return-radio">
                        <input type="radio" v-model="isExchange" value="exchange"> 교환
                    </label>
                    <label class="exchange-return-radio">
                        <input type="radio" v-model="isExchange" value="return"> 반품
                    </label>
    
                    <h3>주문 상품 선택</h3>
                    <div v-for="item in selectedOrder" :key="item.orderDetailId" class="exchange-return-box">
                        <label :class="{'disabled-item': item.refundStatus != 'delivered'}">
                            <input type="checkbox" v-model="item.checked" :disabled="item.refundStatus != 'delivered'"> {{ item.productName }}
                        </label>
    
                        <div v-if="item.checked">
                            <label>수량 선택:
                                <select v-model="item.selectedQuantity" class="exchange-return-select">
                                    <option v-for="n in Array.from({ length: item.quantity }, (_, i) => i + 1)" :key="n" :value="n">{{ n }}</option>
                                </select>
                            </label>
                        </div>
                    </div>
    
                    <h3>{{ isExchange === 'exchange' ? '교환 사유' : '반품 사유' }}</h3>
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
                </div>
    
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
                    focusOrderId:"${map.orderId}",
                    userInfo:{},
                    orderList: [],
                    startDate: "",
                    endDate: "",
                    selectedStatus: 'all',
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
                    isExchange: "exchange",
                    selectedQuantity:"",
                    reason: "",
                    detailedReason:"",
                    isAgreed: false,
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

                            return { ...order, formattedDate: orderDate };
                        })
                        .filter(order => {
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

                    return groupedByDate;
                },isEmptyOrderList() {
                    return Object.keys(this.groupedOrders).length === 0;
                },
                determineShippingStatus() {
                    return (orderItems) => {
                        const statuses = orderItems.map(item => item.refundStatus);
                        const orderStatus = orderItems[0].orderStatus;

                        if (orderStatus === 'cancel') return '주문취소';
                        if (orderStatus === 'canceled') return '환불완료';

                        const statusPriority = {
                            'returned': 1,
                            'exchanged': 2,
                            'return': 3,
                            'exchange': 4,
                            'delivered': 5,
                            'shipped': 6,
                            'none': 7
                        };

                        let highestPriorityStatus = 'none';
                        let highestPriority = 7;

                        statuses.forEach(status => {
                            if (statusPriority[status] < highestPriority) {
                                highestPriority = statusPriority[status];
                                highestPriorityStatus = status;
                            }
                        });

                        switch (highestPriorityStatus) {
                            case 'none': return '주문접수';
                            case 'shipped': return '배송중';
                            case 'delivered': return '배송완료';
                            case 'exchange': return '교환신청';
                            case 'exchanged': return '교환완료';
                            case 'return': return '반품신청';
                            case 'returned': return '반품완료';
                            default: return '주문접수';
                        }
                    };
                }
            },
            watch: {
                groupedOrders: {
                    handler(newVal) {
                        this.ordersByDate = newVal ? JSON.parse(JSON.stringify(newVal)) : {};  // data 속성으로 반영
                    },
                    deep: true,
                    immediate: true
                },
                orderList(newList) {
                    if (this.focusOrderId && newList.length > 0) {
                        this.$nextTick(() => {
                            this.scrollToOrder(this.focusOrderId);
                        });
                    }
                }
            },
            methods: {
                setDateRange(period) {
                    let today = new Date();
                    let startDate = new Date();
                    
                    startDate.setMonth(today.getMonth() - period);

                    this.startDate = this.formatDate(startDate);
                    this.endDate = this.formatDate(today);

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
                    let refundStatuses;
                    let orderStatuses;
                    
                    if (self.selectedStatus === 'exchange_return') {
                        refundStatuses = ['exchange', 'exchanged', 'return', 'returned'];
                    } else if (self.selectedStatus === 'shipped' || self.selectedStatus === 'delivered') {
                        refundStatuses = [self.selectedStatus];
                    } else if (self.selectedStatus === 'canceled') {
                        orderStatuses = ['cancel', 'canceled'];
                    } else if (self.selectedStatus === 'paid') {
                        orderStatuses = ['paid'];
                        refundStatuses = ['none'];
                    }

                    let params = {
                        userId: self.userInfo.userId, 
                        startDate : self.startDate,
                        endDate : self.endDate,
                    };

                    if(refundStatuses != null){
                        params.refundStatuses = JSON.stringify(refundStatuses);
                    }
                    if (orderStatuses != null){
                        params.orderStatuses = JSON.stringify(orderStatuses);
                    }

                    $.ajax({
                        url: "/order/AllList.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            self.orderList = data.orderList.map(order => ({
                                ...order,
                                showDetails: false
                            }));
                        }
                    });
                },
                toggleEditMode(orders) {
                    const invalidStatuses = ['shipped', 'delivered', 'exchange', 'exchanged', 'return', 'returned'];
                    const hasInvalidStatus = orders.some(order =>
                        invalidStatuses.includes(order.refundStatus)
                    );
                    
                    if (hasInvalidStatus) {
                        alert("배송이 시작된 상품 또는 교환/반품 중인 상품이 포함되어 있어 배송정보를 수정할 수 없습니다.");
                        return;
                    }
                    
                    let order = orders[0];

                    const fullAddress = order.receiverAddr; 

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
                    let receiverAddr = self.orderInfo.baseAddress + ", " + self.orderInfo.detailAddress + ", " + self.orderInfo.zipcode;
                    
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
                cancelOrder(orders,orderId) {
                    let self = this;

                    const invalidStatuses = ['shipped', 'delivered', 'exchange', 'exchanged', 'return', 'returned'];
                    const hasInvalidStatus = orders.some(order =>
                        invalidStatuses.includes(order.refundStatus)
                    );

                    if (hasInvalidStatus) {
                        alert("배송이 시작된 상품 또는 교환/반품 중인 상품이 포함되어 있어 주문을 취소할 수 없습니다.");
                        return;
                    }
                    
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
                                } else {
                                    this.isEditing = false;
                                    order.showDetails = false;  // 다른 주문의 showDetails는 false로 설정
                                }
                            });
                        }
                    }
                },
                fnAddCart:function(product){
                    let self = this;
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
                    this.selectedOrder = order.map(item => ({
                        ...item,
                        checked: false,
                        selectedQuantity: 1
                    }));
                    this.isPopupVisible = true;
                },
                closePopup() {
                    this.isPopupVisible = false;
                },
                toggleAgreement() {
                    this.isAgreed = !this.isAgreed;
                },
                submitRequest() {
                    let self = this;

                    const selectedItems = self.selectedOrder
                        .filter(item => item.checked && item.refundStatus === 'delivered')
                        .map(item => ({
                        orderDetailId: item.orderDetailId,
                        quantity: item.selectedQuantity,
                        price:(item.price/item.quantity)*item.selectedQuantity
                    }));
                    
                    if (selectedItems.length === 0) {
                        alert("상품을 선택해주세요.");
                        return;
                    }
                    if (!self.reason) {
                        alert("교환/반품 사유를 선택해주세요.");
                        return;
                    }
                    if (!self.detailedReason) {
                        alert("상세 사유를 작성해주세요.");
                        return;
                    }
                    
                    let refundStatus = self.isExchange === "exchange" ? "exchange" : "return";

                    let params = {
                        orderId : self.selectedOrder[0].orderId,
                        selectedItems : JSON.stringify(selectedItems),
                        reason: self.reason,
                        reasonDetail: self.detailedReason,
                        refundStatus : refundStatus
                    };
                    $.ajax({
                        url: "/order/refund.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            if(data.result == "success"){
                                alert("교환/반품 신청이 접수되었습니다.");
                                self.isPopupVisible = false;
                                self.fnOrderList();
                            }
                        }
                    });
                },
                scrollToOrder(orderId) {
                    const target = document.getElementById('order-' + orderId);
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        target.classList.add('highlight-order');
                        setTimeout(() => target.classList.remove('highlight-order'), 2000);
                    } else {
                        console.warn("⚠️ 해당 orderId를 가진 요소가 존재하지 않습니다.");
                    }
                },
                hasDeliveredProduct(orders) {
                    return orders.some(item => item.refundStatus === 'delivered');
                },
            },
            mounted() {
                this.fnUserInfo();

                let orderId = this.focusOrderId;
                if (orderId) {
                    this.$nextTick(() => {
                        this.scrollToOrder(orderId);
                    });
                }
                
            }
        });

        app.mount("#app");
    });
</script>