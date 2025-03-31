<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
    
    .order-history { max-width: 900px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); }
    .order-history__title { text-align: center; margin-bottom: 20px; }
    .order-history__filter { display: flex; justify-content: center; align-items: center; gap: 10px; margin-bottom: 20px; }
    .order-history__button { padding: 8px 15px; border: none; background-color: #007bff; color: white; cursor: pointer; border-radius: 4px; }
    .order-history__button:hover { background-color: #0056b3; }
    .order-history__input { padding: 5px; border: 1px solid #ccc; border-radius: 4px; width: 150px; }
    .order-history__table { width: 100%; border-collapse: collapse; }
    .order-history__th, .order-history__td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    .order-history__th { background-color: #007bff; color: white; }
    .order-history__track-button { background-color: #28a745; border: none; padding: 5px 10px; color: white; cursor: pointer; border-radius: 4px; }
    .order-history__track-button:hover { background-color: #218838; }
    .order-history__details { margin-top: 10px; background-color: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #ddd; }
    .order-history__details p { margin: 5px 0; }
    .order-history__toggle { cursor: pointer; color: #007bff; text-decoration: underline; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">

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
            </div>
            
            <!-- 주문 상태 필터 -->
            <div class="order-history__filter">
                <select v-model="orderStatus" @change="fnOrderList" class="order-history__select">
                    <option value="all">전체</option>
                    <option value="paid">결제완료</option>
                    <option value="shipped">배송중</option>
                    <option value="delivered">배송완료</option>
                </select>
            </div>
    
            <!-- 주문 내역 테이블 -->
            <table class="order-history__table">
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>수령인</th>
                        <th>상품</th>
                        <th>금액</th>
                        <th>상태</th>
                        <th>상세보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="order in orders" :key="order.order_id">
                        <td>{{ order.order_id }}</td>
                        <td>{{ order.receiver_name }}</td>
                        <td>{{ order.product_name }}</td>
                        <td>{{ order.total_price }} 원</td>
                        <td>{{ order.status }}</td>
                        <td>
                            <button @click="toggleDetails(order.order_id)">
                                {{ order.showDetails ? '숨기기' : '보기' }}
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
    
            <!-- 주문 상세 정보 토글 -->
            <div v-if="selectedOrder && selectedOrder.showDetails" class="order-history__details">
                <p><strong>수령인:</strong> {{ selectedOrder.receiver_name }}</p>
                <p><strong>연락처:</strong> {{ selectedOrder.receiver_phone }}</p>
                <p><strong>배송지:</strong> {{ selectedOrder.receiver_addr }}</p>
                <p><strong>배송메시지:</strong> {{ selectedOrder.delivery_message || '없음' }}</p>
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
                    orderId:"${map.orderId}",
                    orders: [],
                    startDate: "",
                    endDate: "",
                    orderStatus: "all",
                    selectedOrder: null,
                };
            },
            computed: {
                
            },
            methods: {
                setDateRange(period) {
                    let today = new Date();
                    let startDate = new Date();

                    if (period == 1) {
                        startDate.setMonth(today.getMonth() - 1);
                    } else if (period == 3) {
                        startDate.setMonth(today.getMonth() - 3);
                    } else if (period == 6) {
                        startDate.setMonth(today.getMonth() - 6);
                    }

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
                        endDate : self.endDate
                    };
                    $.ajax({
                        url: "/order/AllList.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("주문 상세 목록 >>> ",data.result);
                            self.orderList = data.orderList;
                            self.orderList = data.orderList.map(order => ({
                                ...order,
                                showDetails: false
                            }));
                        }
                    });
                },

                formatDate(date) {
                    let year = date.getFullYear();
                    let month = ('0' + (date.getMonth() + 1)).slice(-2);
                    let day = ('0' + date.getDate()).slice(-2);
                    return year + "-" + month + "-" + day;
                },

                cancelOrder(orderId) {
                    alert("주문이 취소되었습니다. 주문번호: " + orderId);
                },

                editShipping(orderId) {
                    alert("배송정보 수정 페이지로 이동합니다. 주문번호: " + orderId);
                },

                requestReturn(orderId) {
                    alert("반품 신청이 완료되었습니다. 주문번호: " + orderId);
                },

                requestExchange(orderId) {
                    alert("교환 신청이 완료되었습니다. 주문번호: " + orderId);
                },
                toggleDetails(index) {
                    // 해당 주문에 대해 배송정보를 토글
                    this.orders[index].showDetails = !this.orders[index].showDetails;
                },
                
            },
            mounted() {
                this.fnUserInfo();
                
            }
        });

        app.mount("#app");
    });
</script>