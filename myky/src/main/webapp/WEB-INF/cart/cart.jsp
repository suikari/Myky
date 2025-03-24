<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 장바구니</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
        .container { max-width: 900px; margin: auto; padding: 20px; }
        h2 { text-align: center; }
        .cartTable { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .cartTable th, .cartTable td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        .cartTable th { background: #f5f5f5; }
        .quantityBtn { cursor: pointer; padding: 5px 10px; }
        .removeBtn { background: red; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .orderBtn { width: 100%; padding: 10px; background: #FF8C42; color: white; font-size: 16px; border: none; cursor: pointer; margin-top: 20px; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">
        <h2>🛒 장바구니</h2>
        <table class="cartTable">
            <thead>
                <tr>
                    <th>상품 이미지</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>총 금액</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(item, index) in cartItems" :key="item.productId">
                    <td><img :src="item.image" width="50"></td>
                    <td>{{ item.name }}</td>
                    <td>{{ item.price }} 원</td>
                    <td>
                        <button class="quantityBtn" @click="updateQuantity(index, -1)">-</button>
                        {{ item.quantity }}
                        <button class="quantityBtn" @click="updateQuantity(index, 1)">+</button>
                    </td>
                    <td>{{ (item.price * item.quantity) }} 원</td>
                    <td><button class="removeBtn" @click="removeItem(index)">삭제</button></td>
                </tr>
            </tbody>
        </table>

        <h3>총 결제 금액: {{ totalPrice }} 원</h3>
        <button class="orderBtn" @click="orderItems">주문하기</button>
    </div>


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
                        cartItems: []
                    
                    };
                },
                computed: {
                    
                },
                methods: {
                    loadCart() {
                        let self = this;
                        var nparmap = {
                            userId : self.sessionId
                        };
                        $.ajax({
                            url: "/cart/list.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) { 
                                console.log("cartList >>> ", data.list);
                                self.cartItems = data.list;
                                
                            }
                        });
                    },
                    fnUserInfo(){
                        var self = this;
                        console.log("sessionId >>> ", self.sessionId);
                        var nparmap = {
                            userId : self.sessionId
                        };
                        $.ajax({
                            url:"/user/info.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) { 
                                console.log("userInfo >>> ", data.user);
                                self.userInfo = data.user;
                                
                            }
                        });
                    },
                    updateQuantity(index, change) {
                        let self = this;
                        let item = self.cartItems[index];
                        let newQuantity = item.quantity + change;
                        if (newQuantity < 1) return;

                        $.ajax({
                            url: "/cart/update.dox",
                            method: "POST",
                            data: { productId: item.productId, quantity: newQuantity },
                            success: () => {
                                self.cartItems[index].quantity = newQuantity;
                            }
                        });
                    },
                    removeItem(index) {
                        let self = this;
                        let item = self.cartItems[index];
                        $.ajax({
                            url: "/cart/delete.dox",
                            method: "POST",
                            data: { productId: item.productId },
                            success: () => {
                                self.cartItems.splice(index, 1);
                            }
                        });
                    },
                    orderItems() {
                        let self = this;
                        if (self.cartItems.length === 0) {
                            alert("장바구니가 비어 있습니다.");
                            return;
                        }
                        alert("주문 페이지로 이동합니다.");
                        location.href = "/order/checkout.jsp";
                    }
                },
                mounted() {
                	let self = this;
                	self.loadCart();
                    self.fnUserInfo();
                }
            });

            app.mount("#app");
        });
    </script>
