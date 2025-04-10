<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 장바구니</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/cart/cart.css" />
	
    <style>
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="cartContainer">
        <h2>장바구니</h2>
        <h3 v-if="cartItems.length > 0">장바구니에 담긴 상품</h3>
        <table class="cartTable" v-if="cartItems.length > 0">
            <thead>
                <tr>
                    <th><input type="checkbox" id="allCheck" ref="allCheck" @click="fnAllCheck" :checked="selectCheck.length === cartItems.length"></th>
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
                    <td v-if="item.filepath">
                        <a :href="'/product/view.do?productId=' + item.productId">
                            <img :src="item.filepath" width="50">
                        </a>
                    </td>
                    <td v-else><img src="/img/product/product update.png" width="50"></td>
                    <td>
                        <a :href="'/product/view.do?productId=' + item.productId" class="product-link">
                            {{ item.productName }}
                        </a>
                    </td>
                    <td v-if="isMembership">
                        <div><del>{{ formatPrice(item.price) }} 원</del></div>
                        <div><strong>{{ formatPrice(getDiscountPrice(item)) }} 원</strong></div>
                    </td>
                    <td v-else>{{ formatPrice(item.price) }} 원</td>
                    <td>
                        <button class="quantityBtn" @click="updateQuantity(index, -1)">-</button>
                        {{ item.quantity }}
                        <button class="quantityBtn" @click="updateQuantity(index, 1)">+</button>
                    </td>
                    <td v-if="isMembership">{{ formatPrice(getDiscountPrice(item) * item.quantity) }} 원</td>
                    <td v-else>{{ formatPrice(item.price * item.quantity) }} 원</td>
                    <td><button class="removeBtn" @click="removeItem(index)">삭제</button></td>
                </tr>
            </tbody>
        </table>
        <div v-else>
            <div class="empty-cart-message">장바구니에 담긴 상품이 없습니다.</div>
        </div>

        <div v-if="selectCartItems.length > 0">
            <h3>주문 상품</h3>
            <table class="cartOrderTable">
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
                        <td v-if="isMembership">{{ formatPrice(getDiscountPrice(item)) }} 원</td>
                        <td v-else>{{ formatPrice(item.price) }} 원</td>
                        <td>{{ item.quantity }}</td>
                        <td v-if="isMembership">{{ formatPrice(getDiscountPrice(item) * item.quantity) }} 원</td>
                        <td v-else>{{ formatPrice(item.price * item.quantity) }} 원</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div v-if="selectCartItems.length > 0">
            <h4 v-if="totalPrice < shippingFreeMinimum">
                <span>배송비 : {{ formattedShippingFee }} 원 </span>
            </h4>
            <h4 v-else>
                <span>배송비 : 무료 ! </span>
            </h4>
            <p>({{ formatPrice(shippingFreeMinimum) }}원 이상 무료배송)</p>
            <h2 v-if="totalPrice < shippingFreeMinimum">
                <span>총 결제 금액: {{ formattedFinalPrice }} 원</span>
            </h2>
            <h2 v-else>
                <span>총 결제 금액: {{ formattedTotalPrice }} 원</span>
            </h2>
            <div class="btnDisplay">
                <button class="cartOrderBtn" @click="orderItems">주문하기</button>
            </div>
        </div>
        <div class="btnDisplay" v-else>
            <button class="cartOrderBtn" @click="goToProductPage">쇼핑하러 가기</button>
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
                    sessionId:"${sessionId}",
                    userInfo:{},
                    cartItems: [],
                    selectCartItems: [],
                    selectCheck:[],
                    checked:false,
                    isMembership:false,
                    shippingFee:2000,
                    shippingFreeMinimum:30000
                };
            },
            computed: {
                totalPrice() {
                    return this.selectCartItems.reduce((sum, item) => sum + this.getTotalPrice(item), 0);
                },
                finalPrice() {
                    return this.totalPrice >= this.shippingFreeMinimum ? this.totalPrice : parseInt(this.totalPrice) + parseInt(this.shippingFee);
                },
                formattedShippingFee() {
                    return this.totalPrice >= this.shippingFreeMinimum ? "0" : parseInt(this.shippingFee).toLocaleString();
                },
                formattedTotalPrice() {
                    return this.totalPrice.toLocaleString();
                },
                formattedFinalPrice() {
                    return this.finalPrice.toLocaleString();
                }
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

                            self.$nextTick(() => {
                                self.fnAllCheck({
                                    target: {
                                        checked: true
                                    }
                                });
                            });
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
                            if (self.selectCartItems.length > 0) {
                                self.shippingFee = self.selectCartItems[0].shippingFee;
                                self.shippingFreeMinimum = self.selectCartItems[0].shippingFreeMinimum;
                            }

                            console.log("shippingFee:", self.shippingFee);
                            console.log("shippingFreeMinimum:", self.shippingFreeMinimum);
                            
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
                getDiscountPrice(item) {
                    if (!item.discount || item.discount === 0) return item.price;
                    return Math.floor(item.price * (1 - item.discount / 100));
                },
                getTotalPrice(item) {
                    return item.quantity * (this.isMembership ? this.getDiscountPrice(item) : item.price);
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
                },
                formatPrice(value) {
                    if (typeof value !== "number") return parseInt(value).toLocaleString();
                    return value.toLocaleString();
                },
                goToProductPage(){
                    window.location.href = "/product/list.do";
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
