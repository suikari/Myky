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
        .orderTable { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .orderTable th, .orderTable td {  padding: 12px; border: 1px solid #ddd; text-align: center; }
        .orderTable th { background: #f5f5f5; font-weight: bold; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">
        <h2>장바구니</h2>
        <table class="cartTable">
            <thead>
                <tr>
                    <th><input type="checkbox" @click="fnAllCheck" :checked="selectCheck.length === cartItems.length"></th>
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
                    <td><input type="checkbox" v-model="selectCheck" :value="item.productId" @change="fnCheckYn(item)"></td>
                    <td v-if="item.filepath"><img :src="item.filepath" width="50"></td>
                    <td v-else><img src="/img/product/product update.png" width="50"></td>
                    <td>{{ item.productName }}</td>
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
                    <td>{{ item.price }} 원</td>
                    <td>{{ item.quantity }}</td>
                    <td>{{ (item.price * item.quantity) }} 원</td>
                </tr>
            </tbody>
        </table>

        <h4 v-if="totalPrice < 30000">
            <span>배송비 : 2,000 원 </span>
        </h4>
        <h4 v-else>
            <span>배송비 : 무료 ! </span>
        </h4>
        <p>(30,000원 이상 무료배송)</p>
        <h2 v-if="totalPrice < 30000">
            <span>총 결제 금액: {{ formattedFinTotalShippingPrice }} 원</span>
        </h2>
        <h2 v-else>
            <span>총 결제 금액: {{ formattedTotalPrice }} 원</span>
        </h2>
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
                    cartItems: [],
                    selectCartItems: [],
                    selectCheck:[],
                    checked:false,
                    isMembership:false
                };
            },
            computed: {
                totalPrice() {
                    return this.selectCartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
                },
                totalShippingPrice() {
                    return (this.selectCartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0))+2000;
                },
                formattedTotalPrice() {
                    return this.totalPrice.toLocaleString();
                },
                formattedFinTotalShippingPrice() {
                    return this.totalShippingPrice.toLocaleString();
                },
            },
            methods: {
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
                            self.loadCart();
                            self.loadSelectCart();
                            self.fnGetMembership();
                            
                        }
                    });
                },
                loadCart() {
                    let self = this;
                    var nparmap = {
                        userId : self.userInfo.userId
                    };
                    $.ajax({
                        url: "/cart/list.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            console.log("cartList >>> ", data.list);
                            self.cartItems = data.list;
                            self.selectCheck = self.cartItems
                            .filter(item => item.checkYn === "Y")
                            .map(item => item.productId);
                            console.log(self.selectCheck);
                        }
                    });
                },
                loadSelectCart() {
                    let self = this;
                    var nparmap = {
                        userId : self.userInfo.userId
                    };
                    $.ajax({
                        url: "/cart/checkList.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            console.log("cartCheckList >>> ", data.checkList);
                            self.selectCartItems = data.checkList;
                            
                            
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
                            if(data.membership != null){
                                self.isMembership = true;
                            }
                            // 멤버십 활성 여부까지 확인 가능. html 부분 변경해야함
                        }
                    });
                },
                updateQuantity(index, change) {
                    let self = this;
                    let item = self.cartItems[index];
                    console.log("수량 변경할 상품 >>> ",item);
                    let newQuantity = Math.max(1, parseInt(item.quantity) + change);
                    
                    var nparmap = {
                        cartId: item.cartId,
                        productId: item.productId,
                        quantity: newQuantity 
                    };
                    $.ajax({
                        url: "/cart/quantity.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            self.cartItems[index].quantity = newQuantity;
                            self.loadSelectCart();
                        }
                    });
                },
                removeItem(index) {
                    let self = this;
                    let item = self.cartItems[index];

                    var nparmap = {
                        cartItemId:item.cartItemId
                    };
                    $.ajax({
                        url: "/cart/removeProduct.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) {
                            self.cartItems.splice(index, 1);
                            self.loadSelectCart();
                        }
                    });
                },
                orderItems() {
                    let self = this;
                    if (self.selectCartItems.length === 0) {
                        alert("선택된 상품이 없습니다.");
                        return;
                    }
                    alert("주문 페이지로 이동합니다.");
                    location.href = "/cart/order.do";
                },
                fnCheckYn:function(item) {
                    let self = this;
                    let checkYnValue = self.selectCheck.includes(item.productId) ? "Y" : "N";
                    console.log(checkYnValue);

                    let params = {
                        cartId: item.cartId,
                        productId: item.productId,
                        checkYn: checkYnValue
                    };

                    $.ajax({
                        url: "/cart/checkYn.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            if (data.result === "success") {
                                console.log("체크 상태 업데이트 완료: ", checkYnValue);
                                self.loadSelectCart();
                            } else {
                                console.error("체크 상태 업데이트 실패");
                            }
                        },
                        error: function () {
                            console.error("서버 오류 발생");
                        }
                    });
                },
                fnAllCheck(event) {
                    let self = this;
                    let isChecked = event.target.checked;

                    self.selectCheck = isChecked ? self.cartItems.map(item => item.productId) : [];

                    let params = {
                        checkYn: isChecked ? "Y" : "N",
                        userId: self.userInfo.userId
                    };

                    $.ajax({
                        url: "/cart/AllCheckYn.dox",
                        type: "POST",
                        data: params,
                        dataType: "json",
                        success: function (data) {
                            if (data.result === "success") {
                                console.log("모든 체크 상태 업데이트 완료: ", isChecked ? "Y" : "N");
                                self.loadSelectCart();
                            }
                        }
                    });
                }
            },
            mounted() {
                let self = this;
                self.fnUserInfo();
            }
        });

        app.mount("#app");
    });
</script>
