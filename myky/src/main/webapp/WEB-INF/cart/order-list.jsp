<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
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
    .add-to-cart-button {background-color: white;color: black;border: 1px solid #ccc;padding: 5px 10px;border-radius: 5px;cursor: pointer;transition: all 0.3s ease;}
    .add-to-cart-button:hover {background-color: #f5f5f5;}
    .added-to-cart {background-color: #ffaf7d !important;color: white !important;border: 1px solid #ccc !important;}
    .cart-message {position: fixed;top: 50%;left: 50%;transform: translateX(-50%);background-color: rgba(255, 194, 154, 0.9);color: white;padding: 10px 20px;border-radius: 5px;font-size: 14px;transition: opacity 0.5s ease-in-out;opacity: 1;}
    .cart-message.fade-out {opacity: 0;}
    @keyframes fadeOut {0% { opacity: 1; }100% { opacity: 0; }}
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
                                    <td v-if="orders[0].orderStatus == 'cancel'">주문취소</td>
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
                                            <p><strong>수령인:</strong> {{ orders[0].receiverName }}</p>
                                            <p><strong>연락처:</strong> {{ orders[0].receiverPhone }}</p>
                                            <p><strong>배송지:</strong> {{ orders[0].receiverAddr }}</p>
                                            <p><strong>배송메시지:</strong> {{ orders[0].deliveryMessage || '없음' }}</p>
                                            <hr>
                                            <table class="order-history__details-table">
                                                <thead>
                                                    <tr>
                                                        <th>상품명</th>
                                                        <th>수량</th>
                                                        <th>가격</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="product in orders" :key="product.orderId">
                                                        <td>{{ product.productName }}</td>
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
                                                <button @click="cancelOrder(orderId)">주문취소</button>
                                                <button @click="editShipping(orderId)">배송정보수정</button>
                                            </div>
                                            <div v-else-if="orders[0].orderStatus == 'delivered'">
                                                <button @click="requestReturnExchange(orderId)">교환/반품신청</button>
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
                    messageTimeout: null
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

                    const sortedGroupedByDate = Object.keys(groupedByDate)
                        .sort((a, b) => new Date(b) - new Date(a)) // 날짜 내림차순
                        .reduce((sortedGroups, date) => {
                            const sortedOrderIds = Object.keys(groupedByDate[date])
                            .sort((x, y) => Number(y) - Number(x)); // 주문번호 내림차순 정렬
                            console.log(sortedOrderIds);

                            // 정렬된 주문번호를 바탕으로 새로운 객체 구성
                            sortedGroups[date] = sortedOrderIds.reduce((acc, orderId) => {
                                acc[orderId] = groupedByDate[date][orderId];
                                return acc;
                            }, {});

                            return sortedGroups;
                        }, {});
                        console.log("📌 날짜 및 주문번호별로 그룹화된 데이터:",sortedGroupedByDate);
                    return sortedGroupedByDate;
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
                fnOrderList:function(){
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
                                alert("주문이 취소되었습니다. 주문번호: " + orderId);
                                self.fnOrderList();
                            }
                        });
                },

                editShipping(orderId) {
                    alert("배송정보 수정 페이지로 이동합니다. 주문번호: " + orderId);
                },

                requestReturnExchange(orderId) {
                    alert("교환/반품 신청이 완료되었습니다. 주문번호: " + orderId);
                },
                toggleDetails(orderIdToToggle) {
                    for (let date in this.ordersByDate) {
                        for (let orderId in this.ordersByDate[date]) {
                            this.ordersByDate[date][orderId].forEach(order => {
                                // 각 주문에 대해서만 showDetails를 토글
                                if (order.orderId === orderIdToToggle) {
                                    order.showDetails = !order.showDetails;
                                    console.log("주문번호: ",orderIdToToggle,"의 showDetails: ",order.showDetails);
                                } else {
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
                }
                
            },
            mounted() {
                this.fnUserInfo();
                
            }
        });

        app.mount("#app");
    });
</script>