<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 상세보기</title>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background-color: #f5f5f5;
            }

            .container {
                max-width: 1100px;
                margin: 20px auto;
                padding: 20px;
                background: transparent;
                border-radius: 0;
                box-shadow: none;
                display: block;
                flex-wrap: wrap;
            }

            .product-detail {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                width: 100%;
            }

            .product-image-container {
                flex: 1;
                max-width: 70%;
                text-align: left;
            }

            .product-image-container img {
                width: 100%;
                max-width: 420px;
                border-radius: 8px;
                box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
            }

            .product-image-thumbNails {
                display: flex;
                justify-content: left;
                margin-top: 10px;
            }

            .product-image-thumbNails img {
                width: 55px;
                height: 55px;
                margin: 5px;
                cursor: pointer;
                border-radius: 5px;
                border: 2px solid transparent;
                transition: all 0.3s;
            }

            .product-image-thumbNails img:hover {
                border: 2px solid #28a745;
            }

            .product-info {
                flex: 1;
                max-width: 48%;
                padding: 20px;
            }

            .product-info h1 {
                font-size: 26px;
                margin-top: 10px;
                margin-bottom: 50px;
                font-weight: bold;
                color: #333;
            }

            .product-price {
                font-size: 15px;
                color: #666;
                margin-bottom: 10px;
            }

            .product-info p {
                font-size: 13px;
                color: #666;
                margin-bottom: 15px;
                font-weight: bold;
            }

            .price {
                font-size: 20px;
                font-weight: bold;
                color: #dc3545;
                margin-top: 10px;
            }

            .button-group {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .buy-btn1,
            .buy-btn2 {
                padding: 12px 20px;
                font-size: 18px;
                font-weight: bold;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 10px;
                transition: background-color 0.3s;
            }

            /* 버튼 css */
            .buy-btn1 {
                background-color: #28a745;
            }

            .buy-btn1:hover {
                background-color: #218838;
            }

            .buy-btn2 {
                background-color: #007bff;
            }

            .buy-btn2:hover {
                background-color: #0056b3;
            }


            .buy-btn:hover {
                background-color: #218838;
            }

            /* 상세보기 */
            .notice-section {
                max-width: 1000px;
                margin: 50px auto;
                /* auto로 수평 가운데 정렬 */
                padding: 20px;
                background-color: transparent;
                /* border: 1px solid #ddd;
                border-radius: 12px; */
                text-align: center;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
            }

            .notice-section2 {
                max-width: 1000px;
                margin: 50px auto;
                /* auto로 수평 가운데 정렬 */
                margin-top: 10px;
                padding: 20px;
                background-color: transparent;
                /* border: 1px solid #ddd;
                border-radius: 12px; */
                text-align: center;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
            }

            .notice-section h2 {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .notice-badge {
                display: inline-block;
                background-color: #00b894;
                color: #fff;
                font-weight: bold;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 14px;
                margin-bottom: 20px;
            }

            .notice-section .sub-text {
                color: #999;
                font-size: 14px;
                margin-top: 8px;
            }

            /* 탭 부분 */
            .tab-wrapper {
                max-width: 1100px;
                margin: 40px auto;
                font-size: 16px;
            }

            .tab-menu {
                display: flex;
                border-bottom: 1px solid #ccc;
            }

            .tab-item {
                flex: 1;
                text-align: center;
                padding: 14px 0;
                cursor: pointer;
                border: 1px solid #ccc;
                border-bottom: none;
                background-color: transparent;
                color: #888;
            }

            .tab-item.active {
                background-color: #fff;
                color: #000;
                font-weight: bold;
                border-top: 2px solid #000;
                cursor: pointer;
            }

            .tab-content {
                padding: 30px;
                min-height: 200px;
                cursor: pointer;
            }

            /* tab 4번 */
            .policy-section {
                padding: 30px;
                max-width: 1100px;
                margin: 0 auto;
            }
            .policy-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 30px 80px;
                justify-content: space-between;
            }
            .policy-box {
                flex: 1 1 45%;
                min-width: 280px;
                font-size: 15px;
                color: #444;
                line-height: 1.7;
            }
            .policy-box h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #222;
            }


            @media (max-width: 768px) {
                .product-detail {
                    flex-direction: column;
                    align-items: center;
                }

                .product-image-container,
                .product-info {
                    max-width: 100%;
                    text-align: center;
                }
            }

            @media (max-width: 768px) {

                .buy-btn1,
                .buy-btn2 {
                    width: 100%;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app" class="container">
            <!-- 상품 상세 정보 -->
            <section class="product-detail">
                <div class="product-image-container">
                    <template v-if="info.filePath">
                        <img :src="info.filePath" alt="info.fileName" id="mainImage">
                    </template>
                    <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음">
                    </template>
                    <div class="product-image-thumbNails">
                        <img v-for="(img, index) in imgList" :src="img.filePath" alt="상품 썸네일"
                            @click="changeImage(img.filePath)">
                    </div>
                </div>
                <div class="product-info">
                    <hr>
                    <h1>{{info.productName}}</h1>
                    <p class="product-price">판매가 : {{ info.price }}</p>
                    <p>제조사 : {{ info.manufacturer }}</p>
                    <p>배송비 : 2000원</p>
                    <p>상품코드 : {{ info.productCode }}</p>
                    <hr>

                    <p>
                        수량 :
                        <input type="number" v-model="quantity" min="1" style="width: 60px; text-align: center;" />
                    </p>
                    <div class="button-group">
                        <button class="buy-btn1">바로 구매</button>
                        <button class="buy-btn2">장바구니</button>
                    </div>
                </div>
            </section>

            <!-- 상세 설명 -->
            <section class="notice-section">
                <h2>NOTICE</h2>
                <div class="notice-badge">★ 배송 전 주문 취소 ★</div>
                <p>
                    평일 오후 4시 이후 주문건은 당일 출고에 해당되지 않아<br>
                    다음날 배송 지연으로 인한 취소가 불가하며,<br>
                    반품 신청 시 배송비가 부과됩니다.
                </p>
                <p class="sub-text">
                    *금요일 오후 4시 이후 주문건은 월요일 발송됩니다.
                </p>
                <p>
                    또한 운송장 번호가 확인되는 상태에서는<br>
                    상품이 택배사에 전달된 상태로 취소/변경이 어려우니 양해 부탁드립니다.
                </p>
                <p class="sub-text">
                    *택배사 전달 이후 요청 시 반품 비용으로 왕복 배송비가 발생됩니다.
                </p>
                <hr style="margin-bottom: 10px;">
            </section>
            <!-- 안내 -->
            <section class="notice-section2">
                <div class="notice-badge">★ [안내] ★</div>
                <p>
                    동일한 제품도 상황에 따라<br>
                    사료 알갱이 및 습식 제품의 색상의 차이가 있을 수 있습니다.<br>
                    해당 사유로 인한 교환 및 반품은 불가능합니다.
                </p>
                <img src="../../img/product/event.jpg" alt="사은품 증정">
            </section>
            <!-- 탭 UI -->
            <section id="tab-area" class="tab-wrapper">
                <div class="tab-menu">
                    <div v-for="(tab, index) in tabs" :key="index"
                        :class="['tab-item', { active: activeTab === index }]" @click="activeTab = index">
                        {{ tab.label }}
                    </div>
                </div>

                <div class="tab-content">
                    <div v-if="activeTab === 0">
                        <div v-html="info.description">

                        </div>
                    </div>
                    <div v-else-if="activeTab === 1">
                        <p>📝 상품후기 0개</p>
                    </div>
                    <div v-else-if="activeTab === 2">
                        <p>❓ 상품문의 0개</p>
                    </div>
                    <div v-if="activeTab === 3" class="policy-section">
                        <div class="policy-grid">
                            <div class="policy-box">
                                <h3>PAYMENT INFO</h3>
                                <p>
                                    고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수 있습니다.<br>
                                    확인 과정에서 도난 카드의 사용이나 타인의 명의의 주문등 정상적인 주문이 아니라고 판단될 경우<br>
                                    임의로 주문을 보류 또는 취소할 수 있습니다.
                                </p>
                                <p>
                                    무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹,텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.
                                </p>
                                <p>
                                    주문시 입력한 입금자명과 실제입금자의 성며이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며<br>
                                    입금되지 않은 주문은 자동취소 됩니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>DELIVERY INFO</h3>
                                <p>
                                    배송 방법 : 택배<br>
                                    배송 지역 : 전국지역<br>
                                    배송 비용 : 2000원<br>
                                    배송 기간 : 2일 ~ 5일<br>
                                    배송 안내 : 산간벽지나 도서지방은 별도의 추가금액이 발생할 수 있습니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>EXCHANGE INFO</h3>
                                <p>
                                    <strong>교환 및 반품 주소</strong><br>
                                    [10246] 인천광역시 부평구 경원대로 1366, [스테이션타워 7층] 멍냥꽁냥<br><br>

                                    <strong>교환 및 반품이 가능한 경우</strong><br>
                                    - 계약내용에 관한 서면을 받은 날부터 7일 이내<br>
                                    - 공급받은 상품 및 용역의 내용이 표시/광고 내용과 다를 경우<br><br>

                                    <strong>교환 및 반품이 불가능한 경우</strong><br>
                                    - 소비자에게 책임이 있는 사유<br>
                                    - 시간 경과에 의해 재판매가 곤란한 경우 등
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>SERVICE INFO</h3>
                                <p>
                                    - 고객센터: 1234-5678<br>
                                    - 운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00)<br>
                                    - 토/일/공휴일 휴무
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </section>

        </div>
        <jsp:include page="../common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        productId: '${map.productId}',
                        info: {},
                        imgList: [],
                        mainImage: '',
                        quantity: 1,
                        activeTab: 0, // 탭 상태
                        tabs: [
                            { label: '상세정보' },
                            { label: '상품후기 0' },
                            { label: '상품문의 0' },
                            { label: '배송/교환/환불 안내' }
                        ]
                    };
                },
                computed: {

                },
                methods: {
                    fnProduct() {
                        var self = this;
                        var nparmap = { productId: self.productId };
                        $.ajax({
                            url: '/product/get.dox',
                            dataType: 'json',
                            type: 'POST',
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.info = data.info; // 서버로부터 받은 정보로 info를 채움
                                self.imgList = data.imgList; // 이미지 리스트 받아오기
                                self.mainImage = self.info.filePath || '../../img/product/product update.png';
                            },
                        });
                    },
                    // 클릭된 이미지로 메인 이미지 변경
                    changeImage(filePath) {
                        document.getElementById('mainImage').src = filePath;
                    }
                },
                mounted() {
                    let self = this;
                    self.fnProduct();

                }
            });

            app.mount("#app");
        });
    </script>