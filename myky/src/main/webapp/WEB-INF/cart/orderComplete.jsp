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
    
    .order-complete {
        text-align: center;
        padding: 20px;
    }

    .order-info, .reward-info {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 8px;
        margin: 10px auto;
        width: 50%;
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }

    .button-group {
        margin-top: 20px;
    }

    .orderCompleteBtn {
        background: #FF8C42;
        color: white;
        border: none;
        padding: 10px 15px;
        margin: 5px;
        border-radius: 5px;
        cursor: pointer;
    }

    .orderCompleteBtn:hover {
        background: #e07b3e;
    }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">

        <div class="order-complete">
            <h2>🎉 주문이 완료되었습니다!</h2>
            <p>주문해 주셔서 감사합니다. 아래 정보를 확인해 주세요.</p>
        
            <div class="order-info">
              <h3>📦 수령인 정보</h3>
              <p><strong>이름:</strong> {{ orderInfo.receiverName }}</p>
              <p><strong>연락처:</strong> {{ orderInfo.receiverPhone }}</p>
              <p><strong>주소:</strong> {{ orderInfo.receiverAddr }}</p>
            </div>
        
            <div class="reward-info">
              <h3>💰 적립금 안내</h3>
              <p>이번 결제 금액의 <strong>5%</strong>가 적립되었습니다.</p>
              <p><strong>적립금:</strong> {{ formattedRewardPoints }} 원</p>
            </div>
        
            <div class="button-group">
              <button class="orderCompleteBtn" @click="goToMain">메인 화면으로</button>
              <button class="orderCompleteBtn" @click="goToOrderHistory">주문 내역 확인</button>
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
                        orderInfo: []
                    
                    };
                },
                computed: {
                    formattedRewardPoints() {
                        return (this.orderInfo.totalPrice * 0.05).toLocaleString();
                    },
                },
                methods: {
                    goToMain() {
                        window.location.href = "/main.do";
                    },
                    goToOrderHistory() {
                        // 주문내역으로 이동
                    },
                },
                mounted() {
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
