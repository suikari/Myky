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

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">
        <div class="card p-4 shadow">
            <h2 class="text-center mb-4">멤버십 가입</h2>
            <ul class="list-group mb-3">
                <li class="list-group-item">✅ 일정 기간마다 무료 기부 (3,000원)</li>
                <li class="list-group-item">✅ 월 10,000 포인트 지급</li>
                <li class="list-group-item">✅ 상품 구매 시 10% 상시 할인</li>
            </ul>
            <h4 class="text-center">월 12,900원</h4>
            <button class="btn btn-primary w-100 mt-3" @click="subscribe">멤버십 가입하기</button>
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
                       
                    
                    };
                },
                computed: {

                },
                methods: {
                	subscribe() {
                        let self = this;
                    },
                    
                },
                mounted() {
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
