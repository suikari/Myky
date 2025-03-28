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
    
    .order-history {
    max-width: 900px;
    margin: 0 auto;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.order-history__title {
    text-align: center;
    margin-bottom: 20px;
}

.order-history__filter {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}

.order-history__label {
    font-weight: bold;
}

.order-history__input {
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.order-history__button {
    padding: 8px 15px;
    border: none;
    background-color: #007bff;
    color: white;
    cursor: pointer;
    border-radius: 4px;
}

.order-history__button:hover {
    background-color: #0056b3;
}

.order-history__table {
    width: 100%;
    border-collapse: collapse;
}

.order-history__th,
.order-history__td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

.order-history__th {
    background-color: #007bff;
    color: white;
}

.order-history__track-button {
    background-color: #28a745;
    border: none;
    padding: 5px 10px;
    color: white;
    cursor: pointer;
    border-radius: 4px;
}

.order-history__track-button:hover {
    background-color: #218838;
}

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">

        <div class="order-history">
            <h2 class="order-history__title">주문 내역 조회</h2>
    
            <div class="order-history__filter">
                <label class="order-history__label" for="startDate">시작 날짜:</label>
                <input type="date" v-model="startDate" class="order-history__input">
    
                <label class="order-history__label" for="endDate">종료 날짜:</label>
                <input type="date" v-model="endDate" class="order-history__input">
    
                <button @click="fetchOrderHistory" class="order-history__button">조회</button>
            </div>
    
            <table class="order-history__table">
                <thead>
                    <tr>
                        <th class="order-history__th">주문번호</th>
                        <th class="order-history__th">주문 날짜</th>
                        <th class="order-history__th">상품명</th>
                        <th class="order-history__th">총 금액</th>
                        <th class="order-history__th">주문 상태</th>
                        <th class="order-history__th">배송 조회</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="order in orders" :key="order.orderId">
                        <td class="order-history__td">{{ order.orderId }}</td>
                        <td class="order-history__td">{{ order.orderDate }}</td>
                        <td class="order-history__td">{{ order.productName }}</td>
                        <td class="order-history__td">{{ order.totalPrice }} 원</td>
                        <td class="order-history__td">{{ order.status }}</td>
                        <td class="order-history__td">
                            <button 
                                v-if="isShippable(order.status)" 
                                @click="trackDelivery(order.orderId)" 
                                class="order-history__track-button"
                            >
                                배송 조회
                            </button>
                            <span v-else>-</span>
                        </td>
                    </tr>
                </tbody>
            </table>
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
                    startDate: "",
                    endDate: "",
                    orders: []
                
                };
            },
            computed: {

            },
            methods: {
                setDefaultDateRange() {
                    let today = new Date();
                    let threeMonthsAgo = new Date();
                    threeMonthsAgo.setMonth(today.getMonth() - 3);

                    this.startDate = this.formatDate(threeMonthsAgo);
                    this.endDate = this.formatDate(today);
                },
                formatDate(date) {
                    let year = date.getFullYear();
                    let month = String(date.getMonth() + 1).padStart(2, '0');
                    let day = String(date.getDate()).padStart(2, '0');
                    return `${year}-${month}-${day}`;
                },
                fetchOrderHistory() {
                    if (!this.startDate || !this.endDate) {
                        alert("기간을 선택해주세요.");
                        return;
                    }

                    let self = this;
                    let params = {
                        startDate: self.startDate,
                        endDate: self.endDate,
                        userId: self.$store.state.userId  // Vuex 스토어에서 사용자 ID 가져오기
                    };

                    // AJAX 요청 (예제 URL, 실제 프로젝트에 맞게 수정)
                    $.ajax({
                        url: "/order/history.dox",
                        dataType: "json",
                        type: "GET",
                        data: params,
                        success: function (response) {
                            self.orders = response.orders;
                        },
                        error: function () {
                            alert("주문 내역을 불러오는 데 실패했습니다.");
                        }
                    });
                },
                isShippable(status) {
                    return status === "배송 중" || status === "배송 완료";
                },

                // 배송 조회 (배송 추적 URL 이동)
                trackDelivery(orderId) {
                    alert(`배송 조회 페이지로 이동합니다. 주문번호: ${orderId}`);
                    window.location.href = `/delivery/track?orderId=${orderId}`;
                }
            },
            mounted() {
                
                
            }
        });

        app.mount("#app");
    });
</script>