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
    .order-history__label { font-weight: bold; }
    .order-history__select { padding: 5px; border: 1px solid #ccc; border-radius: 4px; }
    .order-history__button { padding: 8px 15px; border: none; background-color: #007bff; color: white; cursor: pointer; border-radius: 4px; }
    .order-history__button:hover { background-color: #0056b3; }
    .order-history__table { width: 100%; border-collapse: collapse; }
    .order-history__th, .order-history__td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    .order-history__th { background-color: #007bff; color: white; }
    .order-history__track-button { background-color: #28a745; border: none; padding: 5px 10px; color: white; cursor: pointer; border-radius: 4px; }
    .order-history__track-button:hover { background-color: #218838; }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">

        <div class="order-history">
            <h2 class="order-history__title">주문 내역 조회</h2>
    
            <div class="order-history__filter">
                <label class="order-history__label">조회 기간:</label>
                <select v-model="selectedPeriod" @change="setDateRange" class="order-history__select">
                    <option value="1">최근 1개월</option>
                    <option value="3">최근 3개월</option>
                    <option value="6">최근 6개월</option>
                    <option value="12">최근 12개월</option>
                    <option :value="lastYear">{{ lastYear }}년</option>
                    <option :value="twoYearsAgo">{{ twoYearsAgo }}년</option>
                </select>
                <button @click="fnOrderInfo" class="order-history__button">조회</button>
            </div>
    
            <div v-for="(orders, orderDate) in groupedOrders" :key="orderDate" class="order-group">
                <h3 class="order-group__date">{{ orderDate }}</h3>
    
                <table class="order-history__table">
                    <thead>
                        <tr>
                            <th class="order-history__th">상품 이미지</th>
                            <th class="order-history__th">상품명</th>
                            <th class="order-history__th">총 금액</th>
                            <th class="order-history__th">주문 상태</th>
                            <th class="order-history__th">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="order in orders" :key="order.orderDetailId">
                            <td class="order-history__td">
                                <img :src="order.imageUrl" width="50" class="order-history__img">
                            </td>
                            <td class="order-history__td">{{ order.productName }}</td>
                            <td class="order-history__td">{{ order.totalPrice }} 원</td>
                            <td class="order-history__td">{{ order.status }}</td>
                            <td class="order-history__td">
                                <!-- '주문 접수' 상태일 때만 취소 & 수정 가능 -->
                                <button 
                                    v-if="order.status === '주문접수'" 
                                    @click="cancelOrder(order.orderId)" 
                                    class="order-history__button cancel"
                                >
                                    주문 취소
                                </button>
                                <button 
                                    v-if="order.status === '주문접수'" 
                                    @click="editShipping(order.orderId)" 
                                    class="order-history__button edit"
                                >
                                    배송정보 수정
                                </button>
    
                                <!-- '배송준비중' 이후에는 반품 & 교환 가능 -->
                                <button 
                                    v-if="order.status === '배송중' || order.status === '배송완료'" 
                                    @click="requestReturn(order.orderId)" 
                                    class="order-history__button return"
                                >
                                    반품 신청
                                </button>
                                <button 
                                    v-if="order.status === '배송중' || order.status === '배송완료'" 
                                    @click="requestExchange(order.orderId)" 
                                    class="order-history__button exchange"
                                >
                                    교환 신청
                                </button>
    
                                <!-- 배송정보 토글 버튼 -->
                                <button 
                                    @click="toggleDetails(order.orderId)" 
                                    class="order-history__button toggle"
                                >
                                    배송정보 {{ orderList[order.orderId] ? '숨기기' : '보기' }}
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
    
                <!-- 배송정보 토글 영역 -->
                <div v-if="orderList[orders[0].orderId]" class="order-history__details">
                    <p><strong>수령인:</strong> {{ orders[0].receiverName }}</p>
                    <p><strong>연락처:</strong> {{ orders[0].receiverPhone }}</p>
                    <p><strong>배송지:</strong> {{ orders[0].receiverAddress }}</p>
                    <p><strong>배송메시지:</strong> {{ orders[0].deliveryMessage || '없음' }}</p>
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
                    orderId:"${map.orderId}",
                    selectedPeriod: "1",
                    orderInfo: [],
                    orderList: [],
                    userInfo : {},
                    currentYear: new Date().getFullYear()
                };
            },
            computed: {
                lastYear() {
                    return this.currentYear - 1;
                },
                twoYearsAgo() {
                    return this.currentYear - 2;
                },
                groupedOrders() {
                    return this.orderInfo.reduce((acc, order) => {
                        (acc[order.orderDate] = acc[order.orderDate] || []).push(order);
                        return acc;
                    }, {});
                }
            },
            methods: {
                setDateRange() {
                    let today = new Date();
                    let startDate = new Date();

                    if (this.selectedPeriod == this.lastYear) {
                        this.startDate = this.lastYear + "-01-01";
                        this.endDate = this.lastYear + "-12-31";
                    } else if (this.selectedPeriod == this.twoYearsAgo) {
                        this.startDate = this.twoYearsAgo + "-01-01";
                        this.endDate = this.twoYearsAgo + "-12-31";
                    } else {
                        startDate.setMonth(today.getMonth() - parseInt(this.selectedPeriod));
                        this.startDate = this.formatDate(startDate);
                        this.endDate = this.formatDate(today);
                    }
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
                        }
                    });
                },
                fnOrderInfo() {
                    let self = this;
                    let params = { userId: self.userInfo.userId };

                    $.ajax({
                        url: "/order/AllInfo.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("주문 목록 >>> ",data.result);
                            self.orderInfo = data.orderInfo;
                            self.fnOrderList();
                        }
                    });
                },
                fnOrderList:function(){
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/order/AllList.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            console.log("주문 상세 목록 >>> ",data.result);
                            self.orderList = data.orderList;
                        }
                    });
                },

                formatDate(date) {
                    let year = date.getFullYear();
                    let month = String(date.getMonth() + 1).padStart(2, '0');
                    let day = String(date.getDate()).padStart(2, '0');
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

                toggleDetails(orderId) {
                    this.$set(this.orderList, orderId, !this.orderList[orderId]);
                }
            },
            mounted() {
                this.fnUserInfo();
                this.fnOrderInfo();
                
            }
        });

        app.mount("#app");
    });
</script>