<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멍냥꽁냥 멤버십 소개</title>
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

            /* 멤버십 가입 방법 */
            .membership-steps {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-wrap: wrap;
                gap: 10px;
            }

            .step-wrap {
                display: flex;
                align-items: center;
            }

            .step {
                text-align: center;
                padding: 10px;
                min-width: 160px;
            }

            .step-number {
                color: #2980b9;
                font-size: 15px;
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            .step h4 {
                font-size: 16x;
                margin: 5px 0px;
            }

            .step img {
                width: 60px;
                height: 60px;
                margin: 10px 0;
            }

            .step p {
                font-size: 13px;
                color: #444;
            }

            .arrow {
                font-size: 24px;
                color: #ccc;
                margin: 0 10px;
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

            .tips-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0 6px;
                margin-top: 50px;
                cursor: pointer;
            }

            .tips-title {
                font-weight: bold;
                color: black;
                font-size: 1rem;
            }

            .tips-toggle-btn {
                background: none;
                border: none;
                color: #333;
                font-size: 1.3rem;
                cursor: pointer;
                transition: color 0.2s ease;
            }

            .tips-toggle-btn:hover {
                color: #ff7b54;
            }

            .tips-divider {
                border: none;
                height: 1px;
                background-color: #ccc;
                margin: 0 0 20px;
            }

            .tips-box {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px 25px;
                color: #444;
                font-size: 0.95rem;
                line-height: 1.6;
                margin-bottom: 40px;
            }

            .tips-box ul {
                list-style: disc;
                padding-left: 20px;
                margin: 0;
            }

            .tips-box li {
                margin-bottom: 8px;
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
                    <p>현재 총 <strong class="highlight">{{ totalUserCnt }}</strong>명의 회원이 함께하고 있어요!</p>
                    <p>💖 멍냥꽁냥 전체 유저들의 누적 기부 금액은
                        <strong class="highlight">{{ uDonationTotal.toLocaleString() }}원</strong>입니다!
                    </p>
                    <p><strong class="highlight">{{ membershipUser }}</strong>명의 멤버십 반려인들이 이미 멍냥꽁냥 멤버십을 이용 중이에요 🐾</p>
                    <p>🙌 멤버십 회원님들과 함께한 기부 금액
                        <strong class="highlight">{{ mDonationTotal.toLocaleString() }}원</strong>입니다!
                    </p>
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
                <!-- Tips 안내사항 영역 -->
                <div class="tips-header">
                    <span class="tips-title" @click="toggleTips">💡 Tips</span>
                    <span class="tips-toggle-btn" @click="toggleTips"> {{ showTips ? '－' : '＋' }} </span>
                </div>
                <hr class="tips-divider">
                <div v-if="showTips" class="tips-box">
                    <ul>
                        <li>구독 신청과 동시에 1회차 결제가 이뤄집니다. 구독 중에 상품이나 옵션 변경은 불가하며, 수량 변경은 가능합니다.</li>
                        <li>첫 구독 가입 포인트 지급은 아이당 1회 제공됩니다.</li>
                        <li>구독상품은 결제 시 적립금이나 쿠폰 사용이 불가합니다.</li>
                    </ul>
                </div>

                <div class="membership-steps">
                    <div class="step-wrap">
                        <div class="step">
                            <span class="step-number">STEP. 01</span>
                            <h4>멤버십 가입 클릭</h4>
                            <img src="../../img/product/Join.png" alt="가입 버튼">
                            <p>멍냥꽁냥에서 멤버십 가입을 클릭합니다.</p>
                        </div>
                        <div class="arrow">➤</div>
                    </div>

                    <div class="step-wrap">
                        <div class="step">
                            <span class="step-number">STEP. 02</span>
                            <h4>약관 및 개인정보 관련 동의</h4>
                            <img src="../../img/product/Terms of Use.png" alt="약관 동의">
                            <p>가입 약관 및 개인정보 관련 규정에 동의합니다.</p>
                        </div>
                        <div class="arrow">➤</div>
                    </div>

                    <div class="step-wrap">
                        <div class="step">
                            <span class="step-number">STEP. 03</span>
                            <h4>회원정보 확인</h4>
                            <img src="../../img/product/Identity.png" alt="본인확인">
                            <p>가입에 필요한 회원정보를 확인합니다.</p>
                        </div>
                        <div class="arrow">➤</div>
                    </div>

                    <div class="step-wrap">
                        <div class="step">
                            <span class="step-number">STEP. 04</span>
                            <h4>가입 완료되었습니다</h4>
                            <img src="../../img/product/Okay.png" alt="가입 완료">
                            <p>멤버십 회원가입 완료.</p>
                        </div>
                    </div>
                </div>


                <!-- 멤버십 가입 버튼 -->
                <div class="price-section">
                    <h3>💎 월 <span class="highlight">12,900원</span></h3>
                    <button class="join-btn" @click="subscribe">멤버십 가입하기</button>
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
                        membershipUser: 0, //멤버십 유지 중인 유저 회원수
                        mDonationTotal: 0,  //멤버십 유저가 기부한 금액
                        totalUserCnt: 0,   //전체 회원 수
                        uDonationTotal: 0, //유저 전체 기부금
                        showTips: true,   //안내사항 토글
                    };
                },
                computed: {

                },
                methods: {
                    toggleTips() {
                        this.showTips = !this.showTips;
                    },
                    //멤버십
                    subscribe() {
                        alert("멤버십 가입 페이지로 이동!");
                        location.href = "/membership/terms.do";
                    },
                    //전제 회원 수 
                    fnTotalUserCnt() {
                        let self = this;
                        $.ajax({
                            url: "/membership/getTotalUserCnt.dox",
                            type: "POST",
                            dataType: "json",
                            success: function (data) {
                                console.log("전체 유저 수", data);
                                self.totalUserCnt = data.totalUserCnt;
                            }
                        });
                    },
                    //유저 전체 기부금
                    fnTotalDonation() {
                        let self = this;
                        $.ajax({
                            url: "/membership/getUserTotalDonation.dox",
                            type: "POST",
                            dataType: "json",
                            success: function (data) {
                                console.log("전체 유저 기부 총액", data);
                                self.uDonationTotal = data.userDonationSum;
                            }
                        });
                    },
                    //멤버십 가입 유저수 
                    fnMainList: function () {
                        var self = this;
                        var nparmap = {};
                        $.ajax({
                            url: "/membership/memberCnt.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멤버십 가입자 수", data);
                                self.membershipUser = data.memberCnt;
                            }
                        });
                    },
                    //멤버십 회원 기부금
                    fnDonation() {
                        let self = this;
                        var nparmap = {};
                        $.ajax({
                            url: "/membership/getMembershipDonation.dox",
                            type: "POST",
                            dataType: "json",
                            success: function (data) {
                                console.log("멤버십 회원 기부 총액", data);
                                self.mDonationTotal = data.membershipDonationSum;
                            }
                        });
                    },
                },
                mounted() {
                    let self = this;
                    self.fnMainList();
                    self.fnDonation();
                    self.fnTotalDonation();
                    self.fnTotalUserCnt();
                }
            });

            app.mount("#app");
        });
    </script>