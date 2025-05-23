<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 주문완료</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/cart/cart.css" />
    
    <style>

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="ordercontainer">

        <div class="order-complete">
            <h2 class="order-complete__title">주문이 완료되었습니다!</h2>
    
            <div class="order-complete__info">
                <p><strong>주문번호:</strong> {{ orderInfo.orderId }}</p>
                <p><strong>주문일시:</strong> {{ orderInfo.orderedAt }}</p>
            </div>
    
            <table class="order-complete__table">
                <thead>
                    <tr>
                        <th>상품 이미지</th>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>가격</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in orderList" :key="item.productId">
                        <td v-if="item.filepath != null"><img :src="item.filepath" width="50"></td>
                        <td v-else><img src="/img/product/product update.png" width="50"></td>
                        <td>{{ item.productName }}</td>
                        <td>{{ item.quantity }}</td>
                        <td>{{ formatPrice(item.price) }} 원</td>
                    </tr>
                </tbody>
            </table>
            <h3>총 결제 금액 : {{ formattedTotalPrice }} 원</h3>

            <div class="order-complete__shipping">
                <h3>배송 정보</h3>
                <p><strong>수령인 :</strong> {{ orderInfo.receiverName }}</p>
                <p><strong>연락처 :</strong> {{ receiverPhone }}</p>
                <p><strong>배송주소 :</strong> {{ orderInfo.receiverAddr }}</p>
            </div>
    
            <div class="order-complete__points">
                <h3>포인트 적립</h3>
                <p>이번 주문으로 적립된 포인트 : <strong>{{ formattedRewardPoints }} P</strong></p>
                <p>└　총 보유 포인트 : <strong>{{ currentPoint }} P</strong></p>
            </div>
    
            <div class="order-complete__buttons">
                <button @click="goToMain" class="order-complete__button main">메인 화면으로</button>
                <button @click="goToOrderHistory" class="order-complete__button history">주문 내역 확인</button>
            </div>
        </div>

    </div>


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userId:"${map.userId}",
                        orderId:"${map.orderId}",
                        orderInfo: {},
                        orderList: [],
                        receiverPhone:"",
                        currentPoint:0,
                    };
                },
                computed: {
                    rewardPoint(){
						const productTotal = this.orderList.reduce((sum, item) => {
						    return sum + parseInt(item.price);
						}, 0);
						return +Math.floor(productTotal * 0.05);
                    },
                    formattedRewardPoints() {
                        return this.rewardPoint.toLocaleString();
                    },
                    formattedTotalPrice(){
                        return parseInt(this.orderInfo.totalPrice).toLocaleString();
                    }
                },
                methods: {
                    fnOrderInfo:function(){
                        let self = this;
                        let params = { userId: self.userId, orderId:self.orderId };
                        $.ajax({
                            url: "/order/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: params,
                            success: function (data) {
                                self.orderInfo = data.orderInfo;
                                self.fnOrderList();
                                self.fnGetCurrentPoint();
                                self.splitPhoneNumber();
                            }
                        });
                    },
                    fnOrderList:function(){
                        let self = this;
                        let params = { userId: self.userId, orderId:self.orderId };
                        $.ajax({
                            url: "/order/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: params,
                            success: function (data) {
                                self.orderList = data.orderList;

                            }
                        });
                    },
                    fnGetCurrentPoint: function () {
                        let self = this;
                        let params = { userId: self.userId };
                        $.ajax({
                            url: "/point/current.dox",
                            dataType: "json",
                            type: "POST",
                            data: params,
                            success: function (data) {
                                self.currentPoint = parseInt(data.point.currentPoint).toLocaleString();
                            }
                        });
                    },
                    goToMain() {
                        window.location.href = "/main.do";
                    },
                    goToOrderHistory() {
                        let self = this;
                        pageChange("/order/orderList.do",{orderId:self.orderId});
                    },
                    splitPhoneNumber() {
                        let phone = this.orderInfo.receiverPhone;
                        if (phone.length === 11) {
                            this.receiverPhone = phone.slice(0, 3)+"-"+phone.slice(3, 7)+"-"+phone.slice(7, 11);
                        } else if (phone.length === 10) {
                            this.receiverPhone = phone.slice(0, 3)+"-"+phone.slice(3, 6)+"-"+phone.slice(6, 10);
                        }
                        
                    },
                    formatPrice(value) {
                        if (typeof value !== "number") return parseInt(value).toLocaleString();
                        return value.toLocaleString();
                    },
                },
                mounted() {
                    let self = this;
                    self.fnOrderInfo();
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
