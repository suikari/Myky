<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멍냥꽁냥 멤버십</title>
        <script src="https://unpkg.com/vue@3"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            body {
                background-color: #fdf8f3;
                color: #333;
                font-family: "Noto Sans KR", sans-serif;
                margin: 0;
                padding: 0;
                cursor: pointer;
            }

            .container {
                max-width: 1280px;
                margin: 0 auto;
                padding: 40px 20px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                margin-bottom: 60px;
                margin-top: 60px;
            }

            /* 제목 영역 */
            .title-section {
                text-align: center;
                margin-bottom: 40px;
            }

            .title-section h2 {
                font-size: 2rem;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .title-section p {
                font-size: 1.1rem;
                line-height: 1.6;
            }

            /* 강조 색상 */
            .highlight {
                color: #ff7b54;
                font-weight: bold;
            }

            /* 혜택 카드 섹션 */
            .vip-benefit-cards {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 50px;
            }

            .vip-card {
                width: 300px;
                height: 220px;
                background-color: #ffffff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                color: #333;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                display: flex;
                flex-direction: column;
                justify-content: center;
                text-align: center;
            }

            .vip-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            }

            .vip-card h4 {
                font-size: 1.2rem;
                margin-bottom: 10px;
            }

            .vip-card p {
                font-size: 0.95rem;
                line-height: 1.5;
            }

            .membership-stats {
                text-align: center;
                margin: 50px 0 40px;
                font-size: 1rem;
                color: #555;
            }

            .membership-stats p {
                margin-bottom: 10px;
            }

            .membership-stats .highlight {
                font-size: 1.1rem;
                color: #ff7b54;
                font-weight: bold;
            }

            /* 비교 테이블 */
            .compare-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                color: #333;
                margin-bottom: 40px;
                border-radius: 8px;
                overflow: hidden;
            }

            .compare-table th,
            .compare-table td {
                border: 1px solid #ddd;
                padding: 14px;
                text-align: center;
            }

            .compare-table thead {
                background-color: #f4f4f4;
            }

            .compare-table th {
                font-weight: bold;
            }

            /* 가격/가입 버튼 */
            .price-section {
                text-align: center;
                margin-top: 30px;
            }

            .price-section h3 {
                font-size: 1.5rem;
                margin-bottom: 20px;
                color: #333;
            }

            .join-btn {
                background-color: #ff7b54;
                color: white;
                border: none;
                border-radius: 30px;
                padding: 15px 30px;
                font-size: 1.1rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .join-btn:hover {
                background-color: #e7603e;
            }

            /* FAQ 섹션 */
            .faq-section {
                background-color: #fdfaf5;
                padding: 30px 25px;
                border-radius: 12px;
                margin-top: 60px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
                color: #444;
                margin-bottom: 50px;
            }

            .faq-title {
                text-align: center;
                font-size: 1.3rem;
                font-weight: bold;
                margin-bottom: 25px;
                color: #333;
            }

            .faq-list {
                list-style: none;
                padding-left: 0;
                max-width: 800px;
                margin: 0 auto;
            }

            .faq-item {
                margin-bottom: 20px;
                font-size: 0.95rem;
                line-height: 1.6;
            }

            @media (max-width: 768px) {
                .vip-benefit-cards {
                    flex-direction: column;
                    align-items: center;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app" class="container">
            <div class="title-section">
                <h2>🎁 멍냥꽁냥 멤버십 안내</h2>
                <p>
                    반려인을 위한 <span class="highlight">프리미엄 혜택</span>,<br>
                    지금 멤버십으로 단순한 할인 그 이상! <strong>멤버십 할인 / 자동 기부 / 포인트 지급</strong><br>
                    반려 생활에 필요한 모든 혜택을 한 번에 제공합니다.
                </p>
            </div>
            <section class="vip-membership-section">
                <!-- 2. 혜택 카드 -->
                <div class="vip-benefit-cards">
                    <div class="vip-card">
                        <h4>💸 전상품 멤버십 할인가 적용</h4>
                        <p>멤버십 회원은 항상 <strong>할인된 가격</strong>으로 구매 가능합니다</p>
                    </div>
                    <div class="vip-card">
                        <h4>🌱 매월 자동 반려동물 후원</h4>
                        <p>회원님의 이름으로 <strong>기부금</strong>을 매달 보호소에 전달합니다</p>
                    </div>
                    <div class="vip-card">
                        <h4>🎉 매월 5,000포인트 지급</h4>
                        <p><strong>포인트 5,000P</strong>를 자동으로 지급받아<br>쇼핑, 게시판, 후원에 사용하세요</p>
                    </div>
                </div>

                <!-- 🔽 통계 삽입 -->
                <div class="membership-stats">
                    <p><strong class="highlight">{{ membershipUser }}</strong>명의 반려인들이 이미 멍냥꽁냥 멤버십을 이용 중이에요 🐾</p>
                    <p>지금까지 함께한 기부 금액  <strong class="highlight">₩{{ donationTotal.toLocaleString() }}</strong></p>
                </div>

                <!-- 3. 회원 vs 비회원 비교 표 -->
                <h3 style="text-align:center; margin: 50px 0 20px;">🙋‍♀️ 멤버십 가입 전 vs 후</h3>
                <table class="compare-table">
                    <thead>
                        <tr>
                            <th>혜택</th>
                            <th>비회원</th>
                            <th class="highlight">멤버십 회원</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>상품 가격</td>
                            <td>정가</td>
                            <td class="highlight">멤버십 가격 할인</td>
                        </tr>
                        <tr>
                            <td>포인트 지급</td>
                            <td>없음</td>
                            <td class="highlight">매월 5,000P</td>
                        </tr>
                        <tr>
                            <td>기부 참여</td>
                            <td>직접 후원만 가능</td>
                            <td class="highlight">월 3,000원 자동 기부</td>
                        </tr>
                    </tbody>
                </table>
                <!-- 멤버십 가입 버튼 -->
                <div class="price-section">
                    <h3>💎 월 <span class="highlight">12,900원</span></h3>
                    <button class="join-btn" @click="subscribe">지금 멤버십 가입하기</button>
                </div>
            </section>
        </div>
        <section class="faq-section-wrapper">
            <div class="faq-section">
                <h4 class="faq-title">❓ 자주 묻는 질문</h4>
                <ul class="faq-list">
                    <li class="faq-item">
                        <strong>Q. 언제든 멤버십 해지할 수 있나요?</strong><br>
                        A. 네! 마이페이지에서 언제든 즉시 해지 가능합니다. 해지 시 다음 달부터 결제되지 않습니다.
                    </li>
                    <li class="faq-item">
                        <strong>Q. 포인트는 어디에 쓸 수 있나요?</strong><br>
                        A. 쇼핑, 후원, 게시판 질문 멍냥꽁냥 내 대부분의 서비스에서 사용할 수 있습니다.
                    </li>
                </ul>
            </div>
        </section>

        <jsp:include page="/WEB-INF/common/footer.jsp" />
    </body>

    </html>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        membershipUser : 0,
                        donationTotal: 0
                    };
                },
                computed: {

                },
                methods: {
                    subscribe() {
                        alert("멤버십 가입을 처리합니다!");
                    },
                    fnMainList : function() {
                    	var self = this;
                    	var nparmap = {};
                    	$.ajax({
                    		url: "/membership/memberCnt.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("멤버십 가입자 수",data);
                                self.membershipUser = data.memberCnt;

                            }
                        });
                    },
                    fnDonation() {
                        let self = this;
                        var nparmap = {};
                        $.ajax({
                            url: "/membership/getTotalDonation.dox",
                            type: "POST",
                            dataType: "json",
                            success: function (data) {
                                console.log("기부 총액", data);
                                self.donationTotal = data.donationSum; 
                            }
                        });
                    }
                },
                mounted() {
                    let self = this;
                    self.fnMainList();
                    self.fnDonation();

                }
            });

            app.mount("#app");
        });
    </script>